import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

/// Persistent Local Database Service using SharedPreferences & JSON storage
/// Saves and restores user state, favorites, daily charts, event registrations,
/// and meditation history across sessions.
class AppDatabaseService {
  static AppDatabaseService? _instance;
  static SharedPreferences? _prefs;

  AppDatabaseService._();

  static Future<AppDatabaseService> get instance async {
    _instance ??= AppDatabaseService._();
    _prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  // Keys
  static const String _keyUser = 'omshanti_user';
  static const String _keyFavorites = 'omshanti_favorites';
  static const String _keyRegisteredEvents = 'omshanti_registered_events';
  static const String _keyAppliedSeva = 'omshanti_applied_seva';
  static const String _keyMeditationMinutes = 'omshanti_meditation_minutes';
  static const String _keyStreakDays = 'omshanti_streak_days';
  static const String _keyLastPracticeDate = 'omshanti_last_practice_date';
  static const String _keySpiritualCharts = 'omshanti_spiritual_charts';
  static const String _keyMurliNotes = 'omshanti_murli_notes';
  static const String _keyCompletedLessons = 'omshanti_completed_lessons';

  // ----------------------------------------------------
  // User Profile Persistence
  // ----------------------------------------------------
  UserModel? getUser() {
    final str = _prefs?.getString(_keyUser);
    if (str == null) return null;
    try {
      final map = jsonDecode(str) as Map<String, dynamic>;
      return UserModel(
        id: map['id'] ?? 'user_default',
        name: map['name'] ?? 'BK Seeker',
        email: map['email'] ?? 'seeker@brahmakumaris.org',
        avatarUrl: map['avatarUrl'] ?? '',
        favoriteCenterId: map['favoriteCenterId'] ?? 'center_1',
        totalMeditationMinutes: (map['totalMeditationMinutes'] as num?)?.toInt() ?? 120,
        completedSessionsCount: (map['completedSessionsCount'] as num?)?.toInt() ?? 12,
        currentStreakDays: (map['currentStreakDays'] as num?)?.toInt() ?? 7,
        sevaHours: (map['sevaHours'] as num?)?.toInt() ?? 8,
        preferredLanguage: map['preferredLanguage'] ?? 'en',
        isGuest: map['isGuest'] ?? false,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> saveUser(UserModel user) async {
    final map = {
      'id': user.id,
      'name': user.name,
      'email': user.email,
      'avatarUrl': user.avatarUrl,
      'favoriteCenterId': user.favoriteCenterId,
      'totalMeditationMinutes': user.totalMeditationMinutes,
      'completedSessionsCount': user.completedSessionsCount,
      'currentStreakDays': user.currentStreakDays,
      'sevaHours': user.sevaHours,
      'preferredLanguage': user.preferredLanguage,
      'isGuest': user.isGuest,
    };
    await _prefs?.setString(_keyUser, jsonEncode(map));
  }

  Future<void> clearUser() async {
    await _prefs?.remove(_keyUser);
  }

  // ----------------------------------------------------
  // Favorites / Bookmarks
  // ----------------------------------------------------
  Set<String> getFavorites() {
    final list = _prefs?.getStringList(_keyFavorites) ?? [];
    return list.toSet();
  }

  Future<void> toggleFavorite(String id) async {
    final set = getFavorites();
    if (set.contains(id)) {
      set.remove(id);
    } else {
      set.add(id);
    }
    await _prefs?.setStringList(_keyFavorites, set.toList());
  }

  bool isFavorite(String id) {
    return getFavorites().contains(id);
  }

  // ----------------------------------------------------
  // Registered Events
  // ----------------------------------------------------
  Set<String> getRegisteredEvents() {
    final list = _prefs?.getStringList(_keyRegisteredEvents) ?? [];
    return list.toSet();
  }

  Future<void> registerEvent(String eventId) async {
    final set = getRegisteredEvents();
    set.add(eventId);
    await _prefs?.setStringList(_keyRegisteredEvents, set.toList());
  }

  bool isEventRegistered(String eventId) {
    return getRegisteredEvents().contains(eventId);
  }

  // ----------------------------------------------------
  // Applied Seva Opportunities
  // ----------------------------------------------------
  Set<String> getAppliedSeva() {
    final list = _prefs?.getStringList(_keyAppliedSeva) ?? [];
    return list.toSet();
  }

  Future<void> applySeva(String sevaId) async {
    final set = getAppliedSeva();
    set.add(sevaId);
    await _prefs?.setStringList(_keyAppliedSeva, set.toList());
  }

  // ----------------------------------------------------
  // Meditation Practice Log & Streaks
  // ----------------------------------------------------
  int getTotalMeditationMinutes() {
    return _prefs?.getInt(_keyMeditationMinutes) ?? 120;
  }

  Future<void> addMeditationMinutes(int minutes) async {
    final current = getTotalMeditationMinutes();
    await _prefs?.setInt(_keyMeditationMinutes, current + minutes);

    // Update streak logic
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final lastDate = _prefs?.getString(_keyLastPracticeDate);
    if (lastDate != today) {
      final currentStreak = _prefs?.getInt(_keyStreakDays) ?? 7;
      await _prefs?.setInt(_keyStreakDays, currentStreak + 1);
      await _prefs?.setString(_keyLastPracticeDate, today);
    }
  }

  int getStreakDays() {
    return _prefs?.getInt(_keyStreakDays) ?? 7;
  }

  // ----------------------------------------------------
  // Completed Course Lessons
  // ----------------------------------------------------
  Set<String> getCompletedLessons() {
    final list = _prefs?.getStringList(_keyCompletedLessons) ?? ['lesson_1'];
    return list.toSet();
  }

  Future<void> markLessonCompleted(String lessonId) async {
    final set = getCompletedLessons();
    set.add(lessonId);
    await _prefs?.setStringList(_keyCompletedLessons, set.toList());
  }

  // ----------------------------------------------------
  // Daily Spiritual Purusharth Chart (दैनिक पुरुषार्थ चार्ट)
  // ----------------------------------------------------
  Map<String, dynamic>? getChartForDate(String dateYyyyMmDd) {
    final str = _prefs?.getString('${_keySpiritualCharts}_$dateYyyyMmDd');
    if (str == null) return null;
    try {
      return jsonDecode(str) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  Future<void> saveChartForDate(String dateYyyyMmDd, Map<String, dynamic> data) async {
    await _prefs?.setString('${_keySpiritualCharts}_$dateYyyyMmDd', jsonEncode(data));
  }

  // ----------------------------------------------------
  // Daily Murli Churning / Journal Notes (मंथन डायरी)
  // ----------------------------------------------------
  String? getMurliNoteForDate(String dateYyyyMmDd) {
    return _prefs?.getString('${_keyMurliNotes}_$dateYyyyMmDd');
  }

  Future<void> saveMurliNoteForDate(String dateYyyyMmDd, String note) async {
    await _prefs?.setString('${_keyMurliNotes}_$dateYyyyMmDd', note);
  }
}
