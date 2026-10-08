import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

/// Authentic Brahma Kumaris Shiva Baba Jyoti Bindu Emblem
/// A radiant white divine star/point of light with golden-red radiating spiritual aura rays
class ShivaPointOfLightWidget extends StatefulWidget {
  final double size;
  final bool animate;
  final bool showGlow;

  const ShivaPointOfLightWidget({
    super.key,
    this.size = 40,
    this.animate = false,
    this.showGlow = true,
  });

  @override
  State<ShivaPointOfLightWidget> createState() => _ShivaPointOfLightWidgetState();
}

class _ShivaPointOfLightWidgetState extends State<ShivaPointOfLightWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    if (widget.animate) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant ShivaPointOfLightWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate != oldWidget.animate) {
      if (widget.animate) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.size;
    return SizedBox(
      width: s,
      height: s,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final scale = widget.animate ? 1.0 + (_controller.value * 0.08) : 1.0;
          return Transform.scale(
            scale: scale,
            child: CustomPaint(
              size: Size(s, s),
              painter: _ShivaJyotiPainter(
                pulseValue: widget.animate ? _controller.value : 0.5,
                showGlow: widget.showGlow,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ShivaJyotiPainter extends CustomPainter {
  final double pulseValue;
  final bool showGlow;

  _ShivaJyotiPainter({required this.pulseValue, required this.showGlow});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // 1. Outer Radiance Gradient Glow
    if (showGlow) {
      final glowPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFFFBBF24).withAlpha((180 + 50 * pulseValue).toInt()),
            AppColors.primary.withAlpha((140 + 40 * pulseValue).toInt()),
            AppColors.primaryDark.withAlpha(40),
            Colors.transparent,
          ],
          stops: const [0.0, 0.35, 0.75, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: radius));

      canvas.drawCircle(center, radius, glowPaint);
    }

    // 2. Radiating Spiritual Light Rays (16 rays of Paramdham light)
    final rayCount = 16;
    final rayPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < rayCount; i++) {
      final angle = (i * 2 * math.pi) / rayCount;
      final isMajor = i % 2 == 0;
      final rayLength = isMajor ? radius * 0.88 : radius * 0.65;
      final startOffset = radius * 0.28;

      final p1 = Offset(
        center.dx + math.cos(angle) * startOffset,
        center.dy + math.sin(angle) * startOffset,
      );
      final p2 = Offset(
        center.dx + math.cos(angle) * rayLength,
        center.dy + math.sin(angle) * rayLength,
      );

      rayPaint.color = isMajor
          ? const Color(0xFFFDE68A).withAlpha((200 + 40 * pulseValue).toInt())
          : const Color(0xFFF59E0B).withAlpha(140);
      rayPaint.strokeWidth = isMajor ? size.width * 0.04 : size.width * 0.025;

      canvas.drawLine(p1, p2, rayPaint);
    }

    // 3. Inner Golden Halo
    final haloPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white,
          const Color(0xFFFDE68A),
          AppColors.primaryLight,
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 0.38));

    canvas.drawCircle(center, radius * 0.38, haloPaint);

    // 4. Central Incorporeal Soul Star (Divine Point of Light / Jyoti Bindu)
    final starPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius * 0.16, starPaint);

    // 5. Bright Core Sparkle
    final corePaint = Paint()
      ..color = Colors.white
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2);
    canvas.drawCircle(center, radius * 0.10, corePaint);
  }

  @override
  bool shouldRepaint(covariant _ShivaJyotiPainter oldDelegate) {
    return oldDelegate.pulseValue != pulseValue || oldDelegate.showGlow != showGlow;
  }
}
