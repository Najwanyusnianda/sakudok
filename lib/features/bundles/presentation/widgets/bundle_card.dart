// lib/features/bundles/presentation/widgets/bundle_card.dart
import 'package:flutter/material.dart';
import '../../domain/entities/bundle.dart';

// --- MAIN WIDGET (Now much simpler) ---

class BundleCard extends StatelessWidget {
  final Bundle bundle;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const BundleCard({
    super.key,
    required this.bundle,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // The Card's style is now controlled by the CardTheme in your AppTheme
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12), // Should match Card's shape radius
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BundleCardHeader(bundle: bundle, onEdit: onEdit, onDelete: onDelete),
              const SizedBox(height: 16),
              BundleProgressBar(bundle: bundle),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 12),
              BundleCardFooter(bundle: bundle),
              if (bundle.requiredDocumentTypes.isNotEmpty) ...[
                const SizedBox(height: 12),
                RequiredDocuments(bundle: bundle),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// --- REFACTORED WIDGETS ---

/// Displays the top section of the card with icon, title, and actions.
class BundleCardHeader extends StatelessWidget {
  final Bundle bundle;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const BundleCardHeader({super.key, required this.bundle, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTypeIcon(context),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bundle.name,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              if (bundle.description != null && bundle.description!.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  bundle.description!,
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ]
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onEdit != null)
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: onEdit,
                tooltip: 'Edit Bundle',
              ),
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: onDelete,
                tooltip: 'Delete Bundle',
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildTypeIcon(BuildContext context) {
    final theme = Theme.of(context);
    IconData icon;
    Color color;

    switch (bundle.type) {
      case BundleType.smart:
        icon = Icons.auto_awesome;
        color = theme.colorScheme.secondary;
        break;
      case BundleType.template:
        icon = Icons.content_copy;
        color = theme.colorScheme.tertiary;
        break;
      case BundleType.manual:
      default:
        icon = Icons.folder_copy_outlined;
        color = theme.colorScheme.primary;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }
}

/// Displays the completion progress bar for the bundle.
class BundleProgressBar extends StatelessWidget {
  final Bundle bundle;

  const BundleProgressBar({super.key, required this.bundle});

  double _calculateProgress() {
    if (bundle.requiredDocumentTypes.isEmpty) return 1.0;
    final presentTypes = bundle.documents.map((doc) => doc.mainType.name).toSet();
    final requiredCount = bundle.requiredDocumentTypes.length;
    final presentRequiredCount =
        bundle.requiredDocumentTypes.where((type) => presentTypes.contains(type)).length;
    return requiredCount == 0 ? 1.0 : presentRequiredCount / requiredCount;
  }

  Color _getProgressColor(double progress, BuildContext context) {
    if (progress >= 1.0) return Colors.green.shade600;
    if (progress >= 0.5) return Theme.of(context).colorScheme.tertiary;
    return Theme.of(context).colorScheme.error;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = _calculateProgress();
    final progressColor = _getProgressColor(progress, context);
    final progressText = bundle.requiredDocumentTypes.isEmpty
        ? '${bundle.documents.length} items'
        : '${(progress * 100).round()}% complete';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Progress', style: theme.textTheme.bodySmall),
            Text(progressText, style: theme.textTheme.bodySmall?.copyWith(color: progressColor, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          valueColor: AlwaysStoppedAnimation(progressColor),
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}

/// Displays the footer with document count and bundle type chip.
class BundleCardFooter extends StatelessWidget {
  final Bundle bundle;
  const BundleCardFooter({super.key, required this.bundle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(Icons.description_outlined, size: 16, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 6),
        Text(
          '${bundle.documents.length} documents',
          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
        const Spacer(),
        _buildTypeChip(context),
      ],
    );
  }

  Widget _buildTypeChip(BuildContext context) {
    final theme = Theme.of(context);
    String label;
    Color color;

    switch (bundle.type) {
      case BundleType.smart:
        label = 'Smart';
        color = theme.colorScheme.secondary;
        break;
      case BundleType.template:
        label = 'Template';
        color = theme.colorScheme.tertiary;
        break;
      case BundleType.manual:
      default:
        label = 'Manual';
        color = theme.colorScheme.primary;
        break;
    }

    return Chip(
      label: Text(label),
      labelStyle: theme.textTheme.labelSmall?.copyWith(color: color, fontWeight: FontWeight.bold),
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      visualDensity: VisualDensity.compact,
    );
  }
}

/// Displays the list of required documents and their status.
class RequiredDocuments extends StatelessWidget {
  final Bundle bundle;
  const RequiredDocuments({super.key, required this.bundle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final presentTypes = bundle.documents.map((doc) => doc.mainType.name).toSet();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Requirements:', style: theme.textTheme.bodySmall),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: bundle.requiredDocumentTypes.map((type) {
            final isPresent = presentTypes.contains(type);
            final color = isPresent ? Colors.green.shade700 : theme.colorScheme.error;
            final bgColor = isPresent ? Colors.green.shade50 : theme.colorScheme.errorContainer;
            return Chip(
              avatar: Icon(isPresent ? Icons.check_circle : Icons.cancel, size: 14, color: color),
              label: Text(type.toUpperCase()),
              labelStyle: theme.textTheme.labelSmall?.copyWith(color: color, fontWeight: FontWeight.bold),
              backgroundColor: bgColor,
              side: BorderSide.none,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              visualDensity: VisualDensity.compact,
            );
          }).toList(),
        ),
      ],
    );
  }
}
