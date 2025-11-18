import 'package:flutter/material.dart';

/// Global color definitions for HealthConnect.
/// These should be used throughout the app for consistent theming.
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Primary brand colors
  static const Color primary = Color(0xFF3F7F7B);    // Updated brand color
  static const Color secondary = Color(0xFF6AA4B0);

  // Backgrounds and surfaces
  static const Color background = Color(0xFFF5F7F8);
  static const Color surface = Colors.white;

  // Text colors
  static const Color textPrimary = Color(0xFF1E1E1E);
  static const Color textSecondary = Color(0xFF6C757D);

  // Buttons and status
  static const Color button = Color(0xFF3E7C89);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);

  // Utility
  static const Color border = Color(0xFFE0E0E0);
  static const Color disabled = Color(0xFFBDBDBD);
}

