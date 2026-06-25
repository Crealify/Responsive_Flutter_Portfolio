import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class AppTheme {
  // Light Theme (Clean Minimalist)
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF8FAFC), // 60%
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF8B5CF6),
      secondary: Color(0xFF3B82F6),
      surface: Color(0xFFFFFFFF), // 30%
      onSurface: Color(0xFF1E293B),
    ),
    cardColor: const Color(0xFFFFFFFF),
    textTheme: _buildTextTheme(Brightness.light),
    useMaterial3: true,
  );

  // Dark Theme (Computer Engineer / Cyberpunk Touch)
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppConstants.bgColor, 
    colorScheme: const ColorScheme.dark(
      primary: AppConstants.primaryColor, 
      secondary: AppConstants.secondaryColor, 
      surface: AppConstants.cardColor, 
      onSurface: AppConstants.bodyTextColor,
    ),
    cardColor: AppConstants.cardColor,
    textTheme: _buildTextTheme(Brightness.dark),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered) || states.contains(WidgetState.dragged)) {
          return const Color(0xFF00F0FF).withValues(alpha: 0.8);
        }
        return const Color(0xFF00F0FF).withValues(alpha: 0.3);
      }),
      trackColor: WidgetStateProperty.all(Colors.white.withValues(alpha: 0.05)),
      thickness: WidgetStateProperty.all(6.0),
      radius: const Radius.circular(10),
      interactive: true,
    ),
    useMaterial3: true,
  );

  // Centralized Typographic Hierarchy
  static TextTheme _buildTextTheme(Brightness brightness) {
    final Color displayColor = brightness == Brightness.light ? const Color(0xFF0F172A) : const Color(0xFFFFFFFF);
    final Color bodyColor = brightness == Brightness.light ? const Color(0xFF334155) : const Color(0xFF94A3B8);

    return GoogleFonts.interTextTheme().copyWith(
      // DISPLAY: For massive hero titles
      displayLarge: GoogleFonts.outfit(fontSize: 56, fontWeight: FontWeight.w900, color: displayColor, letterSpacing: -1.5),
      displayMedium: GoogleFonts.outfit(fontSize: 48, fontWeight: FontWeight.w800, color: displayColor, letterSpacing: -1.0),
      displaySmall: GoogleFonts.outfit(fontSize: 36, fontWeight: FontWeight.w800, color: displayColor, letterSpacing: -0.5),

      // HEADLINE: For section headers
      headlineLarge: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: displayColor),
      headlineMedium: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.bold, color: displayColor),
      headlineSmall: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.w600, color: displayColor),

      // TITLE: For cards and list items
      titleLarge: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, color: displayColor),
      titleMedium: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: displayColor),
      titleSmall: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: displayColor),

      // BODY: For standard readable text
      bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, color: bodyColor, height: 1.6),
      bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: bodyColor, height: 1.6),
      bodySmall: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400, color: bodyColor),

      // LABEL: For buttons and small UI accents
      labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: displayColor, letterSpacing: 1.2),
      labelMedium: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: bodyColor, letterSpacing: 1.0),
      labelSmall: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w500, color: bodyColor, letterSpacing: 0.5),
    );
  }
}
