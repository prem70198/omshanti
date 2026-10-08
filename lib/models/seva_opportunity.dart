enum SevaCategory {
  environment,
  education,
  community,
  meditationAwareness,
}

class SevaOpportunity {
  final String id;
  final String title;
  final String titleHi;
  final String description;
  final String descriptionHi;
  final SevaCategory category;
  final String centerName;
  final String location;
  final DateTime date;
  final String timeString;
  final int totalSlots;
  final int filledSlots;
  final int estimatedHours;
  final bool isJoined;

  const SevaOpportunity({
    required this.id,
    required this.title,
    required this.titleHi,
    required this.description,
    required this.descriptionHi,
    required this.category,
    required this.centerName,
    required this.location,
    required this.date,
    required this.timeString,
    required this.totalSlots,
    required this.filledSlots,
    required this.estimatedHours,
    this.isJoined = false,
  });

  int get availableSlots => totalSlots - filledSlots;

  SevaOpportunity copyWith({
    String? id,
    String? title,
    String? titleHi,
    String? description,
    String? descriptionHi,
    SevaCategory? category,
    String? centerName,
    String? location,
    DateTime? date,
    String? timeString,
    int? totalSlots,
    int? filledSlots,
    int? estimatedHours,
    bool? isJoined,
  }) {
    return SevaOpportunity(
      id: id ?? this.id,
      title: title ?? this.title,
      titleHi: titleHi ?? this.titleHi,
      description: description ?? this.description,
      descriptionHi: descriptionHi ?? this.descriptionHi,
      category: category ?? this.category,
      centerName: centerName ?? this.centerName,
      location: location ?? this.location,
      date: date ?? this.date,
      timeString: timeString ?? this.timeString,
      totalSlots: totalSlots ?? this.totalSlots,
      filledSlots: filledSlots ?? this.filledSlots,
      estimatedHours: estimatedHours ?? this.estimatedHours,
      isJoined: isJoined ?? this.isJoined,
    );
  }
}
