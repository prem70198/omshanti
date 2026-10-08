import 'package:flutter/material.dart';
import '../models/schedule_item.dart';
import '../data/mock_database.dart';

class ScheduleProvider extends ChangeNotifier {
  final List<ScheduleItem> _schedules = List.from(MockDatabase.defaultSchedules);
  int _selectedDayIndex = DateTime.now().weekday; // 1=Mon ... 7=Sun

  List<ScheduleItem> get allSchedules => _schedules;
  int get selectedDayIndex => _selectedDayIndex;

  List<ScheduleItem> get filteredSchedules {
    return _schedules.where((item) => item.daysOfWeek.contains(_selectedDayIndex)).toList();
  }

  int get totalTodayCount => filteredSchedules.length;
  int get completedTodayCount => filteredSchedules.where((item) => item.isCompletedToday).length;

  void setSelectedDay(int day) {
    _selectedDayIndex = day;
    notifyListeners();
  }

  void toggleCompletion(String id) {
    final index = _schedules.indexWhere((s) => s.id == id);
    if (index != -1) {
      _schedules[index] = _schedules[index].copyWith(
        isCompletedToday: !_schedules[index].isCompletedToday,
      );
      notifyListeners();
    }
  }

  void toggleReminder(String id) {
    final index = _schedules.indexWhere((s) => s.id == id);
    if (index != -1) {
      _schedules[index] = _schedules[index].copyWith(
        isReminderEnabled: !_schedules[index].isReminderEnabled,
      );
      notifyListeners();
    }
  }

  void addScheduleItem({
    required String title,
    required String titleHi,
    required String timeString,
    required int hour,
    required int minute,
    required int durationMinutes,
    required String sessionOrPlaylistTitle,
    required String meditationSessionId,
    required List<int> daysOfWeek,
    required bool isReminderEnabled,
  }) {
    final newItem = ScheduleItem(
      id: 'sch_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      titleHi: titleHi,
      timeString: timeString,
      hour: hour,
      minute: minute,
      durationMinutes: durationMinutes,
      sessionOrPlaylistTitle: sessionOrPlaylistTitle,
      meditationSessionId: meditationSessionId,
      daysOfWeek: daysOfWeek,
      isReminderEnabled: isReminderEnabled,
    );
    _schedules.add(newItem);
    notifyListeners();
  }

  void deleteScheduleItem(String id) {
    _schedules.removeWhere((s) => s.id == id);
    notifyListeners();
  }
}
