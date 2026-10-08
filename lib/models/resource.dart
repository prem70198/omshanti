enum ResourceType {
  audio,
  video,
  article,
  pdf,
  dailyThought,
  book,
  workshop,
}

class Resource {
  final String id;
  final String title;
  final String titleHi;
  final String author;
  final String category;
  final ResourceType type;
  final int durationMinutes;
  final String description;
  final String descriptionHi;
  final String contentUrl;
  final String thumbnailUrl;
  final String language;
  final bool isFavorite;
  final bool isDownloaded;

  const Resource({
    required this.id,
    required this.title,
    required this.titleHi,
    required this.author,
    required this.category,
    required this.type,
    required this.durationMinutes,
    required this.description,
    required this.descriptionHi,
    required this.contentUrl,
    required this.thumbnailUrl,
    this.language = 'en',
    this.isFavorite = false,
    this.isDownloaded = false,
  });

  Resource copyWith({
    String? id,
    String? title,
    String? titleHi,
    String? author,
    String? category,
    ResourceType? type,
    int? durationMinutes,
    String? description,
    String? descriptionHi,
    String? contentUrl,
    String? thumbnailUrl,
    String? language,
    bool? isFavorite,
    bool? isDownloaded,
  }) {
    return Resource(
      id: id ?? this.id,
      title: title ?? this.title,
      titleHi: titleHi ?? this.titleHi,
      author: author ?? this.author,
      category: category ?? this.category,
      type: type ?? this.type,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      description: description ?? this.description,
      descriptionHi: descriptionHi ?? this.descriptionHi,
      contentUrl: contentUrl ?? this.contentUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      language: language ?? this.language,
      isFavorite: isFavorite ?? this.isFavorite,
      isDownloaded: isDownloaded ?? this.isDownloaded,
    );
  }
}
