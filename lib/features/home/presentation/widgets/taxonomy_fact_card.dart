import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../blocs/taxonomy_cubit.dart';
import '../../../../blocs/taxonomy_state.dart';
import '../../../../core/constants/taxonomy_constants.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/style/style.dart';
import '../../../../models/fruit_model.dart';
import '../../../../models/taxonomy_fact_model.dart';

class TaxonomyFactCard extends StatefulWidget {
  final Fruit fruit;

  const TaxonomyFactCard({
    super.key,
    required this.fruit,
  });

  @override
  State<TaxonomyFactCard> createState() => _TaxonomyFactCardState();
}

class _TaxonomyFactCardState extends State<TaxonomyFactCard> {
  late final TaxonomyCubit _taxonomyCubit;
  String _selectedType = kFamilyType; // Default to family

  @override
  void initState() {
    super.initState();
    _taxonomyCubit = TaxonomyCubit(locator());
    _loadFact();
  }

  @override
  void dispose() {
    _taxonomyCubit.close();
    super.dispose();
  }

  void _loadFact() {
    final fruit = widget.fruit;

    // Add debug logging
    print('Loading ${_selectedType} fact for: ${fruit.name}');
    print(
        'Family: ${fruit.family}, Genus: ${fruit.genus}, Order: ${fruit.order}');

    switch (_selectedType) {
      case kFamilyType:
        if (fruit.family.isEmpty) {
          print('Warning: Fruit has empty family name');
        }
        _taxonomyCubit.getFamilyFact(fruit.family);
        break;
      case kGenusType:
        if (fruit.genus.isEmpty) {
          print('Warning: Fruit has empty genus name');
        }
        _taxonomyCubit.getGenusFact(fruit.genus);
        break;
      case kOrderType:
        if (fruit.order.isEmpty) {
          print('Warning: Fruit has empty order name');
        }
        _taxonomyCubit.getOrderFact(fruit.order);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _taxonomyCubit,
      child: BlocBuilder<TaxonomyCubit, TaxonomyState>(
        builder: (context, state) {
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: _getColorForType().withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  Divider(
                    height: 24,
                    color: _getColorForType().withOpacity(0.3),
                  ),
                  _buildContent(context, state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.science_outlined, color: AppColors.neonBlue),
            const Gap(8),
            Text(
              'Taxonomy Facts',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Center(
          child: SizedBox(
            // Setting a width constraint to ensure proper sizing
            width: MediaQuery.of(context).size.width * 0.8,
            child: _buildTypeSelector(),
          ),
        ),
      ],
    );
  }

  Widget _buildTypeSelector() {
    return SegmentedButton<String>(
      segments: const [
        ButtonSegment<String>(
          value: kFamilyType,
          icon: Icon(Icons.family_restroom, size: 16),
          label: Text('Family', style: TextStyle(fontSize: 12)),
        ),
        ButtonSegment<String>(
          value: kGenusType,
          icon: Icon(Icons.spa, size: 16),
          label: Text('Genus', style: TextStyle(fontSize: 12)),
        ),
        ButtonSegment<String>(
          value: kOrderType,
          icon: Icon(Icons.sort, size: 16),
          label: Text('Order', style: TextStyle(fontSize: 12)),
        ),
      ],
      selected: {_selectedType},
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onSelectionChanged: (Set<String> selection) {
        setState(() {
          _selectedType = selection.first;
          _loadFact();
        });
      },
    );
  }

  Widget _buildContent(BuildContext context, TaxonomyState state) {
    if (state is TaxonomyLoading) {
      final displayType = kTaxonomyDisplayNames[_selectedType] ?? _selectedType;
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(_getColorForType()),
              ),
              const SizedBox(height: 16),
              Text(
                'Loading $displayType information...',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _getColorForType(),
                    ),
              ),
            ],
          ),
        ),
      );
    } else if (state is TaxonomyLoaded) {
      return _buildFactDisplay(context, state.fact, state.taxonomyName);
    } else if (state is TaxonomyError) {
      // Handle error state with more user-friendly message and retry option
      return _buildErrorDisplay(context, state.message);
    } else {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Select a taxonomy type to view information'),
        ),
      );
    }
  }

  Widget _buildFactDisplay(
    BuildContext context,
    TaxonomyFact fact,
    String taxonomyName,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: BoxDecoration(
            color: _getColorForType().withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _getTaxonomyTypeIcon(),
                style: const TextStyle(fontSize: 20),
              ),
              const Gap(8),
              Text(
                taxonomyName,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: _getColorForType(),
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
        const Gap(16),
        Text(
          fact.description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const Gap(16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: _getColorForType().withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 16,
                    color: _getColorForType(),
                  ),
                  const Gap(6),
                  Text(
                    'Fun Facts',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: _getColorForType(),
                        ),
                  ),
                ],
              ),
              const Gap(8),
              ...fact.funFacts.map((funFact) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('•',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _getColorForType(),
                            )),
                        const Gap(8),
                        Expanded(
                          child: Text(
                            funFact,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  // Helper method to build error display
  Widget _buildErrorDisplay(BuildContext context, String message) {
    final displayType = kTaxonomyDisplayNames[_selectedType] ??
        _selectedType[0].toUpperCase() + _selectedType.substring(1);

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.info_outline, color: Colors.red.shade400, size: 32),
          const SizedBox(height: 16),
          Text(
            'No taxonomy information available',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          // Show which category was missing
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '$displayType: ${_getTaxonomyName()}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.red.shade800,
                  ),
            ),
          ),
          const SizedBox(height: 20),
          // Add retry button
          ElevatedButton.icon(
            onPressed: _loadFact,
            icon: const Icon(Icons.refresh, size: 16),
            label: const Text('Try Again'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.neonBlue),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Get the current taxonomy name based on selected type
  String _getTaxonomyName() {
    switch (_selectedType) {
      case kFamilyType:
        return widget.fruit.family;
      case kGenusType:
        return widget.fruit.genus;
      case kOrderType:
        return widget.fruit.order;
      default:
        return '';
    }
  }

  String _getTaxonomyTypeIcon() {
    return kTaxonomyIcons[_selectedType] ?? '🔍';
  }

  Color _getColorForType() {
    switch (_selectedType) {
      case kFamilyType:
        return AppColors.neonBlue;
      case kGenusType:
        return AppColors.successGreen;
      case kOrderType:
        return AppColors.cyberpunkPurple;
      default:
        return AppColors.matrixSilver;
    }
  }
}
