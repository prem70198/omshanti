import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/shiva_point_of_light_widget.dart';

/// 3-Second Animated Introduction Splash Screen
///
/// Features:
/// - 3000ms choreographed entrance sequence
/// - Divine Light artwork with Paramdham radiance and fallback canvas rendering
/// - App introduction: "Welcome to Om Shanti" & "Where you can find your peace"
/// - Short description of app pillars (Murli, Rajyoga, Inner Peace)
/// - Theme-harmonized palette for seamless light/dark experience
/// - Smooth progress bar & instant skip option
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _introController;
  late AnimationController _pulseController;

  // Staggered animation stages within the 3-second timeline
  late Animation<double> _lightScaleAnimation;
  late Animation<double> _lightFadeAnimation;
  late Animation<double> _titleFadeAnimation;
  late Animation<Offset> _titleSlideAnimation;
  late Animation<double> _descFadeAnimation;
  late Animation<Offset> _descSlideAnimation;
  late Animation<double> _pillsFadeAnimation;
  late Animation<double> _progressAnimation;

  bool _navigated = false;

  @override
  void initState() {
    super.initState();

    // 3-second main sequence controller
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    // Continuous subtle breathing pulse for the divine light
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    // Stage 1: Divine light scales up & emerges (0.0s - 0.9s)
    _lightScaleAnimation = Tween<double>(begin: 0.65, end: 1.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.0, 0.35, curve: Curves.easeOutBack),
      ),
    );

    _lightFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.0, 0.25, curve: Curves.easeIn),
      ),
    );

    // Stage 2: App title "Welcome to Om Shanti" fades & glides up (0.75s - 1.8s)
    _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.25, 0.60, curve: Curves.easeOut),
      ),
    );

    _titleSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.25, 0.60, curve: Curves.easeOutCubic),
      ),
    );

    // Stage 3: Tagline & short description fade in (1.4s - 2.4s)
    _descFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.45, 0.80, curve: Curves.easeOut),
      ),
    );

    _descSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.20), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.45, 0.80, curve: Curves.easeOutCubic),
      ),
    );

    // Stage 4: Feature pills appear (1.8s - 2.7s)
    _pillsFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.60, 0.90, curve: Curves.easeIn),
      ),
    );

    // Stage 5: Progress indicator filling smoothly from 0% to 100% over 3s
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.05, 0.98, curve: Curves.linear),
      ),
    );

    // Start the 3-second animation sequence
    _introController.forward();

    // Trigger navigation at the end of 3 seconds
    _introController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToNext();
      }
    });
  }

  void _navigateToNext() {
    if (_navigated || !mounted) return;
    _navigated = true;
    Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
  }

  @override
  void dispose() {
    _introController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: _navigateToNext, // Tap anywhere to proceed immediately
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? const [
                      Color(0xFF0A070B),
                      Color(0xFF1E0B09),
                      Color(0xFF2C0A06),
                      Color(0xFF4A1009),
                    ]
                  : const [
                      Color(0xFFFFFFFF),
                      Color(0xFFFFFBF5),
                      Color(0xFFFFF4E5),
                      Color(0xFFFDE68A),
                    ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.35, 0.70, 1.0],
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                // Top skip button
                Positioned(
                  top: 16,
                  right: 20,
                  child: FadeTransition(
                    opacity: _titleFadeAnimation,
                    child: TextButton.icon(
                      onPressed: _navigateToNext,
                      style: TextButton.styleFrom(
                        foregroundColor: isDark
                            ? const Color(0xFFFDE68A)
                            : AppColors.primary,
                        backgroundColor: isDark
                            ? Colors.white.withAlpha(18)
                            : AppColors.primary.withAlpha(18),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                      label: Text(
                        'Skip',
                        style: AppTypography.labelSmall(isDark: isDark).copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                ),

                // Main Content Centered
                Center(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),

                        // 1. Divine Light Image & Radiant Aura Animation
                        FadeTransition(
                          opacity: _lightFadeAnimation,
                          child: ScaleTransition(
                            scale: _lightScaleAnimation,
                            child: AnimatedBuilder(
                              animation: _pulseController,
                              builder: (context, child) {
                                final pulse = _pulseController.value;
                                return Container(
                                  width: size.width > 400 ? 190 : 160,
                                  height: size.width > 400 ? 190 : 160,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: isDark
                                          ? [
                                              const Color(0xFFFDE68A)
                                                  .withAlpha((180 + 50 * pulse).toInt()),
                                              AppColors.primary
                                                  .withAlpha((120 + 40 * pulse).toInt()),
                                              const Color(0xFFB45309)
                                                  .withAlpha(40),
                                              Colors.transparent,
                                            ]
                                          : [
                                              const Color(0xFFF59E0B)
                                                  .withAlpha((120 + 30 * pulse).toInt()),
                                              AppColors.primary
                                                  .withAlpha((60 + 20 * pulse).toInt()),
                                              AppColors.primary
                                                  .withAlpha(20),
                                              Colors.transparent,
                                            ],
                                      stops: const [0.0, 0.45, 0.75, 1.0],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: isDark
                                            ? AppColors.primary
                                                .withAlpha((140 + 50 * pulse).toInt())
                                            : AppColors.amberGold
                                                .withAlpha((80 + 30 * pulse).toInt()),
                                        blurRadius: 36 + 12 * pulse,
                                        spreadRadius: 4 + 4 * pulse,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: size.width > 400 ? 140 : 120,
                                      height: size.width > 400 ? 140 : 120,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color(0xFFFBBF24),
                                          width: 2.5,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withAlpha(50),
                                            blurRadius: 16,
                                          ),
                                        ],
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/app_logo.png',
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            // Reliable fallback to ShivaPointOfLightWidget
                                            return Container(
                                              color: isDark
                                                  ? const Color(0xFF1E0B09)
                                                  : const Color(0xFFFFFBEB),
                                              child: const Center(
                                                child: ShivaPointOfLightWidget(
                                                  size: 80,
                                                  animate: true,
                                                  showGlow: true,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        // 2. Welcome Title with Slide & Fade
                        FadeTransition(
                          opacity: _titleFadeAnimation,
                          child: SlideTransition(
                            position: _titleSlideAnimation,
                            child: Column(
                              children: [
                                Text(
                                  'Welcome to',
                                  style: AppTypography.titleMedium(isDark: isDark).copyWith(
                                    color: isDark
                                        ? const Color(0xFFFDE68A)
                                        : AppColors.primary,
                                    letterSpacing: 2.5,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'OM SHANTI',
                                  style: AppTypography.displayLarge(isDark: isDark).copyWith(
                                    color: isDark
                                        ? Colors.white
                                        : AppColors.primaryDark,
                                    letterSpacing: 4.5,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 34,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'प्रजापिता ब्रह्माकुमारीज़ ईश्वरीय विश्व विद्यालय',
                                  textAlign: TextAlign.center,
                                  style: AppTypography.labelSmall(isDark: isDark).copyWith(
                                    color: isDark
                                        ? Colors.white70
                                        : AppColors.textSecondaryLight,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // 3. App Purpose & Description
                        FadeTransition(
                          opacity: _descFadeAnimation,
                          child: SlideTransition(
                            position: _descSlideAnimation,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.white.withAlpha(14)
                                    : Colors.white.withAlpha(190),
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: isDark
                                      ? Colors.white.withAlpha(24)
                                      : const Color(0xFFFDE68A),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(isDark ? 30 : 10),
                                    blurRadius: 14,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Where You Can Find Your Peace',
                                    textAlign: TextAlign.center,
                                    style: AppTypography.spiritualHeadline(isDark: isDark).copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: isDark
                                          ? const Color(0xFFFDE68A)
                                          : AppColors.primaryDark,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'A divine sanctuary for daily Murli wisdom, sacred Rajyoga meditation, and tranquil soul consciousness.',
                                    textAlign: TextAlign.center,
                                    style: AppTypography.bodySmall(isDark: isDark).copyWith(
                                      color: isDark
                                          ? Colors.white70
                                          : AppColors.textSecondaryLight,
                                      height: 1.45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // 4. Feature Pills
                        FadeTransition(
                          opacity: _pillsFadeAnimation,
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _buildFeaturePill(
                                icon: Icons.spa_rounded,
                                label: 'Inner Peace',
                                isDark: isDark,
                              ),
                              _buildFeaturePill(
                                icon: Icons.auto_stories_rounded,
                                label: 'Daily Murli',
                                isDark: isDark,
                              ),
                              _buildFeaturePill(
                                icon: Icons.self_improvement_rounded,
                                label: 'Rajyoga Meditation',
                                isDark: isDark,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),

                // 5. Bottom 3-Second Progress Bar & Loading Indicator
                Positioned(
                  bottom: 24,
                  left: 36,
                  right: 36,
                  child: FadeTransition(
                    opacity: _descFadeAnimation,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Animated progress track
                        AnimatedBuilder(
                          animation: _progressAnimation,
                          builder: (context, child) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                height: 4,
                                width: double.infinity,
                                color: isDark
                                    ? Colors.white12
                                    : AppColors.primary.withAlpha(25),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: _progressAnimation.value.clamp(0.0, 1.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: isDark
                                            ? const [
                                                Color(0xFFFBBF24),
                                                Color(0xFFF59E0B),
                                                AppColors.primary,
                                              ]
                                            : const [
                                                Color(0xFFF59E0B),
                                                AppColors.primary,
                                                AppColors.primaryDark,
                                              ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tap anywhere to start your journey',
                              style: AppTypography.labelSmall(isDark: isDark).copyWith(
                                color: isDark
                                    ? Colors.white60
                                    : AppColors.textTertiaryLight,
                                fontSize: 11,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.touch_app_rounded,
                              size: 13,
                              color: isDark
                                  ? const Color(0xFFFDE68A)
                                  : AppColors.primary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturePill({
    required IconData icon,
    required String label,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withAlpha(20)
            : AppColors.primary.withAlpha(15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? const Color(0xFFFDE68A).withAlpha(60)
              : AppColors.primary.withAlpha(50),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: isDark ? const Color(0xFFFDE68A) : AppColors.primary,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTypography.labelSmall(isDark: isDark).copyWith(
              color: isDark ? Colors.white : AppColors.primaryDark,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
