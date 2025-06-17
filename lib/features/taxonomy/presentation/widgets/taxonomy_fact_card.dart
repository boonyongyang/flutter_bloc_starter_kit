import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/config/logger.dart';
import '../bloc/taxonomy_cubit.dart';
import '../bloc/taxonomy_state.dart';
import '../../../../core/constants/taxonomy_constants.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/style/style.dart';
import '../../../fruits/data/models/fruit_model.dart';
import '../../data/models/taxonomy_fact_model.dart';

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
  late final ValueNotifier<String> _selectedTypeNotifier;

  @override
  void initState() {
    super.initState();
    _taxonomyCubit = TaxonomyCubit(locator());
    _selectedTypeNotifier =
        ValueNotifier(TaxonomyConstants.familyType); // Default to family
    _loadFact();
  }

  @override
  void dispose() {
    _taxonomyCubit.close();
    _selectedTypeNotifier.dispose();
    super.dispose();
  }

  void _loadFact() {
    final fruit = widget.fruit;
    final selectedType = _selectedTypeNotifier.value;

    logger.d('Loading $selectedType fact for: ${fruit.name}');
    logger.d(
        'Family: ${fruit.family}, Genus: ${fruit.genus}, Order: ${fruit.order}');

    switch (selectedType) {
      case TaxonomyConstants.familyType:
        if (fruit.family.isEmpty) {
          logger.d('Warning: Fruit has empty family name');
        }
        _taxonomyCubit.getFamilyFact(fruit.family);
        break;
      case TaxonomyConstants.genusType:
        if (fruit.genus.isEmpty) {
          logger.d('Warning: Fruit has empty genus name');
        }
        _taxonomyCubit.getGenusFact(fruit.genus);
        break;
      case TaxonomyConstants.orderType:
        if (fruit.order.isEmpty) {
          logger.d('Warning: Fruit has empty order name');
        }
        _taxonomyCubit.getOrderFact(fruit.order);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: _selectedTypeNotifier,
      builder: (context, selectedType, _) {
        return BlocProvider.value(
          value: _taxonomyCubit,
          child: BlocBuilder<TaxonomyCubit, TaxonomyState>(
            builder: (context, state) {
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: _getColorForType(selectedType).withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context, selectedType),
                      Divider(
                        height: 24,
                        color: _getColorForType(selectedType).withOpacity(0.3),
                      ),
                      _buildContent(context, state, selectedType),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, String selectedType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.science_outlined, color: AppColors.neonBlue),
            const Gap(8),
            Text(
              'Taxonomy Facts',
              style: AppTextStyles.w700p16,
            ),
          ],
        ),
        const Gap(12),
        Center(
          child: SizedBox(
            // Setting a width constraint to ensure proper sizing
            width: MediaQuery.of(context).size.width * 0.8,
            child: _buildTypeSelector(selectedType),
          ),
        ),
      ],
    );
  }

  Widget _buildTypeSelector(String selectedType) {
    return SegmentedButton<String>(
      segments: [
        ButtonSegment<String>(
          value: TaxonomyConstants.familyType,
          icon: const Icon(Icons.family_restroom, size: 16),
          label: Text('Family', style: AppTextStyles.w400p12),
        ),
        ButtonSegment<String>(
          value: TaxonomyConstants.genusType,
          icon: const Icon(Icons.spa, size: 16),
          label: Text('Genus', style: AppTextStyles.w400p12),
        ),
        ButtonSegment<String>(
          value: TaxonomyConstants.orderType,
          icon: const Icon(Icons.sort, size: 16),
          label: Text('Order', style: AppTextStyles.w400p12),
        ),
      ],
      selected: {selectedType},
      style: SegmentedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        selectedForegroundColor: Colors.white,
        selectedBackgroundColor: Colors.grey[800],
      ),
      showSelectedIcon: false,
      onSelectionChanged: (Set<String> selection) {
        _selectedTypeNotifier.value = selection.first;
        _loadFact();
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    TaxonomyState state,
    String selectedType,
  ) {
    if (state is TaxonomyLoading) {
      final displayType =
          TaxonomyConstants.taxonomyDisplayNames[selectedType] ?? selectedType;
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    _getColorForType(selectedType)),
              ),
              const Gap(16),
              Text(
                'Loading $displayType information...',
                style: AppTextStyles.w400p12.copyWith(
                  color: _getColorForType(selectedType),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (state is TaxonomyLoaded) {
      return _buildFactDisplay(
          context, state.fact, state.taxonomyName, selectedType);
    } else if (state is TaxonomyError) {
      // Handle error state with more user-friendly message and retry option
      return _buildErrorDisplay(context, state.message, selectedType);
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
    String selectedType,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: BoxDecoration(
            color: _getColorForType(selectedType).withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _getTaxonomyTypeIcon(selectedType),
                style: AppTextStyles.w400p20,
              ),
              const Gap(8),
              Text(
                taxonomyName,
                style: AppTextStyles.w600p14.copyWith(
                  color: _getColorForType(selectedType),
                ),
              ),
            ],
          ),
        ),
        const Gap(16),
        Text(
          fact.description,
          style: AppTextStyles.w400p14,
        ),
        const Gap(16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: _getColorForType(selectedType).withOpacity(0.08),
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
                    color: _getColorForType(selectedType),
                  ),
                  const Gap(6),
                  Text(
                    'Fun Facts',
                    style: AppTextStyles.w600p14.copyWith(
                      color: _getColorForType(selectedType),
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
                            style: AppTextStyles.w700p16.copyWith(
                              color: _getColorForType(selectedType),
                            )),
                        const Gap(8),
                        Expanded(
                          child: Text(
                            funFact,
                            style: AppTextStyles.w400p12,
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
  Widget _buildErrorDisplay(
      BuildContext context, String message, String selectedType) {
    final displayType = TaxonomyConstants.taxonomyDisplayNames[selectedType] ??
        selectedType[0].toUpperCase() + selectedType.substring(1);

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
          const Gap(16),
          Text(
            'No taxonomy information available',
            style: AppTextStyles.w600p14.copyWith(
              color: Colors.red.shade700,
            ),
          ),
          const Gap(8),
          // Show which category was missing
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '$displayType: ${_getTaxonomyName(selectedType)}',
              style: AppTextStyles.w400p12.copyWith(
                color: Colors.red.shade800,
              ),
            ),
          ),
          const Gap(20),
          ElevatedButton.icon(
            onPressed: _loadFact,
            icon: const Icon(Icons.refresh, size: 16),
            label: const Text('Try Again'),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColors.neonBlue),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Get the current taxonomy name based on selected type
  String _getTaxonomyName(String selectedType) {
    switch (selectedType) {
      case TaxonomyConstants.familyType:
        return widget.fruit.family;
      case TaxonomyConstants.genusType:
        return widget.fruit.genus;
      case TaxonomyConstants.orderType:
        return widget.fruit.order;
      default:
        return '';
    }
  }

  String _getTaxonomyTypeIcon(String selectedType) {
    return TaxonomyConstants.taxonomyIcons[selectedType] ?? '🔍';
  }

  Color _getColorForType(String selectedType) {
    switch (selectedType) {
      case TaxonomyConstants.familyType:
        return AppColors.neonBlue;
      case TaxonomyConstants.genusType:
        return AppColors.successGreen;
      case TaxonomyConstants.orderType:
        return AppColors.cyberpunkPurple;
      default:
        return AppColors.matrixSilver;
    }
  }
}
