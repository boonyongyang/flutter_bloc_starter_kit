import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/taxonomy_fact_model.dart';
import '../constants/taxonomy_constants.dart';

/// Local database client using Hive for storing and retrieving taxonomy facts
/// This demonstrates how to implement local storage with Hive
class LocalDatabaseClient {
  // Using constants from taxonomy_constants.dart
  final String _taxonomyBoxName = kTaxonomyBoxName;
  final String _taxonomyDataKey = kTaxonomyDataKey;

  Box<dynamic>? _taxonomyBox;
  bool _isInitialized = false;

  /// Initialize Hive database and open required boxes
  Future<void> init() async {
    if (_isInitialized) return;

    // Set up the Hive directory
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);

    // Register adapters (after they're generated with build_runner)
    Hive.registerAdapter(TaxonomyFactAdapter());
    Hive.registerAdapter(TaxonomyTypeAdapter());

    // Open the box
    _taxonomyBox = await Hive.openBox<dynamic>(_taxonomyBoxName);
    _isInitialized = true;

    // Load initial data if the box is empty
    if (_taxonomyBox!.isEmpty) {
      await _loadInitialData();
    }
  }

  /// Load initial data from the JSON asset
  Future<void> _loadInitialData() async {
    try {
      print('Loading taxonomy data from asset file...');
      // Load the JSON asset
      final jsonString =
          await rootBundle.loadString('assets/fruit_taxonomy_facts.json');

      if (jsonString.isEmpty) {
        print('Error: Empty JSON file');
        return;
      }

      print('Parsing JSON data...');
      final jsonData = json.decode(jsonString);

      // Parse the JSON data to our model
      final taxonomyData = TaxonomyType.fromJson(jsonData);

      // Store in Hive
      print('Storing taxonomy data in Hive...');
      await _taxonomyBox!.put(_taxonomyDataKey, taxonomyData);
      print('Successfully loaded taxonomy data from assets');

      // Debug information
      final families = taxonomyData.family.keys.toList();
      print('Loaded ${families.length} families: ${families.join(', ')}');
    } catch (e) {
      print('Error loading initial taxonomy data: $e');
      // In a real app, you might want to show a user-facing error or retry
    }
  }

  /// Get taxonomy facts for a specific family
  Future<TaxonomyFact?> getFamilyFact(String familyName) async {
    await _ensureInitialized();

    // Validate input
    if (familyName.isEmpty) {
      print('Error: Empty family name provided');
      return null;
    }

    try {
      final taxonomyData = _taxonomyBox!.get(_taxonomyDataKey) as TaxonomyType?;

      if (taxonomyData == null) {
        print('No taxonomy data found in database. Refreshing data...');
        await refreshFromAsset();
        return getFamilyFact(familyName); // Try again after refresh
      }

      if (!taxonomyData.family.containsKey(familyName)) {
        print('Family "$familyName" not found in taxonomy data');
        return null;
      }

      return taxonomyData.family[familyName];
    } catch (e) {
      print('Error getting family fact: $e');
      return null;
    }
  }

  /// Get taxonomy facts for a specific genus
  Future<TaxonomyFact?> getGenusFact(String genusName) async {
    await _ensureInitialized();

    // Validate input
    if (genusName.isEmpty) {
      print('Error: Empty genus name provided');
      return null;
    }

    try {
      final taxonomyData = _taxonomyBox!.get(_taxonomyDataKey) as TaxonomyType?;

      if (taxonomyData == null) {
        print('No taxonomy data found in database. Refreshing data...');
        await refreshFromAsset();
        return getGenusFact(genusName); // Try again after refresh
      }

      if (!taxonomyData.genus.containsKey(genusName)) {
        print('Genus "$genusName" not found in taxonomy data');
        return null;
      }

      return taxonomyData.genus[genusName];
    } catch (e) {
      print('Error getting genus fact: $e');
      return null;
    }
  }

  /// Get taxonomy facts for a specific order
  Future<TaxonomyFact?> getOrderFact(String orderName) async {
    await _ensureInitialized();

    // Validate input
    if (orderName.isEmpty) {
      print('Error: Empty order name provided');
      return null;
    }

    try {
      final taxonomyData = _taxonomyBox!.get(_taxonomyDataKey) as TaxonomyType?;

      if (taxonomyData == null) {
        print('No taxonomy data found in database. Refreshing data...');
        await refreshFromAsset();
        return getOrderFact(orderName); // Try again after refresh
      }

      if (!taxonomyData.order.containsKey(orderName)) {
        print('Order "$orderName" not found in taxonomy data');
        return null;
      }

      return taxonomyData.order[orderName];
    } catch (e) {
      print('Error getting order fact: $e');
      return null;
    }
  }

  /// Get all available taxonomy facts
  Future<TaxonomyType?> getAllTaxonomyFacts() async {
    await _ensureInitialized();
    return _taxonomyBox!.get(_taxonomyDataKey) as TaxonomyType?;
  }

  /// Check if a taxonomy name exists in the specified taxonomy type
  Future<bool> hasTaxonomyName(String taxonomyType, String name) async {
    await _ensureInitialized();
    if (name.isEmpty) return false;

    try {
      final taxonomyData = _taxonomyBox!.get(_taxonomyDataKey) as TaxonomyType?;
      if (taxonomyData == null) return false;

      switch (taxonomyType) {
        case kFamilyType:
          return taxonomyData.family.containsKey(name);
        case kGenusType:
          return taxonomyData.genus.containsKey(name);
        case kOrderType:
          return taxonomyData.order.containsKey(name);
        default:
          return false;
      }
    } catch (e) {
      print('Error checking if taxonomy name exists: $e');
      return false;
    }
  }

  /// Ensure the database is initialized before operations
  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await init();
    }
  }

  /// Close the database when not needed
  Future<void> close() async {
    await _taxonomyBox?.close();
    _isInitialized = false;
  }

  /// Clear all stored data (useful for testing)
  Future<void> clearAll() async {
    await _ensureInitialized();
    await _taxonomyBox!.clear();
  }

  /// Refresh data from asset (useful if JSON is updated)
  Future<void> refreshFromAsset() async {
    await _ensureInitialized();
    await _loadInitialData();
  }
}
