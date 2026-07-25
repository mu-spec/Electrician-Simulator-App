import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF1D4ED8);

  static const Color accentGreen = Color(0xFF10B981);
  static const Color accentOrange = Color(0xFFF59E0B);
  static const Color accentPurple = Color(0xFF8B5CF6);
  static const Color accentRed = Color(0xFFEF4444);
  static const Color accentCyan = Color(0xFF06B6D4);

  // Semantic Colors
  static const Color theoryColor = primaryBlue;
  static const Color calculatorColor = accentGreen;
  static const Color diagramColor = accentOrange;
  static const Color quizColor = accentPurple;
  static const Color safetyColor = accentRed;
  static const Color aiColor = accentCyan;

  /// Global app font — same clean technical style used in Theory Academy.
  static const String fontFamily = 'Arial';

  // Type scale (used across the whole app)
  // Headings are clearly larger/bolder than body text.
  static const double displaySize = 28;
  static const double pageTitleSize = 20; // section/page H1
  static const double sectionTitleSize = 18; // card section headers
  static const double cardTitleSize = 16; // list/card titles
  static const double bodySize = 15; // normal readable text
  static const double bodySmallSize = 13; // secondary/meta
  static const double labelSize = 12; // chips/labels
  static const double captionSize = 11; // tiny captions

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: fontFamily,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: primaryBlue,
      secondary: accentGreen,
      surface: Color(0xFFF8FAFC),
      background: Color(0xFFF1F5F9),
      error: accentRed,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFF1E293B),
      onBackground: Color(0xFF1E293B),
    ),
    scaffoldBackgroundColor: const Color(0xFFF1F5F9),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      foregroundColor: const Color(0xFF1E293B),
      titleTextStyle: const TextStyle(
        fontFamily: fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Color(0xFF1E293B),
        height: 1.25,
      ),
      toolbarTextStyle: const TextStyle(
        fontFamily: fontFamily,
        fontSize: bodySize,
        fontWeight: FontWeight.w400,
        color: Color(0xFF1E293B),
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryBlue,
      unselectedItemColor: Color(0xFF94A3B8),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: captionSize,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: captionSize,
        fontWeight: FontWeight.w500,
      ),
    ),
    chipTheme: ChipThemeData(
      labelStyle: const TextStyle(
        fontFamily: fontFamily,
        fontSize: labelSize,
        fontWeight: FontWeight.w600,
      ),
      secondaryLabelStyle: const TextStyle(
        fontFamily: fontFamily,
        fontSize: labelSize,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    listTileTheme: const ListTileThemeData(
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: cardTitleSize,
        fontWeight: FontWeight.w700,
        color: Color(0xFF0F172A),
        height: 1.3,
      ),
      subtitleTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: bodySmallSize,
        fontWeight: FontWeight.w400,
        color: Color(0xFF64748B),
        height: 1.4,
      ),
    ),
    textTheme: _buildTextTheme(Brightness.light),
    primaryTextTheme: _buildTextTheme(Brightness.light),
    inputDecorationTheme: _buildInputTheme(Brightness.light),
    elevatedButtonTheme: _buildElevatedButtonTheme(),
    outlinedButtonTheme: _buildOutlinedButtonTheme(Brightness.light),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
          fontFamily: fontFamily,
          fontSize: bodySize,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      contentTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: bodySmallSize,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    dialogTheme: const DialogThemeData(
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: sectionTitleSize,
        fontWeight: FontWeight.w700,
        color: Color(0xFF0F172A),
      ),
      contentTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: bodySize,
        fontWeight: FontWeight.w400,
        color: Color(0xFF334155),
        height: 1.5,
      ),
    ),
    tabBarTheme: const TabBarThemeData(
      labelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: bodySmallSize,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: bodySmallSize,
        fontWeight: FontWeight.w500,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE2E8F0),
      thickness: 1,
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: fontFamily,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: primaryLight,
      secondary: accentGreen,
      surface: Color(0xFF1E293B),
      background: Color(0xFF0F172A),
      error: accentRed,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFFF1F5F9),
      onBackground: Color(0xFFF1F5F9),
    ),
    scaffoldBackgroundColor: const Color(0xFF0F172A),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFF1E293B),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      backgroundColor: const Color(0xFF1E293B),
      foregroundColor: const Color(0xFFF1F5F9),
      titleTextStyle: const TextStyle(
        fontFamily: fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Color(0xFFF1F5F9),
        height: 1.25,
      ),
      toolbarTextStyle: const TextStyle(
        fontFamily: fontFamily,
        fontSize: bodySize,
        fontWeight: FontWeight.w400,
        color: Color(0xFFF1F5F9),
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E293B),
      selectedItemColor: primaryLight,
      unselectedItemColor: Color(0xFF64748B),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: captionSize,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: captionSize,
        fontWeight: FontWeight.w500,
      ),
    ),
    chipTheme: ChipThemeData(
      labelStyle: const TextStyle(
        fontFamily: fontFamily,
        fontSize: labelSize,
        fontWeight: FontWeight.w600,
      ),
      secondaryLabelStyle: const TextStyle(
        fontFamily: fontFamily,
        fontSize: labelSize,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    listTileTheme: const ListTileThemeData(
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: cardTitleSize,
        fontWeight: FontWeight.w700,
        color: Color(0xFFF8FAFC),
        height: 1.3,
      ),
      subtitleTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: bodySmallSize,
        fontWeight: FontWeight.w400,
        color: Color(0xFF94A3B8),
        height: 1.4,
      ),
    ),
    textTheme: _buildTextTheme(Brightness.dark),
    primaryTextTheme: _buildTextTheme(Brightness.dark),
    inputDecorationTheme: _buildInputTheme(Brightness.dark),
    elevatedButtonTheme: _buildElevatedButtonTheme(),
    outlinedButtonTheme: _buildOutlinedButtonTheme(Brightness.dark),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
          fontFamily: fontFamily,
          fontSize: bodySize,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      contentTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: bodySmallSize,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    dialogTheme: const DialogThemeData(
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: sectionTitleSize,
        fontWeight: FontWeight.w700,
        color: Color(0xFFF8FAFC),
      ),
      contentTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: bodySize,
        fontWeight: FontWeight.w400,
        color: Color(0xFFE2E8F0),
        height: 1.5,
      ),
    ),
    tabBarTheme: const TabBarThemeData(
      labelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: bodySmallSize,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: bodySmallSize,
        fontWeight: FontWeight.w500,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF334155),
      thickness: 1,
    ),
  );

  static TextTheme _buildTextTheme(Brightness brightness) {
    final color = brightness == Brightness.light
        ? const Color(0xFF1E293B)
        : const Color(0xFFF1F5F9);
    final secondaryColor = brightness == Brightness.light
        ? const Color(0xFF64748B)
        : const Color(0xFF94A3B8);

    // Clear hierarchy: headings larger + bolder than body (Theory style, app-wide).
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: color,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: displaySize,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: color,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.25,
        color: color,
      ),
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 1.25,
        color: color,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: pageTitleSize, // 20 — page/section H1
        fontWeight: FontWeight.w700,
        height: 1.3,
        color: color,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: sectionTitleSize, // 18 — section headers
        fontWeight: FontWeight.w700,
        height: 1.3,
        color: color,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: cardTitleSize, // 16 — card titles
        fontWeight: FontWeight.w700,
        height: 1.3,
        color: color,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14.5,
        fontWeight: FontWeight.w700,
        height: 1.35,
        color: color,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: bodySmallSize,
        fontWeight: FontWeight.w600,
        height: 1.35,
        color: color,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: bodySize, // 15 — primary body
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: color,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: color,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: bodySmallSize, // 13 — meta/secondary
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: secondaryColor,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: color,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: labelSize,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: color,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: captionSize,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: secondaryColor,
      ),
    );
  }

  static InputDecorationTheme _buildInputTheme(Brightness brightness) {
    final fillColor = brightness == Brightness.light
        ? const Color(0xFFF1F5F9)
        : const Color(0xFF334155);
    final borderColor = brightness == Brightness.light
        ? const Color(0xFFE2E8F0)
        : const Color(0xFF475569);
    final hintColor = brightness == Brightness.light
        ? const Color(0xFF94A3B8)
        : const Color(0xFF94A3B8);

    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: bodySize,
        fontWeight: FontWeight.w400,
        color: hintColor,
      ),
      labelStyle: const TextStyle(
        fontFamily: fontFamily,
        fontSize: bodySmallSize,
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: accentRed),
      ),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: fontFamily,
          fontSize: bodySize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme(Brightness brightness) {
    final borderColor = brightness == Brightness.light
        ? const Color(0xFFE2E8F0)
        : const Color(0xFF475569);
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(color: borderColor),
        textStyle: const TextStyle(
          fontFamily: fontFamily,
          fontSize: bodySize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
