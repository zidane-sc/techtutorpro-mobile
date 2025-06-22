import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static final Color _primaryColor = const Color(0xFF5A67D8);

  // Light Theme Colors
  static final Color _primaryLightColor = const Color(0xFFEDF2F7);
  static final Color _lightScaffoldBackgroundColor = const Color(0xFFF7FAFC);
  static final Color _lightCardBackgroundColor = const Color(0xFFFFFFFF);

  // Dark Theme Colors
  static final Color _darkScaffoldBackgroundColor = const Color(0xFF1A1A2E);
  static final Color _darkCardBackgroundColor = const Color(0xFF162447);

  // Static getters for easy access
  static Color get primaryColor => _primaryColor;

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: _primaryColor,
    scaffoldBackgroundColor: _lightScaffoldBackgroundColor,
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
    colorScheme: ColorScheme.light(
      primary: _primaryColor,
      secondary: const Color(0xFF38B2AC),
      background: _lightScaffoldBackgroundColor,
      surface: _lightCardBackgroundColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _lightCardBackgroundColor,
      elevation: 1,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.grey[800]),
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _primaryLightColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: Colors.grey.shade500),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: _primaryColor,
    scaffoldBackgroundColor: _darkScaffoldBackgroundColor,
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    colorScheme: ColorScheme.dark(
      primary: _primaryColor,
      secondary: const Color(0xFF03DAC6),
      background: _darkScaffoldBackgroundColor,
      surface: _darkCardBackgroundColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _darkCardBackgroundColor,
      elevation: 1,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _darkCardBackgroundColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: Colors.grey.shade400),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
