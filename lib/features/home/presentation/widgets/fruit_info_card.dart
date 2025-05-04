import 'package:flutter/material.dart';

import '../../../../models/fruit_model.dart';
import '../../../../core/style/app_colors.dart';

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
                const SizedBox(width: 20),
                Expanded(
                  child: _buildFruitHeader(context),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _buildFruitDescription(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFruitAvatar(BuildContext context) {
    return CircleAvatar(
      radius: 32,
      backgroundColor: AppColors.neonAqua.withOpacity(0.15),
      child: Text(
        fruit.name.isNotEmpty ? fruit.name[0].toUpperCase() : '',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.neonAqua,
              fontWeight: FontWeight.bold,
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
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          '${fruit.family} family · ${fruit.genus} genus',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.matrixSilver),
        ),
      ],
    );
  }

  Widget _buildFruitDescription(BuildContext context) {
    return Text(
      'The ${fruit.name} is a member of the ${fruit.family} family and belongs to the ${fruit.genus} genus. It is classified under the order ${fruit.order}.',
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
