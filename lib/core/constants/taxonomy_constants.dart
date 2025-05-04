// Taxonomy type constants
import 'package:flutter/material.dart';

import '../style/style.dart';

const String kFamilyType = 'family';
const String kGenusType = 'genus';
const String kOrderType = 'order';

// Database constants
const String kTaxonomyBoxName = 'taxonomy_facts';
const String kTaxonomyDataKey = 'all_taxonomy_data';

// Asset paths
const String kTaxonomyFactsAssetPath = 'assets/fruit_taxonomy_facts.json';

// UI related taxonomy constants
const Map<String, String> kTaxonomyIcons = {
  kFamilyType: '👨‍👩‍👧‍👦',
  kGenusType: '🌿',
  kOrderType: '🔄',
};

// Display names for taxonomy types
const Map<String, String> kTaxonomyDisplayNames = {
  kFamilyType: 'Family',
  kGenusType: 'Genus',
  kOrderType: 'Order',
};

/// Taxonomy information for displaying fruit classifications
class TaxonomyInfo {
  static const Map<String, ({IconData icon, Color color, String tooltip})>
      taxonomy = {
    'family': (
      icon: Icons.family_restroom,
      color: AppColors.neonBlue,
      tooltip: 'Botanical family'
    ),
    'genus': (
      icon: Icons.eco,
      color: AppColors.successGreen,
      tooltip: 'Genus classification'
    ),
    'order': (
      icon: Icons.account_tree,
      color: AppColors.cyberpunkPurple,
      tooltip: 'Order in plant taxonomy'
    ),
  };
}
