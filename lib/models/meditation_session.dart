enum MeditationCategory {
  morning,
  evening,
  peace,
  relaxation,
  focus,
  positiveThoughts,
  sleep,
}

class MeditationSession {
  final String id;
  final String title;
  final String titleHi;
  final String subtitle;
  final String subtitleHi;
  final String instructor;
  final int durationMinutes;
  final MeditationCategory category;
  final String audioUrl;
  final String imageUrl;
  final String guidanceText;
  final String guidanceTextHi;
  final bool isFeatured;
  final bool isFavorite;
  final bool isDownloaded;

  const MeditationSession({
    required this.id,
    required this.title,
    required this.titleHi,
    required this.subtitle,
    required this.subtitleHi,
    required this.instructor,
    required this.durationMinutes,
    required this.category,
    required this.audioUrl,
    required this.imageUrl,
    required this.guidanceText,
    required this.guidanceTextHi,
    this.isFeatured = false,
    this.isFavorite = false,
    this.isDownloaded = false,
  });

  MeditationSession copyWith({
    String? id,
    String? title,
    String? titleHi,
    String? subtitle,
    String? subtitleHi,
    String? instructor,
    int? durationMinutes,
    MeditationCategory? category,
    String? audioUrl,
    String? imageUrl,
    String? guidanceText,
    String? guidanceTextHi,
    bool? isFeatured,
    bool? isFavorite,
    bool? isDownloaded,
  }) {
    return MeditationSession(
      id: id ?? this.id,
      title: title ?? this.title,
      titleHi: titleHi ?? this.titleHi,
      subtitle: subtitle ?? this.subtitle,
      subtitleHi: subtitleHi ?? this.subtitleHi,
      instructor: instructor ?? this.instructor,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      category: category ?? this.category,
      audioUrl: audioUrl ?? this.audioUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      guidanceText: guidanceText ?? this.guidanceText,
      guidanceTextHi: guidanceTextHi ?? this.guidanceTextHi,
      isFeatured: isFeatured ?? this.isFeatured,
      isFavorite: isFavorite ?? this.isFavorite,
      isDownloaded: isDownloaded ?? this.isDownloaded,
    );
  }
}
