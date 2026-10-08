class EventModel {
  final String id;
  final String title;
  final String titleHi;
  final String description;
  final String descriptionHi;
  final DateTime eventDate;
  final String timeString;
  final int durationMinutes;
  final String location;
  final String centerName;
  final bool isOnline;
  final String organizer;
  final String imageUrl;
  final bool isRegistered;
  final String qrPassCode;

  const EventModel({
    required this.id,
    required this.title,
    required this.titleHi,
    required this.description,
    required this.descriptionHi,
    required this.eventDate,
    required this.timeString,
    required this.durationMinutes,
    required this.location,
    required this.centerName,
    required this.isOnline,
    required this.organizer,
    required this.imageUrl,
    this.isRegistered = false,
    this.qrPassCode = '',
  });

  EventModel copyWith({
    String? id,
    String? title,
    String? titleHi,
    String? description,
    String? descriptionHi,
    DateTime? eventDate,
    String? timeString,
    int? durationMinutes,
    String? location,
    String? centerName,
    bool? isOnline,
    String? organizer,
    String? imageUrl,
    bool? isRegistered,
    String? qrPassCode,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      titleHi: titleHi ?? this.titleHi,
      description: description ?? this.description,
      descriptionHi: descriptionHi ?? this.descriptionHi,
      eventDate: eventDate ?? this.eventDate,
      timeString: timeString ?? this.timeString,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      location: location ?? this.location,
      centerName: centerName ?? this.centerName,
      isOnline: isOnline ?? this.isOnline,
      organizer: organizer ?? this.organizer,
      imageUrl: imageUrl ?? this.imageUrl,
      isRegistered: isRegistered ?? this.isRegistered,
      qrPassCode: qrPassCode ?? this.qrPassCode,
    );
  }
}
