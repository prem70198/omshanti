import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';

class BreathingExerciseScreen extends StatefulWidget {
  const BreathingExerciseScreen({super.key});

  @override
  State<BreathingExerciseScreen> createState() => _BreathingExerciseScreenState();
}

enum BreathingPattern { boxBreathing, deepRelaxation, pranayamaHarmony }

class _BreathingExerciseScreenState extends State<BreathingExerciseScreen>
    with SingleTickerProviderStateMixin {
  BreathingPattern _pattern = BreathingPattern.boxBreathing;
  int _secondsLeft = 4;
  int _phaseIndex = 0; // 0: Inhale, 1: Hold, 2: Exhale, 3: Hold/Stillness
  Timer? _timer;
  bool _isActive = true;
  int _sessionSeconds = 300; // 5:00

  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  final List<String> _phases = ['INHALE', 'HOLD', 'EXHALE', 'STILLNESS'];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.88, end: 1.08).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOutSine),
    );

    _startTimer();
  }

  int get _phaseDuration {
    switch (_pattern) {
      case BreathingPattern.boxBreathing:
        return 4; // 4-4-4-4
      case BreathingPattern.deepRelaxation:
        if (_phaseIndex == 0) return 4;
        if (_phaseIndex == 1) return 7;
        if (_phaseIndex == 2) return 8;
        return 2;
      case BreathingPattern.pranayamaHarmony:
        return 5; // 5-5-5-5
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isActive) return;
      setState(() {
        if (_sessionSeconds > 0) {
          _sessionSeconds--;
        }

        if (_secondsLeft > 1) {
          _secondsLeft--;
        } else {
          _phaseIndex = (_phaseIndex + 1) % _phases.length;
          _secondsLeft = _phaseDuration;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  String _formatSessionTime(int totalSeconds) {
    final m = totalSeconds ~/ 60;
    final s = totalSeconds % 60;
    return '${m.toString().padLeft(1, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF072438),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.celestialOceanGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 1. Top App Bar (Figure 3: Centered "Om Shanti" & Settings Gear)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 32),
                    Text(
                      'Om Shanti',
                      style: AppTypography.displayMedium(isDark: true).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 26,
                        letterSpacing: 1.0,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings_outlined, color: Colors.white70, size: 24),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 1),

              // 2. Central Celestial Mandala Breathing Visualizer (Figure 3)
              AnimatedBuilder(
                animation: _animController,
                builder: (context, child) {
                  return SizedBox(
                    width: 310,
                    height: 310,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer ethereal cyan glow
                        Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Container(
                            width: 290,
                            height: 290,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF38BDF8).withValues(alpha: 0.25),
                                  blurRadius: 45,
                                  spreadRadius: 6,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Ornamental Mandala Rings & Petals (Figure 3)
                        _buildMandalaPetals(context, _scaleAnimation.value),

                        // Middle Glowing Cyan Ring
                        Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Container(
                            width: 195,
                            height: 195,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF67E8F9),
                                width: 3.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF38BDF8).withValues(alpha: 0.6),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Inner Phase & Seconds Text
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _phases[_phaseIndex],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${_secondsLeft}s',
                              style: const TextStyle(
                                color: Color(0xFFE0F2FE),
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Spacer(flex: 1),

              // 3. Instruction Text (Figure 3)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Text(
                  'Breathe gently into your heart space, release all tension',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 15,
                    height: 1.4,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // 4. Frosted Glass Bottom Control Container (Figure 3)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F364E).withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Breathing Pattern',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Pattern Selector Pills (Figure 3)
                      Row(
                        children: [
                          Expanded(
                            child: _buildPatternPill(
                              label: 'Box Breathing\n(4-4-4-4)',
                              isSelected: _pattern == BreathingPattern.boxBreathing,
                              onTap: () {
                                setState(() {
                                  _pattern = BreathingPattern.boxBreathing;
                                  _secondsLeft = 4;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildPatternPill(
                              label: 'Deep Relaxation\n(4-7-8)',
                              isSelected: _pattern == BreathingPattern.deepRelaxation,
                              onTap: () {
                                setState(() {
                                  _pattern = BreathingPattern.deepRelaxation;
                                  _secondsLeft = 4;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildPatternPill(
                              label: 'Pranayama\nHarmony',
                              isSelected: _pattern == BreathingPattern.pranayamaHarmony,
                              onTap: () {
                                setState(() {
                                  _pattern = BreathingPattern.pranayamaHarmony;
                                  _secondsLeft = 5;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // Glowing Play/Pause and Session Time (Figure 3)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() => _isActive = !_isActive);
                            },
                            child: Container(
                              width: 54,
                              height: 54,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF38BDF8),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF38BDF8).withValues(alpha: 0.6),
                                    blurRadius: 16,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Icon(
                                _isActive ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                color: const Color(0xFF072438),
                                size: 32,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            _formatSessionTime(_sessionSeconds),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatternPill({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white
              : Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? const Color(0xFF0A2B42) : Colors.white70,
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMandalaPetals(BuildContext context, double scale) {
    return SizedBox(
      width: 270,
      height: 270,
      child: CustomPaint(
        painter: _MandalaPetalPainter(scale: scale),
      ),
    );
  }
}

class _MandalaPetalPainter extends CustomPainter {
  final double scale;
  _MandalaPetalPainter({required this.scale});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = const Color(0xFF67E8F9).withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    final outerRadius = 120.0 * scale;
    canvas.drawCircle(center, outerRadius * 0.95, paint);
    canvas.drawCircle(center, outerRadius * 0.85, paint..strokeWidth = 1.0);
  }

  @override
  bool shouldRepaint(covariant _MandalaPetalPainter oldDelegate) =>
      oldDelegate.scale != scale;
}
