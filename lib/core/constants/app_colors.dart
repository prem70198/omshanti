import 'package:flutter/material.dart';

/// Centralized color palette for Om Shanti
/// Authentic spiritual palette aligned with the official Brahma Kumaris visual identity
/// (Reference: https://www.brahmakumaris.com/)
class AppColors {
  // 1. Primary Brahma Kumaris Crimson Palette
  // The iconic sacred spiritual red/crimson representing Shiva Baba, the Supreme Light
  static const Color primary = Color(0xFFA92815); // Brahma Kumaris Crimson Red
  static const Color primaryDark = Color(0xFF801809); // Deep Spiritual Maroon
  static const Color primaryLight = Color(0xFFC8321B); // Radiant Vermilion Red
  static const Color primaryContainer = Color(0xFFFEE2E2); // Gentle Red/Rose tinted container
  static const Color primarySubtle = Color(0xFFFFF1F0); // Very light divine tint

  // 2. Secondary Celestial Ocean of Peace Palette
  // Signifying spiritual depth, serene calmness, and the ocean of peace
  static const Color secondary = Color(0xFF0284C7); // Peaceful Sky Blue
  static const Color secondaryDark = Color(0xFF0369A1); // Deep Ocean Blue
  static const Color secondaryLight = Color(0xFF38A9FF); // Celestial Light Blue
  static const Color secondaryContainer = Color(0xFFE0F2FE); // Calm Water container

  // 3. Paramdham Divine Golden Aura Palette
  // The incorporeal Golden-Red World of Silence (Paramdham / Shantidham)
  static const Color amberGold = Color(0xFFF59E0B); // Golden Aura
  static const Color amberGoldDark = Color(0xFFD97706); // Deep Amber
  static const Color amberLight = Color(0xFFFDE68A); // Soft Golden Glow
  static const Color amberContainer = Color(0xFFFEF3C7); // Warm Golden container

  // 4. Accent Colors
  static const Color accentSunrise = Color(0xFFEA580C); // Amritvela Sunrise Orange
  static const Color accentTeal = Color(0xFF0D9488); // Serene Sage Purity
  static const Color accentRose = Color(0xFFE11D48); // Sacred Rose
  static const Color liveRed = Color(0xFFDC2626); // Live Broadcast Red

  // 5. Background & Surface - Light (Pure Serene White & Warm Ivory)
  // Refined for high-contrast, pure, pristine spiritual feel
  static const Color backgroundLight = Color(0xFFFAF9F5); // Serene warm ivory/white
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceVariantLight = Color(0xFFF3F2EC); // Elegant soft stone
  static const Color cardBgLight = Color(0xFFFFFFFF);
  static const Color inputFillLight = Color(0xFFF5F4EE);

  // 6. Background & Surface - Dark (Paramdham Cosmic Stillness)
  static const Color backgroundDark = Color(0xFF0C0A10); // Deep cosmic void
  static const Color surfaceDark = Color(0xFF171422); // Night meditation chamber
  static const Color surfaceVariantDark = Color(0xFF231F33); // Subtle elevated surface
  static const Color cardBgDark = Color(0xFF1B1828);
  static const Color inputFillDark = Color(0xFF211D30);

  // 7. Text Colors
  static const Color textPrimaryLight = Color(0xFF1C1917); // Crisp Warm Black
  static const Color textSecondaryLight = Color(0xFF57534E); // Refined Stone Slate
  static const Color textTertiaryLight = Color(0xFF9C9791); // Soft Muted Gray

  static const Color textPrimaryDark = Color(0xFFFAF9F6); // Soft Pearl White
  static const Color textSecondaryDark = Color(0xFFD4D0D0);
  static const Color textTertiaryDark = Color(0xFF9E9A9A);

  // 8. Border & Divider (Subtle, feather-light modern borders)
  static const Color borderLight = Color(0xFFE8E6DF);
  static const Color borderDark = Color(0xFF2E2A3E);

  // Modern Soft BoxShadows (Breathable, floating feel)
  static List<BoxShadow> get cardShadowLight => [
        BoxShadow(
          color: const Color(0xFF1C1917).withValues(alpha: 0.04),
          blurRadius: 18,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get cardShadowElevated => [
        BoxShadow(
          color: const Color(0xFF1C1917).withValues(alpha: 0.08),
          blurRadius: 28,
          offset: const Offset(0, 10),
        ),
      ];

  static List<BoxShadow> get auraShadow => [
        BoxShadow(
          color: primary.withValues(alpha: 0.25),
          blurRadius: 22,
          offset: const Offset(0, 8),
        ),
      ];

  // 9. Status & Utility Colors
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFDC2626);
  static const Color info = Color(0xFF0284C7);

  // 10. Brahma Kumaris Spiritual Gradients
  // The iconic Paramdham golden-red aura representing the Supreme Father Shiva
  static const LinearGradient paramdhamGradient = LinearGradient(
    colors: [Color(0xFFA92815), Color(0xFFD97706), Color(0xFFF59E0B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient auraGradient = LinearGradient(
    colors: [Color(0xFFA92815), Color(0xFFEA580C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sereneGradient = LinearGradient(
    colors: [Color(0xFF801809), Color(0xFFA92815)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient peaceOceanGradient = LinearGradient(
    colors: [Color(0xFF0369A1), Color(0xFF38A9FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sunriseGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFEA580C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient livePulseGradient = LinearGradient(
    colors: [Color(0xFFDC2626), Color(0xFFEF4444)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const RadialGradient shivaRadiance = RadialGradient(
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFFDE68A),
      Color(0xFFF59E0B),
      Color(0xFFA92815),
      Colors.transparent,
    ],
    stops: [0.0, 0.15, 0.45, 0.85, 1.0],
  );

  // 11. Bronze / Golden Accent for Spiritual Journal Actions (Figure 4)
  static const Color bronzeButton = Color(0xFFBF8A58);
  static const Color bronzeButtonDark = Color(0xFFA37041);
  static const Color goldCardBorder = Color(0xFFE5C07B);
  static const Color goldCardBg = Color(0xFFFFFDF7);

  // 12. Celestial Ocean Breathing Theme (Figure 3)
  static const LinearGradient celestialOceanGradient = LinearGradient(
    colors: [Color(0xFF08263A), Color(0xFF0E3E5B), Color(0xFF092A40)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // 13. Cosmic Void Night Meditation Theme (Figure 2)
  static const LinearGradient cosmicVoidGradient = LinearGradient(
    colors: [Color(0xFF07050C), Color(0xFF0F0B1A), Color(0xFF0A0714)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
