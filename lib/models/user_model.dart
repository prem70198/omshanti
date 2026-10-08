class UserModel {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final String preferredLanguage; // 'en' or 'hi'
  final String favoriteCenterId;
  final int totalMeditationMinutes;
  final int completedSessionsCount;
  final int currentStreakDays;
  final int sevaHours;
  final bool isGuest;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl = '',
    this.preferredLanguage = 'en',
    this.favoriteCenterId = 'center_1',
    this.totalMeditationMinutes = 145,
    this.completedSessionsCount = 12,
    this.currentStreakDays = 6,
    this.sevaHours = 8,
    this.isGuest = false,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    String? preferredLanguage,
    String? favoriteCenterId,
    int? totalMeditationMinutes,
    int? completedSessionsCount,
    int? currentStreakDays,
    int? sevaHours,
    bool? isGuest,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      favoriteCenterId: favoriteCenterId ?? this.favoriteCenterId,
      totalMeditationMinutes: totalMeditationMinutes ?? this.totalMeditationMinutes,
      completedSessionsCount: completedSessionsCount ?? this.completedSessionsCount,
      currentStreakDays: currentStreakDays ?? this.currentStreakDays,
      sevaHours: sevaHours ?? this.sevaHours,
      isGuest: isGuest ?? this.isGuest,
    );
  }
}
