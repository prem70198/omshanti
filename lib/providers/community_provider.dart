import 'package:flutter/material.dart';
import '../models/center_model.dart';
import '../models/event_model.dart';
import '../models/seva_opportunity.dart';
import '../data/mock_database.dart';

class CommunityProvider extends ChangeNotifier {
  final List<CenterModel> _centers = List.from(MockDatabase.centers);
  final List<EventModel> _events = List.from(MockDatabase.events);
  final List<SevaOpportunity> _sevaOpportunities = List.from(MockDatabase.sevaOpportunities);

  CenterModel? _selectedCenter;
  String _centerSearchQuery = '';
  String _eventFilter = 'all'; // 'all', 'online', 'offline'
  SevaCategory? _selectedSevaCategory;

  CommunityProvider() {
    _selectedCenter = _centers.first;
  }

  List<CenterModel> get allCenters => _centers;
  CenterModel? get selectedCenter => _selectedCenter;
  CenterModel get nearestCenter => _centers.first;
  String get centerSearchQuery => _centerSearchQuery;
  String get eventFilter => _eventFilter;
  SevaCategory? get selectedSevaCategory => _selectedSevaCategory;

  List<CenterModel> get filteredCenters {
    if (_centerSearchQuery.trim().isEmpty) return _centers;
    final query = _centerSearchQuery.toLowerCase();
    return _centers.where((c) {
      return c.name.toLowerCase().contains(query) ||
          c.city.toLowerCase().contains(query) ||
          c.address.toLowerCase().contains(query) ||
          c.nameHi.contains(query);
    }).toList();
  }

  List<EventModel> get filteredEvents {
    if (_eventFilter == 'online') {
      return _events.where((e) => e.isOnline).toList();
    } else if (_eventFilter == 'offline') {
      return _events.where((e) => !e.isOnline).toList();
    }
    return _events;
  }

  List<SevaOpportunity> get filteredSeva {
    if (_selectedSevaCategory == null) return _sevaOpportunities;
    return _sevaOpportunities.where((s) => s.category == _selectedSevaCategory).toList();
  }

  int get totalJoinedSevaCount => _sevaOpportunities.where((s) => s.isJoined).length;
  int get totalVolunteerHours =>
      _sevaOpportunities.where((s) => s.isJoined).fold(0, (sum, s) => sum + s.estimatedHours);

  void selectCenter(CenterModel center) {
    _selectedCenter = center;
    notifyListeners();
  }

  void setCenterSearchQuery(String query) {
    _centerSearchQuery = query;
    notifyListeners();
  }

  void setEventFilter(String filter) {
    _eventFilter = filter;
    notifyListeners();
  }

  void setSevaCategory(SevaCategory? category) {
    _selectedSevaCategory = category;
    notifyListeners();
  }

  void registerForEvent(String eventId) {
    final index = _events.indexWhere((e) => e.id == eventId);
    if (index != -1) {
      final code = 'BK-REG-${(100000 + index * 3421).toString()}';
      _events[index] = _events[index].copyWith(
        isRegistered: true,
        qrPassCode: code,
      );
      notifyListeners();
    }
  }

  void joinSeva(String sevaId) {
    final index = _sevaOpportunities.indexWhere((s) => s.id == sevaId);
    if (index != -1) {
      final item = _sevaOpportunities[index];
      if (!item.isJoined && item.availableSlots > 0) {
        _sevaOpportunities[index] = item.copyWith(
          isJoined: true,
          filledSlots: item.filledSlots + 1,
        );
        notifyListeners();
      }
    }
  }

  void toggleJoinSeva(String sevaId) {
    final index = _sevaOpportunities.indexWhere((s) => s.id == sevaId);
    if (index != -1) {
      final item = _sevaOpportunities[index];
      final newJoined = !item.isJoined;
      _sevaOpportunities[index] = item.copyWith(
        isJoined: newJoined,
        filledSlots: newJoined ? item.filledSlots + 1 : (item.filledSlots > 0 ? item.filledSlots - 1 : 0),
      );
      notifyListeners();
    }
  }

  void toggleCenterFavorite(String centerId) {
    final index = _centers.indexWhere((c) => c.id == centerId);
    if (index != -1) {
      _centers[index] = _centers[index].copyWith(
        isFavorite: !_centers[index].isFavorite,
      );
      notifyListeners();
    }
  }
}
