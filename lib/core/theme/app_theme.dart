import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ==========================================
  // CLINICAL EDITORIAL COLOR SYSTEM
  // ==========================================

  // Core palette — deep, authoritative
  static const Color primaryNavy = Color(0xFF0F1A2E);
  static const Color accentTeal = Color(0xFF0C7C73);
  static const Color warningAmber = Color(0xFFD4880F);
  static const Color dangerRed = Color(0xFFA63D3D);
  static const Color successGreen = Color(0xFF2A7A5F);

  // Surfaces — warm paper tones
  static const Color surfaceLight = Color(0xFFF5F0E8);      // warm paper
  static const Color cardBackground = Color(0xFFFEFCF7);    // warm white
  static const Color surfaceMuted = Color(0xFFEDE8DF);       // section dividers, alternating rows
  static const Color surfaceElevated = Color(0xFFFFFFFF);    // elevated cards that pop
  static const Color borderSubtle = Color(0xFFD6D0C4);       // warm gray border
  static const Color inkLight = Color(0xFFE8E2D8);           // thin rule lines

  // Text — high contrast
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B7280);

  // Module colors — muted editorial palette
  static const Color fundamentalsColor = Color(0xFF3566A0);   // slate blue
  static const Color classificationColor = Color(0xFF6B4FA0); // dusty violet
  static const Color pathophysColor = Color(0xFF2E7D99);      // teal-blue
  static const Color bladderColor = Color(0xFF4F52B0);        // muted indigo
  static const Color bowelColor = Color(0xFFA63D3D);          // brick red
  static const Color adColor = Color(0xFF6B3FA0);             // deep plum
  static const Color respiratoryColor = Color(0xFFB85C2F);    // burnt sienna
  static const Color cardiovascularColor = Color(0xFF2A7A6F); // deep teal
  static const Color spasticityColor = Color(0xFFA33350);     // burgundy
  static const Color painColor = Color(0xFF2E5A9E);           // muted royal
  static const Color pressureColor = Color(0xFF7A3BA0);       // plum
  static const Color sexualityColor = Color(0xFF2A7A5F);      // forest
  static const Color mskColor = Color(0xFFBF6B30);            // copper
  static const Color rehabColor = Color(0xFF2E7D8F);          // dark cyan

  // Semantic block colors — warmed
  static const Color pearlBackground = Color(0xFFFEFCF7);
  static const Color pearlBorder = Color(0xFFC9960E);
  static const Color mnemonicBackground = Color(0xFFFEFCF7);
  static const Color mnemonicBorder = Color(0xFF6B4FA0);
  static const Color avoidBackground = Color(0xFFFEF0F0);
  static const Color avoidBorder = Color(0xFFA63D3D);

  // ==========================================
  // TYPOGRAPHY SYSTEM
  // ==========================================

  /// Display/heading font — sharp geometric grotesque
  static TextStyle displayFont({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
    Color color = textPrimary,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  /// Body/reading font — refined serif
  static TextStyle bodyFont({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color color = textPrimary,
    double? letterSpacing,
    double? height,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.sourceSerif4(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontStyle: fontStyle,
    );
  }

  /// Monospace/data font — for numbers and data
  static TextStyle monoFont({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w500,
    Color color = textPrimary,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  // ==========================================
  // THEME DATA
  // ==========================================

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryNavy,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: surfaceLight,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryNavy,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.spaceGrotesk(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: -0.3,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(color: borderSubtle, width: 1),
        ),
      ),
      tabBarTheme: TabBarThemeData(
        labelStyle: GoogleFonts.spaceGrotesk(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
        unselectedLabelStyle: GoogleFonts.spaceGrotesk(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.3,
        ),
        labelColor: primaryNavy,
        unselectedLabelColor: textSecondary,
        indicatorColor: primaryNavy,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: borderSubtle,
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.spaceGrotesk(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -1.0,
        ),
        headlineMedium: GoogleFonts.spaceGrotesk(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.5,
        ),
        titleLarge: GoogleFonts.spaceGrotesk(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: GoogleFonts.sourceSerif4(
          fontSize: 15,
          height: 1.65,
          color: textPrimary,
        ),
        bodyMedium: GoogleFonts.sourceSerif4(
          fontSize: 14,
          height: 1.55,
          color: textSecondary,
        ),
        labelLarge: GoogleFonts.spaceGrotesk(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: textPrimary,
        ),
        labelSmall: GoogleFonts.spaceGrotesk(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
          color: textSecondary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentTeal,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          textStyle: GoogleFonts.spaceGrotesk(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: cardBackground,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
