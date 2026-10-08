import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../models/chat_message.dart';
import '../../providers/app_state_provider.dart';
import '../../providers/live_session_provider.dart';

class LiveRoomScreen extends StatefulWidget {
  const LiveRoomScreen({super.key});

  @override
  State<LiveRoomScreen> createState() => _LiveRoomScreenState();
}

class _LiveRoomScreenState extends State<LiveRoomScreen> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    if (_chatController.text.trim().isEmpty) return;
    final userName = context.read<AppStateProvider>().currentUser.name;
    context.read<LiveSessionProvider>().sendLiveChatMessage(_chatController.text.trim(), userName);
    _chatController.clear();

    Future.delayed(const Duration(milliseconds: 100), () {
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
    _chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final live = context.watch<LiveSessionProvider>();
    final session = live.activeRoomSession ?? live.liveNowSession;

    if (session == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('No active broadcast')),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0F0E17),
      body: SafeArea(
        child: Column(
          children: [
            // Video / Broadcast Stream Simulation
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 240,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1E1B4B), Color(0xFF3B1261)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withAlpha(30),
                            border: Border.all(color: const Color(0xFFFBBF24), width: 1.5),
                          ),
                          child: const Icon(Icons.videocam_rounded, color: Color(0xFFFDE68A), size: 36),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          session.hostName,
                          style: AppTypography.titleMedium(isDark: true).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${session.centerName} (Live Transmission)',
                          style: AppTypography.bodySmall(isDark: true).copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Top Floating Actions
                Positioned(
                  top: 8,
                  left: 8,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                    onPressed: () {
                      live.leaveLiveRoom();
                      Navigator.pop(context);
                    },
                  ),
                ),
                Positioned(
                  top: 14,
                  right: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.liveRed,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.sensors_rounded, size: 14, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          '${session.participantCount} Online',
                          style: AppTypography.labelSmall(isDark: true).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Live Room Title & Raise Hand Button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: const Color(0xFF1A1829),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      session.title,
                      style: AppTypography.titleSmall(isDark: true).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: live.isHandRaised ? AppColors.accentSunrise : const Color(0xFF374151),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    ),
                    onPressed: () => live.toggleRaiseHand(),
                    icon: Icon(
                      live.isHandRaised ? Icons.pan_tool_rounded : Icons.pan_tool_outlined,
                      size: 16,
                      color: live.isHandRaised ? Colors.white : const Color(0xFFFBBF24),
                    ),
                    label: Text(live.isHandRaised ? 'Hand Raised' : 'Ask/Blessing'),
                  ),
                ],
              ),
            ),

            // Live Prayers & Vibrations Chat
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: live.liveChatMessages.length,
                itemBuilder: (context, index) {
                  final msg = live.liveChatMessages[index];
                  final isHost = msg.senderType == ChatSenderType.liveHost;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isHost ? const Color(0xFF3B1261) : const Color(0xFF262338),
                      borderRadius: BorderRadius.circular(12),
                      border: isHost ? Border.all(color: AppColors.primaryLight) : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              msg.senderName,
                              style: AppTypography.labelSmall(isDark: true).copyWith(
                                color: isHost ? const Color(0xFFFBBF24) : const Color(0xFFDDD6FE),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (isHost)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryLight,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'HOST',
                                  style: AppTypography.labelSmall(isDark: true).copyWith(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          msg.text,
                          style: AppTypography.bodySmall(isDark: true).copyWith(
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Chat Input Box
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: const Color(0xFF1A1829),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _chatController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Share peace vibration or prayer...',
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: const Color(0xFF262338),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send_rounded, color: Color(0xFFFBBF24)),
                    onPressed: _sendMessage,
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
