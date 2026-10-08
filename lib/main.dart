import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_strings.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'data/app_database_service.dart';
import 'data/mock_database.dart';

import 'providers/ai_guide_provider.dart';
import 'providers/app_state_provider.dart';
import 'providers/community_provider.dart';
import 'providers/learning_provider.dart';
import 'providers/live_session_provider.dart';
import 'providers/meditation_player_provider.dart';
import 'providers/schedule_provider.dart';

import 'features/splash/splash_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/signup_screen.dart';
import 'features/navigation/main_navigation_shell.dart';
import 'features/meditation/meditation_player_screen.dart';
import 'features/meditation/breathing_exercise_screen.dart';
import 'features/schedule/practice_schedule_screen.dart';
import 'features/live/live_room_screen.dart';
import 'features/centers/center_finder_screen.dart';
import 'features/learning/learning_journey_screen.dart';
import 'features/seva/seva_screen.dart';
import 'features/murli/daily_murli_screen.dart';
import 'features/media/media_tv_screen.dart';
import 'features/journal/spiritual_journal_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize local persistent storage
  await AppDatabaseService.instance;
  runApp(const OmShantiApp());
}

class OmShantiApp extends StatelessWidget {
  const OmShantiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
        ChangeNotifierProvider(create: (_) => MeditationPlayerProvider()),
        ChangeNotifierProvider(create: (_) => ScheduleProvider()),
        ChangeNotifierProvider(create: (_) => CommunityProvider()),
        ChangeNotifierProvider(create: (_) => LiveSessionProvider()),
        ChangeNotifierProvider(create: (_) => LearningProvider()),
        ChangeNotifierProvider(create: (_) => AiGuideProvider()),
      ],
      child: Consumer<AppStateProvider>(
        builder: (context, appState, child) {
          return MaterialApp(
            title: AppStrings.get('appName', appState.languageCode),
            debugShowCheckedModeBanner: false,
            navigatorKey: AppRoutes.navigatorKey,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: appState.themeMode,
            initialRoute: AppRoutes.splash,
            routes: {
              AppRoutes.splash: (_) => const SplashScreen(),
              AppRoutes.onboarding: (_) => const OnboardingScreen(),
              AppRoutes.login: (_) => const LoginScreen(),
              AppRoutes.signup: (_) => const SignUpScreen(),
              AppRoutes.mainShell: (_) => const MainNavigationShell(),
              AppRoutes.breathingExercise: (_) => const BreathingExerciseScreen(),
              AppRoutes.practiceSchedule: (_) => const PracticeScheduleScreen(),
              AppRoutes.liveRoom: (_) => const LiveRoomScreen(),
              AppRoutes.centerFinder: (_) => const CenterFinderScreen(),
              AppRoutes.learningJourney: (_) => const LearningJourneyScreen(),
              AppRoutes.seva: (_) => const SevaScreen(),
              AppRoutes.dailyMurli: (_) => const DailyMurliScreen(),
              AppRoutes.mediaTv: (_) => const MediaTvScreen(),
              AppRoutes.spiritualJournal: (_) => const SpiritualJournalScreen(),
              AppRoutes.meditationPlayer: (_) => MeditationPlayerScreen(
                    session: MockDatabase.meditationSessions.first,
                  ),
            },
          );
        },
      ),
    );
  }
}
