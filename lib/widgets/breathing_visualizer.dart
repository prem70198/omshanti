import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_typography.dart';

class BreathingVisualizer extends StatefulWidget {
  final double size;
  final String phase; // 'INHALE', 'HOLD', 'EXHALE'
  final int secondsLeft;
  final bool isInteractive;

  const BreathingVisualizer({
    super.key,
    this.size = 200,
    required this.phase,
    required this.secondsLeft,
    this.isInteractive = true,
  });

  @override
  State<BreathingVisualizer> createState() => _BreathingVisualizerState();
}

class _BreathingVisualizerState extends State<BreathingVisualizer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.82, end: 1.05).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOutSine),
    );

    _glowAnimation = Tween<double>(begin: 10.0, end: 35.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Color _getPhaseColor() {
    switch (widget.phase.toUpperCase()) {
      case 'INHALE':
        return AppColors.primaryLight;
      case 'HOLD':
        return AppColors.secondary;
      case 'EXHALE':
        return AppColors.accentTeal;
      default:
        return AppColors.primaryLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final phaseColor = _getPhaseColor();

    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer ambient glow ring
              Container(
                width: widget.size * _scaleAnimation.value,
                height: widget.size * _scaleAnimation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: phaseColor.withAlpha((_glowAnimation.value * 2.5).toInt()),
                      blurRadius: _glowAnimation.value * 1.5,
                      spreadRadius: _glowAnimation.value * 0.5,
                    ),
                  ],
                  gradient: RadialGradient(
                    colors: [
                      phaseColor.withAlpha(50),
                      phaseColor.withAlpha(10),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // Middle subtle pulsing orb
              Container(
                width: widget.size * 0.85,
                height: widget.size * 0.85,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      phaseColor.withAlpha(200),
                      AppColors.primaryDark.withAlpha(220),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                    color: Colors.white.withAlpha(80),
                    width: 2,
                  ),
                ),
              ),

              // Center text with phase & countdown
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.phase.toUpperCase(),
                    style: AppTypography.titleMedium(isDark: true).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.secondsLeft}s',
                    style: AppTypography.displayMedium(isDark: true).copyWith(
                      color: AppColors.secondaryLight,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
