import 'meditation_session.dart';

class Playlist {
  final String id;
  final String title;
  final String titleHi;
  final String description;
  final String descriptionHi;
  final String coverImageUrl;
  final List<String> sessionIds;
  final int totalDurationMinutes;
  final int sessionCount;
  final MeditationCategory category;
  final bool isFavorite;
  final bool isDownloaded;

  const Playlist({
    required this.id,
    required this.title,
    required this.titleHi,
    required this.description,
    required this.descriptionHi,
    required this.coverImageUrl,
    required this.sessionIds,
    required this.totalDurationMinutes,
    required this.sessionCount,
    required this.category,
    this.isFavorite = false,
    this.isDownloaded = false,
  });

  Playlist copyWith({
    String? id,
    String? title,
    String? titleHi,
    String? description,
    String? descriptionHi,
    String? coverImageUrl,
    List<String>? sessionIds,
    int? totalDurationMinutes,
    int? sessionCount,
    MeditationCategory? category,
    bool? isFavorite,
    bool? isDownloaded,
  }) {
    return Playlist(
      id: id ?? this.id,
      title: title ?? this.title,
      titleHi: titleHi ?? this.titleHi,
      description: description ?? this.description,
      descriptionHi: descriptionHi ?? this.descriptionHi,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      sessionIds: sessionIds ?? this.sessionIds,
      totalDurationMinutes: totalDurationMinutes ?? this.totalDurationMinutes,
      sessionCount: sessionCount ?? this.sessionCount,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
      isDownloaded: isDownloaded ?? this.isDownloaded,
    );
  }
}
