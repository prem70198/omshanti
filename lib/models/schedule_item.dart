class ScheduleItem {
  final String id;
  final String title;
  final String titleHi;
  final String timeString; // e.g. "06:30 AM"
  final int hour;
  final int minute;
  final int durationMinutes;
  final String sessionOrPlaylistTitle;
  final String meditationSessionId;
  final List<int> daysOfWeek; // 1=Mon ... 7=Sun
  final bool isReminderEnabled;
  final bool isCompletedToday;

  const ScheduleItem({
    required this.id,
    required this.title,
    required this.titleHi,
    required this.timeString,
    required this.hour,
    required this.minute,
    required this.durationMinutes,
    required this.sessionOrPlaylistTitle,
    required this.meditationSessionId,
    this.daysOfWeek = const [1, 2, 3, 4, 5, 6, 7],
    this.isReminderEnabled = true,
    this.isCompletedToday = false,
  });

  ScheduleItem copyWith({
    String? id,
    String? title,
    String? titleHi,
    String? timeString,
    int? hour,
    int? minute,
    int? durationMinutes,
    String? sessionOrPlaylistTitle,
    String? meditationSessionId,
    List<int>? daysOfWeek,
    bool? isReminderEnabled,
    bool? isCompletedToday,
  }) {
    return ScheduleItem(
      id: id ?? this.id,
      title: title ?? this.title,
      titleHi: titleHi ?? this.titleHi,
      timeString: timeString ?? this.timeString,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      sessionOrPlaylistTitle: sessionOrPlaylistTitle ?? this.sessionOrPlaylistTitle,
      meditationSessionId: meditationSessionId ?? this.meditationSessionId,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      isReminderEnabled: isReminderEnabled ?? this.isReminderEnabled,
      isCompletedToday: isCompletedToday ?? this.isCompletedToday,
    );
  }
}
