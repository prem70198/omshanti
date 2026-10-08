import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/app_buttons.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Experience Pure Silence',
      'subtitle': 'Discover tranquility beyond words. Connect with your eternal peaceful nature anytime, anywhere.',
      'icon': 'self_improvement_rounded',
      'quote': '“Silence is the language of the soul.”',
    },
    {
      'title': 'Soul Consciousness & Yog',
      'subtitle': 'Shift from body identity to conscious master. Harmonize your mind with the Supreme Source of light.',
      'icon': 'wb_sunny_rounded',
      'quote': '“I am a tiny star of divine radiant light.”',
    },
    {
      'title': 'Daily Spiritual Routine',
      'subtitle': 'Amritvela morning dawn meditation, hourly traffic control pauses, and evening peaceful reflections.',
      'icon': 'schedule_rounded',
      'quote': '“A peaceful morning shapes a blessed day.”',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Skip
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: AppColors.amberGold,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'OM SHANTI',
                        style: AppTypography.labelLarge(isDark: isDark).copyWith(
                          color: isDark ? Colors.white : AppColors.primary,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
                    child: Text(
                      'Skip',
                      style: AppTypography.labelLarge(isDark: isDark).copyWith(
                        color: isDark ? Colors.white60 : AppColors.textSecondaryLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Onboarding Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        // Spiritual Aura Graphic Card
                        Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppColors.primary.withAlpha(isDark ? 160 : 70),
                                AppColors.amberGold.withAlpha(isDark ? 80 : 50),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          child: Center(
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDark ? AppColors.surfaceDark : Colors.white,
                                border: Border.all(
                                  color: const Color(0xFFFBBF24).withAlpha(160),
                                  width: 2.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withAlpha(isDark ? 120 : 60),
                                    blurRadius: 24,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: Icon(
                                index == 0
                                    ? Icons.self_improvement_rounded
                                    : index == 1
                                        ? Icons.wb_sunny_rounded
                                        : Icons.access_time_filled_rounded,
                                size: 52,
                                color: isDark ? const Color(0xFFFDE68A) : AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),

                        // Title & Subtitle
                        Text(
                          page['title']!,
                          textAlign: TextAlign.center,
                          style: AppTypography.displayMedium(isDark: isDark).copyWith(
                            color: isDark ? Colors.white : AppColors.primaryDark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page['subtitle']!,
                          textAlign: TextAlign.center,
                          style: AppTypography.bodyLarge(isDark: isDark).copyWith(
                            color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Spiritual Quote Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isDark ? const Color(0xFF334155) : const Color(0xFFFDE68A),
                            ),
                          ),
                          child: Text(
                            page['quote']!,
                            style: AppTypography.spiritualQuote(isDark: isDark).copyWith(
                              fontSize: 13,
                              color: isDark ? const Color(0xFFFDE68A) : const Color(0xFF92400E),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                },
              ),
            ),

            // Indicator Dots & Navigation Actions
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primary
                              : (isDark ? Colors.white24 : AppColors.borderLight),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: _currentPage == _pages.length - 1 ? 'Begin Spiritual Journey' : 'Continue',
                    icon: Icons.arrow_forward_rounded,
                    backgroundColor: isDark ? AppColors.primaryLight : AppColors.primary,
                    onPressed: () {
                      if (_currentPage < _pages.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.pushReplacementNamed(context, AppRoutes.login);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
