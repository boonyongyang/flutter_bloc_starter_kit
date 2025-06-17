import 'package:hive_ce/hive.dart';

import '../../../../core/config/logger.dart';

part 'taxonomy_fact_model.g.dart';

/// Model representing taxonomy facts for a specific taxonomy entity.
///
/// Used for displaying taxonomy information and fun facts in the app.
@HiveType(typeId: 2)
class TaxonomyFact {
  /// Main description of the taxonomic entity.
  @HiveField(0)
  final String description;

  /// List of interesting facts about the taxonomic entity.
  @HiveField(1)
  final List<String> funFacts;

  /// Creates a [TaxonomyFact] with a description and fun facts.
  TaxonomyFact({
    required this.description,
    required this.funFacts,
  });

  /// Creates a [TaxonomyFact] from a JSON map.
  factory TaxonomyFact.fromJson(Map<String, dynamic> json) {
    // Extract values with default fallbacks for robustness
    final description = json['description'] ?? 'No description available';
    final funFactsRaw = json['funFacts'];

    // Process fun facts with validation
    List<String> funFacts = [];
    if (funFactsRaw != null) {
      if (funFactsRaw is List) {
        // Filter out any null values and convert all items to strings
        funFacts = funFactsRaw
            .where((item) => item != null)
            .map((item) => item.toString())
            .toList();
      } else {
        logger.d('Warning: funFacts is not a list, using empty list instead');
      }
    }

    // If description is not a string, convert it to string
    final String descriptionStr =
        description is String ? description : description.toString();

    return TaxonomyFact(
      description: descriptionStr,
      funFacts: funFacts,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'funFacts': funFacts,
    };
  }
}

/// Container model for all taxonomy facts grouped by taxonomy type
@HiveType(typeId: 3)
class TaxonomyType {
  /// Maps family names to their corresponding taxonomy facts
  @HiveField(0)
  final Map<String, TaxonomyFact> family;

  /// Maps genus names to their corresponding taxonomy facts
  @HiveField(1)
  final Map<String, TaxonomyFact> genus;

  /// Maps order names to their corresponding taxonomy facts
  @HiveField(2)
  final Map<String, TaxonomyFact> order;

  TaxonomyType({
    required this.family,
    required this.genus,
    required this.order,
  });

  factory TaxonomyType.fromJson(Map<String, dynamic> json) {
    return TaxonomyType(
      family: _parseFactMap(json['family'] as Map<String, dynamic>? ?? {}),
      genus: _parseFactMap(json['genus'] as Map<String, dynamic>? ?? {}),
      order: _parseFactMap(json['order'] as Map<String, dynamic>? ?? {}),
    );
  }

  static Map<String, TaxonomyFact> _parseFactMap(Map<String, dynamic> json) {
    final Map<String, TaxonomyFact> result = {};
    json.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        try {
          result[key] = TaxonomyFact.fromJson(value);
        } catch (e) {
          logger.d('Error parsing taxonomy fact for $key: $e');
        }
      }
    });
    return result;
  }
}
