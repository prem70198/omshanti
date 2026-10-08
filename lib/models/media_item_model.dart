enum MediaCategory {
  tvChannel,
  bkSongs,
  discourse,
  commentary,
}

class MediaItemModel {
  final String id;
  final String title;
  final String titleHi;
  final String speaker;
  final String channelName;
  final String duration;
  final String thumbnailUrl;
  final String streamUrl;
  final MediaCategory category;
  final bool isLive;

  const MediaItemModel({
    required this.id,
    required this.title,
    required this.titleHi,
    required this.speaker,
    required this.channelName,
    required this.duration,
    required this.thumbnailUrl,
    required this.streamUrl,
    required this.category,
    this.isLive = false,
  });
}
