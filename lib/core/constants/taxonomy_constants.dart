import 'package:flutter/material.dart';
import '../style/style.dart';

/// Taxonomy type constants and info
class TaxonomyConstants {
  // Types
  static const String familyType = 'family';
  static const String genusType = 'genus';
  static const String orderType = 'order';

  // Database
  static const String taxonomyBoxName = 'taxonomy_facts';
  static const String taxonomyDataKey = 'all_taxonomy_data';

  // Assets
  static const String taxonomyFactsAssetPath =
      'assets/fruit_taxonomy_facts.json';

  // UI icons
  static const Map<String, String> taxonomyIcons = {
    familyType: '👨‍👩‍👧‍👦',
    genusType: '🌿',
    orderType: '🔄',
  };

  // Display names
  static const Map<String, String> taxonomyDisplayNames = {
    familyType: 'Family',
    genusType: 'Genus',
    orderType: 'Order',
  };

  // Icons and colors
  static const Map<String, ({IconData icon, Color color, String tooltip})>
      taxonomyInfo = {
    familyType: (
      icon: Icons.family_restroom,
      color: AppColors.neonBlue,
      tooltip: 'Botanical family'
    ),
    genusType: (
      icon: Icons.eco,
      color: AppColors.successGreen,
      tooltip: 'Genus classification'
    ),
    orderType: (
      icon: Icons.account_tree,
      color: AppColors.cyberpunkPurple,
      tooltip: 'Order in plant taxonomy'
    ),
  };

  TaxonomyConstants._();
}
