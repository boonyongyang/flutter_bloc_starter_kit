/// Constants related to taxonomy types used throughout the application
/// These constants are used to ensure consistency and avoid magic strings

// Taxonomy type constants
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
