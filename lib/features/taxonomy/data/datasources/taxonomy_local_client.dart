import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../models/taxonomy_fact_model.dart';
import '../../../../core/config/logger.dart';
import '../../../../core/constants/taxonomy_constants.dart';

/// Local database client specifically for taxonomy data storage and retrieval
class TaxonomyLocalClient {
  final String _taxonomyBoxName = TaxonomyConstants.taxonomyBoxName;
  final String _taxonomyDataKey = TaxonomyConstants.taxonomyDataKey;

  Box<dynamic>? _taxonomyBox;
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);

    Hive.registerAdapter(TaxonomyFactAdapter());
    Hive.registerAdapter(TaxonomyTypeAdapter());

    _taxonomyBox = await Hive.openBox<dynamic>(_taxonomyBoxName);
    _isInitialized = true;

    if (_taxonomyBox!.isEmpty) {
      await _loadInitialData();
    }
  }

  Future<void> _loadInitialData() async {
    try {
      logger.d('Loading taxonomy data from asset file...');
      final jsonString =
          await rootBundle.loadString('assets/fruit_taxonomy_facts.json');

      if (jsonString.isEmpty) {
        logger.d('Error: Empty JSON file');
        return;
      }

      logger.d('Parsing JSON data...');
      final jsonData = json.decode(jsonString);

      final taxonomyData = TaxonomyType.fromJson(jsonData);

      logger.d('Storing taxonomy data in Hive...');
      await _taxonomyBox!.put(_taxonomyDataKey, taxonomyData);
      logger.d('Successfully loaded taxonomy data from assets');

      final families = taxonomyData.family.keys.toList();
      logger.d('Loaded ${families.length} families: ${families.join(', ')}');
    } catch (e) {
      logger.d('Error loading initial taxonomy data: $e');
    }
  }

  Future<TaxonomyFact?> getFamilyFact(String familyName) async {
    await _ensureInitialized();

    if (familyName.isEmpty) {
      logger.d('Error: Empty family name provided');
      return null;
    }

    try {
      final taxonomyData = _taxonomyBox!.get(_taxonomyDataKey) as TaxonomyType?;

      if (taxonomyData == null) {
        logger.d('No taxonomy data found in database. Refreshing data...');
        await refreshFromAsset();
        return getFamilyFact(familyName);
      }

      if (!taxonomyData.family.containsKey(familyName)) {
        logger.d('Family "$familyName" not found in taxonomy data');
        return null;
      }

      return taxonomyData.family[familyName];
    } catch (e) {
      logger.d('Error getting family fact: $e');
      return null;
    }
  }

  Future<TaxonomyFact?> getGenusFact(String genusName) async {
    await _ensureInitialized();

    if (genusName.isEmpty) {
      logger.d('Error: Empty genus name provided');
      return null;
    }

    try {
      final taxonomyData = _taxonomyBox!.get(_taxonomyDataKey) as TaxonomyType?;

      if (taxonomyData == null) {
        logger.d('No taxonomy data found in database. Refreshing data...');
        await refreshFromAsset();
        return getGenusFact(genusName);
      }

      if (!taxonomyData.genus.containsKey(genusName)) {
        logger.d('Genus "$genusName" not found in taxonomy data');
        return null;
      }

      return taxonomyData.genus[genusName];
    } catch (e) {
      logger.d('Error getting genus fact: $e');
      return null;
    }
  }

  Future<TaxonomyFact?> getOrderFact(String orderName) async {
    await _ensureInitialized();

    if (orderName.isEmpty) {
      logger.d('Error: Empty order name provided');
      return null;
    }

    try {
      final taxonomyData = _taxonomyBox!.get(_taxonomyDataKey) as TaxonomyType?;

      if (taxonomyData == null) {
        logger.d('No taxonomy data found in database. Refreshing data...');
        await refreshFromAsset();
        return getOrderFact(orderName);
      }

      if (!taxonomyData.order.containsKey(orderName)) {
        logger.d('Order "$orderName" not found in taxonomy data');
        return null;
      }

      return taxonomyData.order[orderName];
    } catch (e) {
      logger.d('Error getting order fact: $e');
      return null;
    }
  }

  Future<TaxonomyType?> getAllTaxonomyFacts() async {
    await _ensureInitialized();
    return _taxonomyBox!.get(_taxonomyDataKey) as TaxonomyType?;
  }

  Future<bool> hasTaxonomyName(String taxonomyType, String name) async {
    await _ensureInitialized();
    if (name.isEmpty) return false;

    try {
      final taxonomyData = _taxonomyBox!.get(_taxonomyDataKey) as TaxonomyType?;
      if (taxonomyData == null) return false;

      switch (taxonomyType) {
        case TaxonomyConstants.familyType:
          return taxonomyData.family.containsKey(name);
        case TaxonomyConstants.genusType:
          return taxonomyData.genus.containsKey(name);
        case TaxonomyConstants.orderType:
          return taxonomyData.order.containsKey(name);
        default:
          return false;
      }
    } catch (e) {
      logger.d('Error checking if taxonomy name exists: $e');
      return false;
    }
  }

  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await init();
    }
  }

  Future<void> close() async {
    await _taxonomyBox?.close();
    _isInitialized = false;
  }

  Future<void> clearAll() async {
    await _ensureInitialized();
    await _taxonomyBox!.clear();
  }

  Future<void> refreshFromAsset() async {
    await _ensureInitialized();
    await _loadInitialData();
  }
}
