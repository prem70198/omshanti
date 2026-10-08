import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  /// Divine & Sacred Display Headings (Philosopher - dignified, spiritual yet modern)
  static TextStyle displayLarge({bool isDark = false}) => GoogleFonts.philosopher(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        height: 1.25,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  static TextStyle displayMedium({bool isDark = false}) => GoogleFonts.philosopher(
        fontSize: 25,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
        height: 1.3,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  static TextStyle titleLarge({bool isDark = false}) => GoogleFonts.philosopher(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  /// Modern, crisp, readable UI Titles & Subheadings (Plus Jakarta Sans)
  static TextStyle headlineMedium({bool isDark = false}) => GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        height: 1.35,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  static TextStyle titleMedium({bool isDark = false}) => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.1,
        height: 1.4,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  static TextStyle titleSmall({bool isDark = false}) => GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
        height: 1.4,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  /// Body text with generous line heights and balanced readability (Plus Jakarta Sans)
  static TextStyle bodyLarge({bool isDark = false}) => GoogleFonts.plusJakartaSans(
        fontSize: 15.5,
        fontWeight: FontWeight.w400,
        height: 1.6,
        letterSpacing: 0.1,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  static TextStyle bodyMedium({bool isDark = false}) => GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.55,
        letterSpacing: 0.1,
        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
      );

  static TextStyle bodySmall({bool isDark = false}) => GoogleFonts.plusJakartaSans(
        fontSize: 12.5,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0.1,
        color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight,
      );

  /// Buttons, Tabs & Interactive Labels (Plus Jakarta Sans)
  static TextStyle labelLarge({bool isDark = false}) => GoogleFonts.plusJakartaSans(
        fontSize: 14.5,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  static TextStyle labelMedium({bool isDark = false}) => GoogleFonts.plusJakartaSans(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
      );

  static TextStyle labelSmall({bool isDark = false}) => GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
        color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight,
      );

  /// Spiritual quotes, Murli nectar & contemplation verses (Lora Serif)
  static TextStyle spiritualQuote({bool isDark = false}) => GoogleFonts.lora(
        fontSize: 15,
        fontStyle: FontStyle.italic,
        height: 1.65,
        fontWeight: FontWeight.w500,
        color: isDark ? const Color(0xFFFDE68A) : AppColors.primaryDark,
      );

  static TextStyle spiritualHeadline({bool isDark = false}) => GoogleFonts.philosopher(
        fontSize: 23,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
        color: isDark ? AppColors.primaryLight : AppColors.primary,
      );

  static TextStyle badgeText({bool isDark = false, Color? color}) => GoogleFonts.plusJakartaSans(
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
        color: color ?? (isDark ? Colors.white : AppColors.primaryDark),
      );
}
