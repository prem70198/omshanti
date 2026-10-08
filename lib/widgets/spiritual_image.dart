import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import 'shiva_point_of_light_widget.dart';

/// Reliable, high-aesthetic spiritual image loader with graceful fallback
class SpiritualImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final String? title;

  const SpiritualImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final clip = ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: _buildImageContent(context),
    );

    if (width != null || height != null) {
      return SizedBox(
        width: width,
        height: height,
        child: clip,
      );
    }
    return clip;
  }

  Widget _buildImageContent(BuildContext context) {
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      return Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildPlaceholder(context, isLoading: true);
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder(context, isLoading: false);
        },
      );
    }

    // If local asset or placeholder key
    return _buildPlaceholder(context, isLoading: false);
  }

  Widget _buildPlaceholder(BuildContext context, {required bool isLoading}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: isDark
            ? LinearGradient(
                colors: [
                  AppColors.surfaceDark,
                  AppColors.cardBgDark,
                  AppColors.primaryDark.withAlpha(80),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : LinearGradient(
                colors: [
                  AppColors.primarySubtle,
                  AppColors.primaryContainer,
                  const Color(0xFFFEF3C7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Subtle radiating aura
          Opacity(
            opacity: isDark ? 0.35 : 0.45,
            child: const ShivaPointOfLightWidget(
              size: 64,
              animate: false,
              showGlow: false,
            ),
          ),
          if (title != null && title!.isNotEmpty)
            Positioned(
              bottom: 8,
              left: 12,
              right: 12,
              child: Text(
                title!,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : AppColors.primaryDark,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          if (isLoading)
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
        ],
      ),
    );
  }
}
