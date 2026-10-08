import '../../data/app_database_service.dart';
import '../../data/mock_database.dart';
import '../../models/daily_murli_model.dart';
import '../../models/media_item_model.dart';
import '../../models/meditation_session.dart';
import '../../models/center_model.dart';
import '../../models/event_model.dart';
import '../../models/seva_opportunity.dart';

/// Comprehensive Backend API & Repository Gateway
/// Provides simulated REST/Realtime endpoints and seamlessly integrates with
/// the local persistent database (AppDatabaseService).
class BackendApiService {
  static Future<AppDatabaseService> get _db => AppDatabaseService.instance;

  // ----------------------------------------------------
  // Daily Murli API
  // ----------------------------------------------------
  static Future<DailyMurliModel> getTodayMurli() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return MockDatabase.todayMurli;
  }

  static Future<void> saveMurliReflection(String date, String notes) async {
    final db = await _db;
    await db.saveMurliNoteForDate(date, notes);
  }

  static Future<String?> getMurliReflection(String date) async {
    final db = await _db;
    return db.getMurliNoteForDate(date);
  }

  // ----------------------------------------------------
  // Media & TV API (PMTV, BK Songs, Discourses)
  // ----------------------------------------------------
  static Future<List<MediaItemModel>> getMediaItems({MediaCategory? category}) async {
    await Future.delayed(const Duration(milliseconds: 120));
    if (category == null) return MockDatabase.mediaItems;
    return MockDatabase.mediaItems.where((m) => m.category == category).toList();
  }

  // ----------------------------------------------------
  // Meditation Sessions API with Persistence
  // ----------------------------------------------------
  static Future<List<MeditationSession>> getMeditations({MeditationCategory? category}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final db = await _db;
    final favorites = db.getFavorites();

    final list = category == null
        ? MockDatabase.meditationSessions
        : MockDatabase.meditationSessions.where((s) => s.category == category).toList();

    return list.map((s) {
      return s.copyWith(isFavorite: favorites.contains(s.id));
    }).toList();
  }

  static Future<bool> toggleFavorite(String sessionId) async {
    final db = await _db;
    await db.toggleFavorite(sessionId);
    return db.isFavorite(sessionId);
  }

  static Future<void> logMeditationMinutes(int minutes) async {
    final db = await _db;
    await db.addMeditationMinutes(minutes);
  }

  // ----------------------------------------------------
  // Centers Locator API
  // ----------------------------------------------------
  static Future<List<CenterModel>> searchCenters(String query) async {
    await Future.delayed(const Duration(milliseconds: 150));
    if (query.trim().isEmpty) return MockDatabase.centers;
    final q = query.toLowerCase();
    return MockDatabase.centers.where((c) {
      return c.name.toLowerCase().contains(q) ||
          c.nameHi.contains(q) ||
          c.city.toLowerCase().contains(q) ||
          c.address.toLowerCase().contains(q);
    }).toList();
  }

  // ----------------------------------------------------
  // Events API with Registration Persistence
  // ----------------------------------------------------
  static Future<List<EventModel>> getEvents() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final db = await _db;
    final registered = db.getRegisteredEvents();

    return MockDatabase.events.map((e) {
      return e.copyWith(isRegistered: registered.contains(e.id));
    }).toList();
  }

  static Future<void> registerForEvent(String eventId) async {
    final db = await _db;
    await db.registerEvent(eventId);
  }

  // ----------------------------------------------------
  // Seva Opportunities API
  // ----------------------------------------------------
  static Future<List<SevaOpportunity>> getSevaOpportunities() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return MockDatabase.sevaOpportunities;
  }

  static Future<void> applyForSeva(String sevaId) async {
    final db = await _db;
    await db.applySeva(sevaId);
  }

  // ----------------------------------------------------
  // Daily Spiritual Purusharth Chart API
  // ----------------------------------------------------
  static Future<Map<String, dynamic>?> getChartForDate(String dateYyyyMmDd) async {
    final db = await _db;
    return db.getChartForDate(dateYyyyMmDd);
  }

  static Future<void> saveChartForDate(String dateYyyyMmDd, Map<String, dynamic> data) async {
    final db = await _db;
    await db.saveChartForDate(dateYyyyMmDd, data);
  }
}
