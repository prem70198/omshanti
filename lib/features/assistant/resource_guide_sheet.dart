import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../models/chat_message.dart';
import '../../providers/ai_guide_provider.dart';
import '../../providers/app_state_provider.dart';

class ResourceGuideSheet extends StatefulWidget {
  const ResourceGuideSheet({super.key});

  @override
  State<ResourceGuideSheet> createState() => _ResourceGuideSheetState();
}

class _ResourceGuideSheetState extends State<ResourceGuideSheet> {
  final TextEditingController _queryController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<String> _quickPrompts = [
    'How to calm wandering thoughts?',
    'Where do I start as a beginner?',
    'What is the meaning of Om Shanti?',
    'Help me fall asleep peacefully',
  ];

  void _submitQuery(String text) {
    if (text.trim().isEmpty) return;
    final lang = context.read<AppStateProvider>().languageCode;
    context.read<AiGuideProvider>().sendMessage(text.trim(), lang);
    _queryController.clear();

    Future.delayed(const Duration(milliseconds: 150), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _queryController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ai = context.watch<AiGuideProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(80),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: AppColors.auraGradient,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Spiritual AI Guide',
                          style: AppTypography.titleSmall(isDark: isDark).copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Guided by ancient wisdom & Rajyoga philosophy',
                          style: AppTypography.bodySmall(isDark: isDark),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Quick Prompts row
            Container(
              height: 44,
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _quickPrompts.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return ActionChip(
                    label: Text(_quickPrompts[index]),
                    labelStyle: AppTypography.labelSmall(isDark: isDark),
                    onPressed: () => _submitQuery(_quickPrompts[index]),
                  );
                },
              ),
            ),

            // Messages
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: ai.messages.length,
                itemBuilder: (context, index) {
                  final msg = ai.messages[index];
                  final isUser = msg.senderType == ChatSenderType.user;

                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.82),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isUser
                            ? (isDark ? AppColors.primaryLight : AppColors.primary)
                            : (isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight),
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: isUser ? const Radius.circular(16) : const Radius.circular(4),
                          bottomRight: isUser ? const Radius.circular(4) : const Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            msg.text,
                            style: AppTypography.bodyMedium(isDark: isUser ? true : isDark).copyWith(
                              color: isUser ? Colors.white : null,
                            ),
                          ),
                          if (msg.resourceActionTitle != null) ...[
                            const SizedBox(height: 10),
                            FilledButton.tonalIcon(
                              onPressed: () {
                                Navigator.pop(context);
                                if (msg.resourceActionRoute != null) {
                                  Navigator.pushNamed(context, msg.resourceActionRoute!);
                                }
                              },
                              icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                              label: Text(msg.resourceActionTitle!),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            if (ai.isTyping)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'AI Guide is contemplating...',
                      style: AppTypography.bodySmall(isDark: isDark),
                    ),
                  ],
                ),
              ),

            // Text Input
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _queryController,
                      decoration: InputDecoration(
                        hintText: 'Ask about meditation, karma, soul...',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onSubmitted: _submitQuery,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send_rounded, color: AppColors.primary),
                    onPressed: () => _submitQuery(_queryController.text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
