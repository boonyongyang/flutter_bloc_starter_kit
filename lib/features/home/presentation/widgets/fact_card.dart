import 'package:flutter/material.dart';

import '../../../../models/fruit_model.dart';
import '../../../../core/style/app_colors.dart';

class FactCard extends StatelessWidget {
  final Fruit fruit;

  const FactCard({
    super.key,
    required this.fruit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cyberpunkPurple.withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.info_outline, color: AppColors.cyberpunkPurple),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Did you know? ${fruit.name} belongs to the ${fruit.family} family and the ${fruit.genus} genus.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
