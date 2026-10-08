import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../providers/app_state_provider.dart';
import '../../widgets/mini_player.dart';
import '../home/home_screen.dart';
import '../explore/explore_screen.dart';
import '../meditation/breathing_exercise_screen.dart';
import '../live/live_listing_screen.dart';
import '../profile/profile_screen.dart';
import '../assistant/resource_guide_sheet.dart';

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ExploreScreen(),
    BreathingExerciseScreen(),
    LiveListingScreen(),
    ProfileScreen(),
  ];

  void _openAssistantSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const ResourceGuideSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isHindi = appState.languageCode == 'hi';

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),

          // Floating Persistent Mini Player above Bottom Bar
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: MiniPlayer(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAssistantSheet,
        backgroundColor: isDark ? AppColors.primaryLight : AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.auto_awesome_rounded, size: 20, color: Color(0xFFFDE68A)),
        label: Text(
          isHindi ? 'आत्म-मार्गदर्शक' : 'AI Guide',
          style: AppTypography.labelSmall(isDark: true).copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home_rounded),
            label: isHindi ? 'होम' : 'Home',
          ),
          NavigationDestination(
            icon: const Icon(Icons.search_rounded),
            selectedIcon: const Icon(Icons.search_rounded),
            label: isHindi ? 'खोजें' : 'Explore',
          ),
          NavigationDestination(
            icon: const Icon(Icons.spa_outlined),
            selectedIcon: const Icon(Icons.spa_rounded),
            label: isHindi ? 'ध्यान' : 'Meditate',
          ),
          NavigationDestination(
            icon: const Icon(Icons.sensors_outlined),
            selectedIcon: const Icon(Icons.sensors_rounded),
            label: isHindi ? 'लाइव' : 'Live',
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline_rounded),
            selectedIcon: const Icon(Icons.person_rounded),
            label: isHindi ? 'प्रोफ़ाइल' : 'Profile',
          ),
        ],
      ),
    );
  }
}
