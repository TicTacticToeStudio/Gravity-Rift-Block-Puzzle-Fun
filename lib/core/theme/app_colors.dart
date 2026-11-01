import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // Backgrounds: Deep cosmic blue/purple (not pitch black)
  static const Color background = Color(0xFF1A163B);
  static const Color surface = Color(0xFF262154);

  // Accents: Neon but soft
  static const Color primary = Color(0xFF00E5FF);    // Cyan
  static const Color secondary = Color(0xFFFF4081);  // Pink

  // Board Grid Colors
  static const Color boardEmptyCell = Color(0xFF2E285F);
  static const Color boardBorder = Color(0xFF4A4291);

  // 4 Crystal Types (Bright jewels)
  static const Color crystalRuby = Color(0xFFFF5252);     // Red
  static const Color crystalSapphire = Color(0xFF448AFF); // Blue
  static const Color crystalEmerald = Color(0xFF00E676);  // Green
  static const Color crystalAmber = Color(0xFFFFD740);    // Yellow

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0A8D4);
}