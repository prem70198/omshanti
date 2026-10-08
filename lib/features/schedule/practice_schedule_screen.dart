import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../providers/app_state_provider.dart';
import '../../providers/schedule_provider.dart';

class PracticeScheduleScreen extends StatelessWidget {
  const PracticeScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = context.watch<ScheduleProvider>();
    final appState = context.watch<AppStateProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isHindi = appState.languageCode == 'hi';

    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final daysHi = ['सोम', 'मंगल', 'बुध', 'गुरु', 'शुक्र', 'शनि', 'रवि'];

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          isHindi ? 'दैनिक साधना दिनचर्या' : 'Daily Practice Routine',
          style: AppTypography.titleLarge(isDark: isDark).copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Days of the week horizontal selector
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 7,
                itemBuilder: (context, index) {
                  final dayIndex = index + 1;
                  final isSelected = scheduleProvider.selectedDayIndex == dayIndex;
                  return GestureDetector(
                    onTap: () => scheduleProvider.setSelectedDay(dayIndex),
                    child: Container(
                      width: 52,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isDark ? AppColors.primaryLight : AppColors.primary)
                            : (isDark ? AppColors.surfaceDark : Colors.white),
                        borderRadius: AppSpacing.roundedMd,
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : (isDark ? AppColors.borderDark : AppColors.borderLight),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isHindi ? daysHi[index] : days[index],
                            style: AppTypography.labelSmall(isDark: isSelected ? true : isDark).copyWith(
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? Colors.white : null,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected ? const Color(0xFFFBBF24) : Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Progress Summary Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: AppColors.sereneGradient,
                  borderRadius: AppSpacing.roundedLg,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isHindi ? 'आज का लक्ष्य' : 'Daily Spiritual Target',
                          style: AppTypography.labelSmall(isDark: true).copyWith(
                            color: const Color(0xFFFDE68A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${scheduleProvider.completedTodayCount} of ${scheduleProvider.totalTodayCount} Completed',
                          style: AppTypography.titleMedium(isDark: true).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    CircularProgressIndicator(
                      value: scheduleProvider.totalTodayCount > 0
                          ? scheduleProvider.completedTodayCount / scheduleProvider.totalTodayCount
                          : 0.0,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFBBF24)),
                      strokeWidth: 4,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Schedules List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: scheduleProvider.filteredSchedules.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = scheduleProvider.filteredSchedules[index];
                  final title = isHindi ? item.titleHi : item.title;

                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : Colors.white,
                      borderRadius: AppSpacing.roundedLg,
                      border: Border.all(
                        color: isDark ? AppColors.borderDark : AppColors.borderLight,
                      ),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: item.isCompletedToday,
                          activeColor: AppColors.success,
                          onChanged: (_) => scheduleProvider.toggleCompletion(item.id),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: AppTypography.titleSmall(isDark: isDark).copyWith(
                                  fontWeight: FontWeight.bold,
                                  decoration: item.isCompletedToday ? TextDecoration.lineThrough : null,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.access_time_filled_rounded,
                                      size: 14, color: AppColors.primaryLight),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${item.timeString} • ${item.durationMinutes} mins',
                                    style: AppTypography.bodySmall(isDark: isDark),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            item.isReminderEnabled ? Icons.notifications_active_rounded : Icons.notifications_off_outlined,
                            color: item.isReminderEnabled ? const Color(0xFFF59E0B) : Colors.grey,
                            size: 20,
                          ),
                          onPressed: () => scheduleProvider.toggleReminder(item.id),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
