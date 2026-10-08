class LiveSession {
  final String id;
  final String title;
  final String titleHi;
  final String hostName;
  final String hostRole;
  final String centerName;
  final DateTime scheduledTime;
  final int durationMinutes;
  final int participantCount;
  final bool isLiveNow;
  final bool isReminderSet;
  final String streamUrl;
  final String description;
  final String descriptionHi;

  const LiveSession({
    required this.id,
    required this.title,
    required this.titleHi,
    required this.hostName,
    required this.hostRole,
    required this.centerName,
    required this.scheduledTime,
    required this.durationMinutes,
    this.participantCount = 0,
    this.isLiveNow = false,
    this.isReminderSet = false,
    required this.streamUrl,
    required this.description,
    required this.descriptionHi,
  });

  LiveSession copyWith({
    String? id,
    String? title,
    String? titleHi,
    String? hostName,
    String? hostRole,
    String? centerName,
    DateTime? scheduledTime,
    int? durationMinutes,
    int? participantCount,
    bool? isLiveNow,
    bool? isReminderSet,
    String? streamUrl,
    String? description,
    String? descriptionHi,
  }) {
    return LiveSession(
      id: id ?? this.id,
      title: title ?? this.title,
      titleHi: titleHi ?? this.titleHi,
      hostName: hostName ?? this.hostName,
      hostRole: hostRole ?? this.hostRole,
      centerName: centerName ?? this.centerName,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      participantCount: participantCount ?? this.participantCount,
      isLiveNow: isLiveNow ?? this.isLiveNow,
      isReminderSet: isReminderSet ?? this.isReminderSet,
      streamUrl: streamUrl ?? this.streamUrl,
      description: description ?? this.description,
      descriptionHi: descriptionHi ?? this.descriptionHi,
    );
  }
}
