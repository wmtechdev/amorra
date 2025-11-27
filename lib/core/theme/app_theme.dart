import 'package:flutter/material.dart';

/// App Theme Configuration
/// Contains all theme-related configurations
class AppTheme {
  // Color scheme seed
  static const Color _seedColor = Colors.deepPurple;

  // Font family
  static const String _fontFamily = 'Inter';

  /// Light theme configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.light,
      ),
      fontFamily: _fontFamily,
      // Add more theme customizations here
    );
  }

  /// Dark theme configuration
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.dark,
      ),
      fontFamily: _fontFamily,
      // Add more theme customizations here
    );
  }
}

