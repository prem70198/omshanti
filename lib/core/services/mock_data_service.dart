import '../../data/mock_database.dart';
import '../../models/meditation_session.dart';
import '../../models/playlist.dart';
import '../../models/live_session.dart';
import '../../models/center_model.dart';
import '../../models/event_model.dart';
import '../../models/learning_course.dart';
import '../../models/resource.dart';
import '../../models/seva_opportunity.dart';

/// Service abstraction acting as simulated database repository & API gateway.
class MockDataService {
  static Future<List<MeditationSession>> getFeaturedMeditations() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return MockDatabase.meditationSessions.where((s) => s.isFeatured).toList();
  }

  static Future<List<MeditationSession>> getAllMeditations({MeditationCategory? category}) async {
    await Future.delayed(const Duration(milliseconds: 150));
    if (category == null) return MockDatabase.meditationSessions;
    return MockDatabase.meditationSessions.where((s) => s.category == category).toList();
  }

  static Future<List<Playlist>> getPlaylists() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return MockDatabase.playlists;
  }

  static Future<List<LiveSession>> getLiveSessions() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return MockDatabase.liveSessions;
  }

  static Future<List<CenterModel>> getCenters({String? query}) async {
    await Future.delayed(const Duration(milliseconds: 150));
    if (query == null || query.trim().isEmpty) return MockDatabase.centers;
    final q = query.toLowerCase();
    return MockDatabase.centers.where((c) {
      return c.name.toLowerCase().contains(q) ||
          c.city.toLowerCase().contains(q) ||
          c.address.toLowerCase().contains(q);
    }).toList();
  }

  static Future<List<EventModel>> getEvents({bool? isOnline}) async {
    await Future.delayed(const Duration(milliseconds: 150));
    if (isOnline == null) return MockDatabase.events;
    return MockDatabase.events.where((e) => e.isOnline == isOnline).toList();
  }

  static Future<LearningCourse> getFoundationCourse() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return MockDatabase.foundationCourse;
  }

  static Future<List<Resource>> getResources({ResourceType? type}) async {
    await Future.delayed(const Duration(milliseconds: 150));
    if (type == null) return MockDatabase.resources;
    return MockDatabase.resources.where((r) => r.type == type).toList();
  }

  static Future<List<SevaOpportunity>> getSevaOpportunities({SevaCategory? category}) async {
    await Future.delayed(const Duration(milliseconds: 150));
    if (category == null) return MockDatabase.sevaOpportunities;
    return MockDatabase.sevaOpportunities.where((s) => s.category == category).toList();
  }
}
