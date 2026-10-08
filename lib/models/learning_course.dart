class LearningLesson {
  final int dayNumber;
  final String title;
  final String titleHi;
  final String subtitle;
  final String subtitleHi;
  final int durationMinutes;
  final String content;
  final String contentHi;
  final String keyTakeaway;
  final String keyTakeawayHi;
  final String contemplationPrompt;
  final String contemplationPromptHi;
  final bool isCompleted;
  final bool isLocked;

  const LearningLesson({
    required this.dayNumber,
    required this.title,
    required this.titleHi,
    required this.subtitle,
    required this.subtitleHi,
    required this.durationMinutes,
    required this.content,
    required this.contentHi,
    required this.keyTakeaway,
    required this.keyTakeawayHi,
    required this.contemplationPrompt,
    required this.contemplationPromptHi,
    this.isCompleted = false,
    this.isLocked = false,
  });

  LearningLesson copyWith({
    int? dayNumber,
    String? title,
    String? titleHi,
    String? subtitle,
    String? subtitleHi,
    int? durationMinutes,
    String? content,
    String? contentHi,
    String? keyTakeaway,
    String? keyTakeawayHi,
    String? contemplationPrompt,
    String? contemplationPromptHi,
    bool? isCompleted,
    bool? isLocked,
  }) {
    return LearningLesson(
      dayNumber: dayNumber ?? this.dayNumber,
      title: title ?? this.title,
      titleHi: titleHi ?? this.titleHi,
      subtitle: subtitle ?? this.subtitle,
      subtitleHi: subtitleHi ?? this.subtitleHi,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      content: content ?? this.content,
      contentHi: contentHi ?? this.contentHi,
      keyTakeaway: keyTakeaway ?? this.keyTakeaway,
      keyTakeawayHi: keyTakeawayHi ?? this.keyTakeawayHi,
      contemplationPrompt: contemplationPrompt ?? this.contemplationPrompt,
      contemplationPromptHi: contemplationPromptHi ?? this.contemplationPromptHi,
      isCompleted: isCompleted ?? this.isCompleted,
      isLocked: isLocked ?? this.isLocked,
    );
  }
}

class LearningCourse {
  final String id;
  final String title;
  final String titleHi;
  final String description;
  final String descriptionHi;
  final String level;
  final List<LearningLesson> lessons;

  const LearningCourse({
    required this.id,
    required this.title,
    required this.titleHi,
    required this.description,
    required this.descriptionHi,
    required this.level,
    required this.lessons,
  });

  int get completedCount => lessons.where((l) => l.isCompleted).length;
  double get progressPercentage => lessons.isEmpty ? 0.0 : completedCount / lessons.length;
}
