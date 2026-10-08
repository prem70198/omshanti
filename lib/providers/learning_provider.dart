import 'package:flutter/material.dart';
import '../models/learning_course.dart';
import '../data/mock_database.dart';

class LearningProvider extends ChangeNotifier {
  LearningCourse _course = MockDatabase.foundationCourse;
  final Map<int, String> _userReflections = {};

  LearningCourse get course => _course;
  Map<int, String> get userReflections => _userReflections;

  int get completedCount => _course.lessons.where((l) => l.isCompleted).length;
  int get totalLessons => _course.lessons.length;
  double get progressPercentage => totalLessons == 0 ? 0.0 : completedCount / totalLessons;

  LearningLesson? get nextRecommendedLesson {
    return _course.lessons.firstWhere(
      (l) => !l.isCompleted,
      orElse: () => _course.lessons.last,
    );
  }

  void completeLesson(int dayNumber) {
    final updatedLessons = _course.lessons.map((lesson) {
      if (lesson.dayNumber == dayNumber) {
        return lesson.copyWith(isCompleted: true);
      }
      return lesson;
    }).toList();

    _course = LearningCourse(
      id: _course.id,
      title: _course.title,
      titleHi: _course.titleHi,
      description: _course.description,
      descriptionHi: _course.descriptionHi,
      level: _course.level,
      lessons: updatedLessons,
    );
    notifyListeners();
  }

  void saveReflection(int dayNumber, String reflectionText) {
    _userReflections[dayNumber] = reflectionText;
    notifyListeners();
  }
}
