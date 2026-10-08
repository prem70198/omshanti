import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../providers/app_state_provider.dart';
import '../../providers/learning_provider.dart';

class LearningJourneyScreen extends StatelessWidget {
  const LearningJourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final learning = context.watch<LearningProvider>();
    final appState = context.watch<AppStateProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isHindi = appState.languageCode == 'hi';

    final course = learning.course;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          isHindi ? course.titleHi : course.title,
          style: AppTypography.titleLarge(isDark: isDark).copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course Progress Overview Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppColors.sereneGradient,
                  borderRadius: AppSpacing.roundedLg,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(60),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isHindi ? 'आपकी प्रगति' : 'YOUR SPIRITUAL PROGRESS',
                          style: AppTypography.labelSmall(isDark: true).copyWith(
                            color: const Color(0xFFFDE68A),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        Text(
                          '${(learning.progressPercentage * 100).toInt()}%',
                          style: AppTypography.titleMedium(isDark: true).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: learning.progressPercentage,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFBBF24)),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${learning.completedCount} of ${learning.totalLessons} ${isHindi ? 'अध्याय पूर्ण' : 'lessons completed'}',
                      style: AppTypography.bodySmall(isDark: true).copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Text(
                isHindi ? '7 दिवसीय राजयोग पाठ' : '7 Days of Wisdom Stepper',
                style: AppTypography.titleMedium(isDark: isDark).copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Lessons List Stepper
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: course.lessons.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final lesson = course.lessons[index];
                  final title = isHindi ? lesson.titleHi : lesson.title;
                  final subtitle = isHindi ? lesson.subtitleHi : lesson.subtitle;
                  final content = isHindi ? lesson.contentHi : lesson.content;

                  return Container(
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : Colors.white,
                      borderRadius: AppSpacing.roundedLg,
                      border: Border.all(
                        color: lesson.isCompleted
                            ? AppColors.success.withAlpha(120)
                            : (isDark ? AppColors.borderDark : AppColors.borderLight),
                      ),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        leading: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: lesson.isCompleted
                                ? AppColors.success
                                : (isDark ? AppColors.surfaceVariantDark : AppColors.primaryContainer),
                          ),
                          child: Center(
                            child: lesson.isCompleted
                                ? const Icon(Icons.check_rounded, color: Colors.white, size: 20)
                                : Text(
                                    '${lesson.dayNumber}',
                                    style: AppTypography.labelLarge(isDark: false).copyWith(
                                      color: AppColors.primaryDark,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                        title: Text(
                          'Day ${lesson.dayNumber}: $title',
                          style: AppTypography.titleSmall(isDark: isDark).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          subtitle,
                          style: AppTypography.bodySmall(isDark: isDark),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  content,
                                  style: AppTypography.bodyMedium(isDark: isDark).copyWith(
                                    height: 1.6,
                                  ),
                                ),
                                const SizedBox(height: 14),

                                // Contemplation Box
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isDark ? const Color(0xFF1E293B) : const Color(0xFFFEF3C7),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.lightbulb_outline_rounded,
                                          color: Color(0xFFD97706), size: 20),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          isHindi ? lesson.keyTakeawayHi : lesson.keyTakeaway,
                                          style: AppTypography.bodySmall(isDark: isDark).copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 14),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: lesson.isCompleted ? Colors.grey : AppColors.primary,
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      learning.completeLesson(lesson.dayNumber);
                                    },
                                    icon: Icon(
                                      lesson.isCompleted ? Icons.done_all_rounded : Icons.check_circle_outline_rounded,
                                      size: 18,
                                    ),
                                    label: Text(
                                      lesson.isCompleted
                                          ? (isHindi ? 'पूर्ण हुआ' : 'Completed')
                                          : (isHindi ? 'अध्याय पूर्ण करें' : 'Mark as Complete'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
