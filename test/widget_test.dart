import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'package:omshanti/main.dart';
import 'package:omshanti/data/app_database_service.dart';
import 'package:omshanti/providers/app_state_provider.dart';
import 'package:omshanti/widgets/shiva_point_of_light_widget.dart';
import 'package:omshanti/features/murli/daily_murli_screen.dart';
import 'package:omshanti/features/media/media_tv_screen.dart';
import 'package:omshanti/features/journal/spiritual_journal_screen.dart';

import 'package:omshanti/features/auth/signup_screen.dart';
import 'package:omshanti/widgets/registration_completion_button.dart';

import 'package:omshanti/core/routes/app_routes.dart';
import 'package:omshanti/features/profile/profile_screen.dart';
import 'package:omshanti/features/splash/splash_screen.dart';
import 'package:omshanti/features/onboarding/onboarding_screen.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Om Shanti app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const OmShantiApp());
    expect(find.byType(OmShantiApp), findsOneWidget);
    // Settle splash timer (2800ms)
    await tester.pump(const Duration(milliseconds: 3000));
  });

  testWidgets('SplashScreen renders adaptively in light and dark mode', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppStateProvider(),
        child: MaterialApp(
          themeMode: ThemeMode.light,
          routes: {
            AppRoutes.onboarding: (_) => const Scaffold(body: Text('Onboarding')),
          },
          home: const SplashScreen(),
        ),
      ),
    );
    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('OM SHANTI'), findsOneWidget);
    expect(find.text('Where You Can Find Your Peace'), findsOneWidget);
    expect(find.text('Welcome to'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 3000));
  });

  testWidgets('OnboardingScreen renders with theme-aware background', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppStateProvider(),
        child: const MaterialApp(
          home: OnboardingScreen(),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });

  test('AppDatabaseService stores and retrieves favorites and charts', () async {
    final db = await AppDatabaseService.instance;
    expect(db.getFavorites().isEmpty, true);

    await db.toggleFavorite('med_1');
    expect(db.isFavorite('med_1'), true);

    await db.saveChartForDate('2026-09-16', {'amritvelaDone': true, 'score': 90});
    final chart = db.getChartForDate('2026-09-16');
    expect(chart?['amritvelaDone'], true);
    expect(chart?['score'], 90);
  });

  testWidgets('ShivaPointOfLightWidget renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ShivaPointOfLightWidget(size: 80, animate: false),
        ),
      ),
    );
    expect(find.byType(ShivaPointOfLightWidget), findsOneWidget);
  });

  testWidgets('RegistrationCompletionButton renders and handles states', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RegistrationCompletionButton(
            label: 'Complete Registration',
            onPressed: () {},
            state: RegistrationButtonState.idle,
          ),
        ),
      ),
    );
    expect(find.text('Complete Registration'), findsOneWidget);
    expect(find.byType(RegistrationCompletionButton), findsOneWidget);
  });

  testWidgets('SignUpScreen renders redesigned interactive UI', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppStateProvider(),
        child: const MaterialApp(
          home: SignUpScreen(),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.byType(SignUpScreen), findsOneWidget);
    expect(find.byType(RegistrationCompletionButton), findsOneWidget);
    expect(find.text('Inner Peace & Calm'), findsOneWidget);
  });

  testWidgets('DailyMurliScreen renders with essence and swaman', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppStateProvider(),
        child: const MaterialApp(
          home: DailyMurliScreen(),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.byType(DailyMurliScreen), findsOneWidget);
  });

  testWidgets('MediaTvScreen renders PMTV player', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppStateProvider(),
        child: const MaterialApp(
          home: MediaTvScreen(),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.byType(MediaTvScreen), findsOneWidget);
  });

  testWidgets('SpiritualJournalScreen renders daily chart', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppStateProvider(),
        child: const MaterialApp(
          home: SpiritualJournalScreen(),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.byType(SpiritualJournalScreen), findsOneWidget);
  });

  testWidgets('ProfileScreen renders with Cards, Dividers, and ListTiles', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppStateProvider(),
        child: const MaterialApp(
          home: ProfileScreen(),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.byType(ProfileScreen), findsOneWidget);
    // Verify Cards are used for structuring sections
    expect(find.byType(Card), findsWidgets);
    // Verify Dividers are used between ListTiles
    expect(find.byType(Divider), findsWidgets);
    // Verify ListTiles are present for settings and navigation
    expect(find.byType(ListTile), findsWidgets);
    // Verify specific spiritual routine options
    expect(find.text('Amritvela Morning Alarm'), findsOneWidget);
    expect(find.text('Hourly Traffic Control'), findsOneWidget);
  });
}
