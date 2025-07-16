import 'package:flutter/material.dart';
import '../../domain/entities/bundle.dart';

class SuggestedBundleCard extends StatelessWidget {
  final Bundle bundle;

  const SuggestedBundleCard({super.key, required this.bundle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 16),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.lightbulb_outline, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(
              bundle.name,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Text(
              '${bundle.documents.length} documents',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement create bundle from suggestion
              },
              child: const Text('Create Bundle'),
            )
          ],
        ),
      ),
    );
  }
}
