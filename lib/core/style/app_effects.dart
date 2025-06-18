import 'package:flutter/material.dart';

/// Visual effects, decorations, and gradients for the app theme
class AppEffects {
  // ============================================================================
  // GRADIENTS
  // ============================================================================

  static final heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.indigo.withOpacity(0.05),
      Colors.transparent,
      Colors.pink.withOpacity(0.05),
    ],
  );

  static final glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white.withOpacity(0.1),
      Colors.white.withOpacity(0.05),
    ],
  );

  static final titleGradient = LinearGradient(
    colors: [
      Colors.white,
      Colors.white.withOpacity(0.8),
    ],
  );

  static final accentTitleGradient = LinearGradient(
    colors: [
      Colors.indigo.shade300,
      Colors.white.withOpacity(0.9),
      Colors.pink.shade300,
    ],
  );

  // ============================================================================
  // DECORATIONS & EFFECTS
  // ============================================================================

  static final glassEffect = BoxDecoration(
    color: Colors.white.withOpacity(0.03),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: Colors.white.withOpacity(0.08)),
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.02),
        blurRadius: 32,
        spreadRadius: -8,
      ),
    ],
  );

  static final cardGlow = [
    BoxShadow(
      color: Colors.white.withOpacity(0.02),
      blurRadius: 20,
      spreadRadius: -4,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.5),
      blurRadius: 20,
      spreadRadius: -10,
    ),
  ];

  // ============================================================================
  // ACCENT COLOR VARIANTS
  // ============================================================================

  static final accentColors = {
    'indigo': Colors.indigo.withOpacity(0.15),
    'rose': Colors.pink.withOpacity(0.15),
    'violet': Colors.purple.withOpacity(0.15),
    'amber': Colors.amber.withOpacity(0.15),
    'cyan': Colors.cyan.withOpacity(0.15),
  };
}
