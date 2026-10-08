import 'package:flutter/material.dart';
import '../data/app_database_service.dart';
import '../models/user_model.dart';

class AppStateProvider extends ChangeNotifier {
  UserModel _currentUser = const UserModel(
    id: 'user_seeker_1',
    name: 'Rahul Sharma',
    email: 'rahul.seeker@omshanti.org',
    preferredLanguage: 'en',
    totalMeditationMinutes: 185,
    completedSessionsCount: 14,
    currentStreakDays: 7,
    sevaHours: 8,
  );

  bool _isAuthenticated = true;
  ThemeMode _themeMode = ThemeMode.light;

  AppStateProvider() {
    _restorePersistedState();
  }

  Future<void> _restorePersistedState() async {
    final db = await AppDatabaseService.instance;
    final savedUser = db.getUser();
    if (savedUser != null) {
      _currentUser = savedUser;
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  UserModel get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  String get languageCode => _currentUser.preferredLanguage;

  void setLanguage(String langCode) async {
    if (_currentUser.preferredLanguage != langCode) {
      _currentUser = _currentUser.copyWith(preferredLanguage: langCode);
      notifyListeners();
      final db = await AppDatabaseService.instance;
      await db.saveUser(_currentUser);
    }
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void loginAsGuest() async {
    _currentUser = const UserModel(
      id: 'guest_user',
      name: 'Peaceful Seeker',
      email: 'guest@omshanti.org',
      isGuest: true,
      totalMeditationMinutes: 15,
      completedSessionsCount: 1,
      currentStreakDays: 1,
    );
    _isAuthenticated = true;
    notifyListeners();
    final db = await AppDatabaseService.instance;
    await db.saveUser(_currentUser);
  }

  void login({required String email, required String name}) async {
    _currentUser = UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name.isNotEmpty ? name : 'Rahul Sharma',
      email: email,
      isGuest: false,
    );
    _isAuthenticated = true;
    notifyListeners();
    final db = await AppDatabaseService.instance;
    await db.saveUser(_currentUser);
  }

  void logout() async {
    _isAuthenticated = false;
    notifyListeners();
    final db = await AppDatabaseService.instance;
    await db.clearUser();
  }

  void incrementMeditationStats(int minutes) async {
    _currentUser = _currentUser.copyWith(
      totalMeditationMinutes: _currentUser.totalMeditationMinutes + minutes,
      completedSessionsCount: _currentUser.completedSessionsCount + 1,
    );
    notifyListeners();
    final db = await AppDatabaseService.instance;
    await db.saveUser(_currentUser);
    await db.addMeditationMinutes(minutes);
  }

  void addVolunteerHours(int hours) async {
    _currentUser = _currentUser.copyWith(
      sevaHours: _currentUser.sevaHours + hours,
    );
    notifyListeners();
    final db = await AppDatabaseService.instance;
    await db.saveUser(_currentUser);
  }
}
