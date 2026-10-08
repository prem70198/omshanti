class CenterProgram {
  final String time;
  final String title;
  final String titleHi;
  final String type;

  const CenterProgram({
    required this.time,
    required this.title,
    required this.titleHi,
    required this.type,
  });
}

class CenterModel {
  final String id;
  final String name;
  final String nameHi;
  final String address;
  final String city;
  final double distanceKm;
  final String phone;
  final String email;
  final String openingHours;
  final double latitude;
  final double longitude;
  final String todayProgramTitle;
  final String todayProgramTitleHi;
  final String todayProgramTime;
  final List<CenterProgram> dailySchedule;
  final bool isFavorite;

  const CenterModel({
    required this.id,
    required this.name,
    required this.nameHi,
    required this.address,
    required this.city,
    required this.distanceKm,
    required this.phone,
    required this.email,
    required this.openingHours,
    required this.latitude,
    required this.longitude,
    required this.todayProgramTitle,
    required this.todayProgramTitleHi,
    required this.todayProgramTime,
    required this.dailySchedule,
    this.isFavorite = false,
  });

  CenterModel copyWith({
    String? id,
    String? name,
    String? nameHi,
    String? address,
    String? city,
    double? distanceKm,
    String? phone,
    String? email,
    String? openingHours,
    double? latitude,
    double? longitude,
    String? todayProgramTitle,
    String? todayProgramTitleHi,
    String? todayProgramTime,
    List<CenterProgram>? dailySchedule,
    bool? isFavorite,
  }) {
    return CenterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nameHi: nameHi ?? this.nameHi,
      address: address ?? this.address,
      city: city ?? this.city,
      distanceKm: distanceKm ?? this.distanceKm,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      openingHours: openingHours ?? this.openingHours,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      todayProgramTitle: todayProgramTitle ?? this.todayProgramTitle,
      todayProgramTitleHi: todayProgramTitleHi ?? this.todayProgramTitleHi,
      todayProgramTime: todayProgramTime ?? this.todayProgramTime,
      dailySchedule: dailySchedule ?? this.dailySchedule,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
