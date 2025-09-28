import 'package:flutter/material.dart';

/// App theme configuration matching Leatherology exactly
class AppTheme {
  // Color palette matching Leatherology
  static const Color primaryColor = Color(0xFF2C2C2C); // Dark charcoal
  static const Color secondaryColor = Color(0xFF8B4513); // Saddle brown
  static const Color accentColor = Color(0xFFD4AF37); // Gold accent
  static const Color backgroundColor = Color(0xFFFFFFFF); // Pure white
  static const Color surfaceColor = Color(0xFFF8F8F8); // Light gray
  static const Color textPrimary = Color(0xFF2C2C2C); // Dark text
  static const Color textSecondary = Color(0xFF666666); // Medium gray
  static const Color textLight = Color(0xFF999999); // Light gray
  static const Color borderColor = Color(0xFFE0E0E0); // Light border
  static const Color errorColor = Color(0xFFE53E3E); // Red for errors

  // Typography - matching Leatherology exactly
  static const String fontFamily = 'Helvetica Neue, Helvetica, Arial, sans-serif';

  // Text styles matching Leatherology - INCREASED SIZES
  static const TextStyle heading1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 64, // Increased from 48
    fontWeight: FontWeight.w300,
    color: textPrimary,
    height: 1.2,
    letterSpacing: 0.5,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 42, // Increased from 32
    fontWeight: FontWeight.w300,
    color: textPrimary,
    height: 1.3,
    letterSpacing: 0.3,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32, // Increased from 24
    fontWeight: FontWeight.w300,
    color: textPrimary,
    height: 1.4,
    letterSpacing: 0.2,
  );

  static const TextStyle heading4 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 26, // Increased from 20
    fontWeight: FontWeight.w400,
    color: textPrimary,
    height: 1.4,
    letterSpacing: 0.1,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24, // Increased from 18
    fontWeight: FontWeight.w300,
    color: textPrimary,
    height: 1.6,
    letterSpacing: 0.1,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20, // Increased from 16
    fontWeight: FontWeight.w300,
    color: textPrimary,
    height: 1.5,
    letterSpacing: 0.1,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18, // Increased from 14
    fontWeight: FontWeight.w300,
    color: textSecondary,
    height: 1.4,
    letterSpacing: 0.1,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16, // Increased from 12
    fontWeight: FontWeight.w300,
    color: textLight,
    height: 1.3,
    letterSpacing: 0.2,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18, // Increased from 14
    fontWeight: FontWeight.w400,
    color: backgroundColor,
    height: 1.2,
    letterSpacing: 1.0,
  );

  static const TextStyle navigation = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18, // Increased from 14
    fontWeight: FontWeight.w400,
    color: textPrimary,
    height: 1.2,
    letterSpacing: 0.5,
  );

  // Spacing matching Leatherology
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
  static const double spacingXXXL = 64.0;

  // Border radius
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;

  // Shadows
  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];

  // Main theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: backgroundColor,
        error: errorColor,
        onPrimary: backgroundColor,
        onSecondary: backgroundColor,
        onSurface: textPrimary,
        onError: backgroundColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: textPrimary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: backgroundColor,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: spacingXL,
            vertical: spacingM,
          ),
          textStyle: button,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: spacingXL,
            vertical: spacingM,
          ),
          textStyle: button.copyWith(color: primaryColor),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: button.copyWith(color: primaryColor),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusM),
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusM),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusM),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusM),
          borderSide: const BorderSide(color: errorColor),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spacingM,
          vertical: spacingM,
        ),
        hintStyle: bodyMedium.copyWith(color: textLight),
      ),
      cardTheme: CardThemeData(
        color: backgroundColor,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusL),
          side: const BorderSide(color: borderColor),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: borderColor,
        thickness: 1,
        space: 1,
      ),
    );
  }
}