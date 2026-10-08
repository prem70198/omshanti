import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_typography.dart';

enum RegistrationButtonState {
  idle,
  loading,
  success,
}

/// A state-of-the-art interactive completion button framework designed for
/// spiritual registrations and critical milestones.
class RegistrationCompletionButton extends StatefulWidget {
  final String label;
  final String? successLabel;
  final VoidCallback? onPressed;
  final RegistrationButtonState state;
  final double height;
  final double? width;
  final IconData icon;

  const RegistrationCompletionButton({
    super.key,
    required this.label,
    this.successLabel,
    required this.onPressed,
    this.state = RegistrationButtonState.idle,
    this.height = 54,
    this.width,
    this.icon = Icons.check_circle_outline_rounded,
  });

  @override
  State<RegistrationCompletionButton> createState() =>
      _RegistrationCompletionButtonState();
}

class _RegistrationCompletionButtonState
    extends State<RegistrationCompletionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;
  late Animation<double> _shimmerAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 4.0, end: 14.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOutSine),
    );

    _shimmerAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.state == RegistrationButtonState.idle && widget.onPressed != null) {
      setState(() => _isPressed = true);
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (_isPressed) {
      setState(() => _isPressed = false);
    }
  }

  void _handleTapCancel() {
    if (_isPressed) {
      setState(() => _isPressed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isInteractive =
        widget.state == RegistrationButtonState.idle && widget.onPressed != null;

    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, child) {
        final glowSpread = widget.state == RegistrationButtonState.idle
            ? _glowAnimation.value
            : 6.0;

        return AnimatedScale(
          scale: _isPressed ? 0.96 : 1.0,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOutCubic,
          child: GestureDetector(
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            onTap: isInteractive ? widget.onPressed : null,
            child: Container(
              width: widget.width ?? double.infinity,
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: widget.state == RegistrationButtonState.success
                    ? const LinearGradient(
                        colors: [Color(0xFF059669), Color(0xFF10B981)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      )
                    : const LinearGradient(
                        colors: [
                          AppColors.primary,
                          Color(0xFFDC2626),
                          AppColors.primaryDark,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                boxShadow: [
                  BoxShadow(
                    color: widget.state == RegistrationButtonState.success
                        ? const Color(0xFF10B981).withAlpha(120)
                        : AppColors.primary.withAlpha(isInteractive ? 110 : 40),
                    blurRadius: glowSpread * 1.5,
                    spreadRadius: glowSpread * 0.2,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: const Color(0xFFF59E0B).withAlpha(40),
                    blurRadius: glowSpread * 0.8,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: Colors.white.withAlpha(isInteractive ? 60 : 20),
                  width: 1.2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // Dynamic Shimmer Light Beam
                    if (widget.state == RegistrationButtonState.idle)
                      Positioned.fill(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final w = constraints.maxWidth;
                            final xPos = _shimmerAnimation.value * w;
                            return Transform.translate(
                              offset: Offset(xPos, 0),
                              child: Container(
                                width: 50,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withAlpha(0),
                                      Colors.white.withAlpha(50),
                                      Colors.white.withAlpha(0),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                    // Central Content based on State
                    Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: ScaleTransition(scale: animation, child: child),
                          );
                        },
                        child: _buildStateContent(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStateContent() {
    switch (widget.state) {
      case RegistrationButtonState.loading:
        return Row(
          key: const ValueKey('loading'),
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.6,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Aligning Spiritual Vibration...',
              style: AppTypography.labelLarge(isDark: true).copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ],
        );

      case RegistrationButtonState.success:
        return Row(
          key: const ValueKey('success'),
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                size: 18,
                color: Color(0xFF059669),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.successLabel ?? 'Registration Complete • Om Shanti!',
              style: AppTypography.labelLarge(isDark: true).copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
          ],
        );

      case RegistrationButtonState.idle:
        return Row(
          key: const ValueKey('idle'),
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              size: 22,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Text(
              widget.label,
              style: AppTypography.labelLarge(isDark: true).copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward_rounded,
              size: 18,
              color: Color(0xFFFDE68A),
            ),
          ],
        );
    }
  }
}
