import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/services/backend_api_service.dart';
import '../../providers/app_state_provider.dart';
import '../../widgets/shiva_point_of_light_widget.dart';

class SpiritualJournalScreen extends StatefulWidget {
  const SpiritualJournalScreen({super.key});

  @override
  State<SpiritualJournalScreen> createState() => _SpiritualJournalScreenState();
}

class _SpiritualJournalScreenState extends State<SpiritualJournalScreen> {
  final String _today = DateTime.now().toIso8601String().substring(0, 10);
  bool _amritvelaDone = true;
  int _amritvelaMinutes = 45;
  bool _murliStudied = true;
  int _trafficControlCount = 4;
  int _speechPurityRating = 5;
  int _sevaRating = 4;
  final TextEditingController _notesController = TextEditingController();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadTodayChart();
  }

  Future<void> _loadTodayChart() async {
    final chart = await BackendApiService.getChartForDate(_today);
    if (chart != null && mounted) {
      setState(() {
        _amritvelaDone = chart['amritvelaDone'] ?? true;
        _amritvelaMinutes = chart['amritvelaMinutes'] ?? 45;
        _murliStudied = chart['murliStudied'] ?? true;
        _trafficControlCount = chart['trafficControlCount'] ?? 4;
        _speechPurityRating = chart['speechPurityRating'] ?? 5;
        _sevaRating = chart['sevaRating'] ?? 4;
        _notesController.text = chart['notes'] ?? '';
      });
    }
  }

  Future<void> _saveChart() async {
    setState(() => _isSaving = true);
    final data = {
      'date': _today,
      'amritvelaDone': _amritvelaDone,
      'amritvelaMinutes': _amritvelaMinutes,
      'murliStudied': _murliStudied,
      'trafficControlCount': _trafficControlCount,
      'speechPurityRating': _speechPurityRating,
      'sevaRating': _sevaRating,
      'notes': _notesController.text.trim(),
    };
    await BackendApiService.saveChartForDate(_today, data);
    if (mounted) {
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('दैनिक चार्ट सुरक्षित कर लिया गया है (Chart Saved)'),
          backgroundColor: AppColors.primary,
        ),
      );
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isHindi = appState.languageCode == 'hi';

    // Calculate score
    final score = (_amritvelaDone ? 25 : 0) +
        (_murliStudied ? 25 : 0) +
        (_trafficControlCount * 4) +
        (_speechPurityRating * 3) +
        (_sevaRating * 3);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Row(
          children: [
            const ShivaPointOfLightWidget(size: 24, animate: true),
            const SizedBox(width: 8),
            Text(
              isHindi ? 'दैनिक पुरुषार्थ चार्ट' : 'Daily Spiritual Chart',
              style: AppTypography.titleMedium(isDark: isDark).copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Overall Score Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppColors.paramdhamGradient,
                  borderRadius: AppSpacing.roundedLg,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(70),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isHindi ? 'आज का पुरुषार्थ स्तर' : 'TODAY\'S SPIRITUAL PURUSHARTH',
                            style: AppTypography.labelSmall(isDark: true).copyWith(
                              color: const Color(0xFFFDE68A),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            isHindi ? 'अमृतवेला से रात्रि तक की साधना' : 'Self-Sovereignty Score',
                            style: AppTypography.titleMedium(isDark: true).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isHindi ? 'तारीख: $_today' : 'Date: $_today',
                            style: AppTypography.bodySmall(isDark: true).copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(35),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFFDE68A), width: 2),
                      ),
                      child: Center(
                        child: Text(
                          '$score%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 2. Amritvela Meditation Check
              _buildSwitchCard(
                title: isHindi ? '1. अमृतवेला योग (04:00 - 04:45 AM)' : '1. Amritvela Meditation (Dawn Silence)',
                subtitle: isHindi ? 'परमपिता परमात्मा के प्यार और शक्ति में लीन' : 'Communion with Supreme Soul in stillness',
                value: _amritvelaDone,
                onChanged: (v) => setState(() => _amritvelaDone = v),
                icon: Icons.wb_twilight_rounded,
                iconColor: AppColors.amberGold,
                isDark: isDark,
              ),
              const SizedBox(height: 12),

              // 3. Daily Murli Study Check
              _buildSwitchCard(
                title: isHindi ? '2. दैनिक मुरली अध्ययन व चिंतन' : '2. Daily Murli Study & Churning',
                subtitle: isHindi ? 'ईश्वरीय महावाक्यों को जीवन में धारण करना' : 'Absorbed the teachings of the day',
                value: _murliStudied,
                onChanged: (v) => setState(() => _murliStudied = v),
                icon: Icons.menu_book_rounded,
                iconColor: AppColors.primary,
                isDark: isDark,
              ),
              const SizedBox(height: 12),

              // 4. Traffic Control Silent Pauses
              _buildTrafficControlCard(isDark, isHindi),
              const SizedBox(height: 12),

              // 5. Pure Drishti & Sweet Speech Rating
              _buildRatingCard(
                title: isHindi ? '4. दृष्टि व बोल में मधुरता (Purity in Words)' : '4. Sweetness & Pure Drishti',
                subtitle: isHindi ? 'किसी भी आत्मा को दुख न देकर सुखदाई बनना' : 'Spoke kindly, maintained good feelings',
                rating: _speechPurityRating,
                onChanged: (r) => setState(() => _speechPurityRating = r),
                icon: Icons.record_voice_over_rounded,
                isDark: isDark,
              ),
              const SizedBox(height: 12),

              // 6. Good Deeds & Seva Rating
              _buildRatingCard(
                title: isHindi ? '5. निस्वार्थ सेवा व शुभ-भावना' : '5. Selfless Service (Manasa / Vacha / Karmana)',
                subtitle: isHindi ? 'मंसा द्वारा शांति फैलाना व कर्म द्वारा सहयोग' : 'Radiated peaceful vibrations and helped others',
                rating: _sevaRating,
                onChanged: (r) => setState(() => _sevaRating = r),
                icon: Icons.volunteer_activism_rounded,
                isDark: isDark,
              ),
              const SizedBox(height: 16),

              // 7. Personal Realizations & Surrender Note
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  borderRadius: AppSpacing.roundedLg,
                  border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isHindi ? 'रात्रि पोतामेल (Night Surrender Note)' : 'Night Self-Reflection Note',
                      style: AppTypography.titleSmall(isDark: isDark).copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isHindi ? 'दिनभर की भूलें व सफलताएं परमात्मा के सम्मुख रखें:' : 'Surrender any mistakes and express gratitude to God:',
                      style: AppTypography.bodySmall(isDark: isDark),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _notesController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: isHindi ? 'यहाँ अपने विचार लिखें...' : 'Write your notes here...',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _isSaving ? null : _saveChart,
                  icon: _isSaving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.check_circle_rounded),
                  label: Text(
                    isHindi ? 'आज का चार्ट सुरक्षित करें' : 'Save Daily Chart',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchCard({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
    required Color iconColor,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: AppSpacing.roundedLg,
        border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withAlpha(25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.titleSmall(isDark: isDark).copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: AppTypography.bodySmall(isDark: isDark).copyWith(
                    color: AppColors.textTertiaryLight,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeThumbColor: AppColors.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildTrafficControlCard(bool isDark, bool isHindi) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: AppSpacing.roundedLg,
        border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withAlpha(25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.traffic_rounded, color: AppColors.secondary, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isHindi ? '3. ट्रैफिक कंट्रोल (शांत विराम)' : '3. Traffic Control Pauses (5 Times)',
                      style: AppTypography.titleSmall(isDark: isDark).copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      isHindi ? 'दिनभर में 2 मिनट के मौन क्षण' : 'Observed 2-minute stillness breaks',
                      style: AppTypography.bodySmall(isDark: isDark).copyWith(
                        color: AppColors.textTertiaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (index) {
              final count = index + 1;
              final isDone = count <= _trafficControlCount;
              return InkWell(
                onTap: () => setState(() => _trafficControlCount = count),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 48,
                  height: 38,
                  decoration: BoxDecoration(
                    color: isDone ? AppColors.primary : (isDark ? Colors.white12 : AppColors.primaryContainer),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      '$count बार',
                      style: TextStyle(
                        color: isDone ? Colors.white : AppColors.primaryDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingCard({
    required String title,
    required String subtitle,
    required int rating,
    required ValueChanged<int> onChanged,
    required IconData icon,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: AppSpacing.roundedLg,
        border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.titleSmall(isDark: isDark).copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: AppTypography.bodySmall(isDark: isDark).copyWith(
              color: AppColors.textTertiaryLight,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(5, (index) {
              final star = index + 1;
              return IconButton(
                padding: const EdgeInsets.only(right: 6),
                constraints: const BoxConstraints(),
                icon: Icon(
                  star <= rating ? Icons.star_rounded : Icons.star_border_rounded,
                  color: const Color(0xFFF59E0B),
                  size: 28,
                ),
                onPressed: () => onChanged(star),
              );
            }),
          ),
        ],
      ),
    );
  }
}
