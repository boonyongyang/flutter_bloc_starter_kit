import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/style/app_text_styles.dart';
import '../../data/models/fruit_model.dart';

class FruitInfoCard extends StatelessWidget {
  final Fruit fruit;

  const FruitInfoCard({
    super.key,
    required this.fruit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildFruitAvatar(context),
                const Gap(20),
                Expanded(
                  child: _buildFruitHeader(context),
                ),
              ],
            ),
            const Gap(14),
            _buildFruitDescription(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFruitAvatar(BuildContext context) {
    final theme = Theme.of(context);
    return CircleAvatar(
      radius: 32,
      backgroundColor: theme.colorScheme.secondary.withOpacity(0.15),
      child: Text(
        fruit.name.isNotEmpty ? fruit.name[0].toUpperCase() : '',
        style: AppTextStyles.w700p24.copyWith(
          color: theme.colorScheme.secondary,
        ),
      ),
    );
  }

  Widget _buildFruitHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fruit.name,
          style: AppTextStyles.w700p20,
        ),
        const Gap(4),
        Text(
          '${fruit.family} family · ${fruit.genus} genus',
          style: AppTextStyles.w400p14.copyWith(
              color: Theme.of(context).colorScheme.surfaceContainerHighest),
        ),
      ],
    );
  }

  Widget _buildFruitDescription(BuildContext context) {
    return Text(
      'The ${fruit.name} is a member of the ${fruit.family} family and belongs to the ${fruit.genus} genus. It is classified under the order ${fruit.order}.',
      style: AppTextStyles.w400p16,
    );
  }
}
