// lib/features/bundles/presentation/widgets/bundle_card.dart
import 'package:flutter/material.dart';
import '../../domain/entities/bundle.dart';

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
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  _buildTypeIcon(),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bundle.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (bundle.description != null)
                          Text(
                            bundle.description!,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                  _buildActions(),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Progress indicator
              _buildProgressIndicator(context),
              
              const SizedBox(height: 12),
              
              // Document count and type tags
              Row(
                children: [
                  Icon(Icons.description, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    '${bundle.documents.length} documents',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Spacer(),
                  _buildTypeChip(),
                ],
              ),
              
              // Required document types (if it's a template-based bundle)
              if (bundle.requiredDocumentTypes.isNotEmpty) ...[
                const SizedBox(height: 8),
                _buildRequiredDocuments(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeIcon() {
    IconData icon;
    Color color;
    
    switch (bundle.type) {
      case BundleType.smart:
        icon = Icons.auto_awesome;
        color = Colors.purple;
        break;
      case BundleType.template:
        icon = Icons.content_copy;
        color = Colors.blue;
        break;
      case BundleType.manual:
      default:
        icon = Icons.folder;
        color = Colors.orange;
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

  Widget _buildActions() {
    return Row(
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
    );
  }

  Widget _buildProgressIndicator(BuildContext context) {
    final progress = _calculateProgress();
    final progressText = bundle.requiredDocumentTypes.isEmpty 
        ? 'No requirements'
        : '${(progress * 100).round()}% complete';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Completion',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              progressText,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: _getProgressColor(progress),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation(_getProgressColor(progress)),
        ),
      ],
    );
  }

  Widget _buildTypeChip() {
    String label;
    Color color;
    
    switch (bundle.type) {
      case BundleType.smart:
        label = 'Smart';
        color = Colors.purple;
        break;
      case BundleType.template:
        label = 'Template';
        color = Colors.blue;
        break;
      case BundleType.manual:
      default:
        label = 'Manual';
        color = Colors.orange;
        break;
    }
    
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide(color: color.withOpacity(0.3)),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget _buildRequiredDocuments(BuildContext context) {
    final presentTypes = bundle.documents.map((doc) => doc.type.name).toSet();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Required Documents:',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: bundle.requiredDocumentTypes.map((type) {
            final isPresent = presentTypes.contains(type);
            return Chip(
              label: Text(
                type.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  color: isPresent ? Colors.green[700] : Colors.red[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
              backgroundColor: isPresent ? Colors.green[50] : Colors.red[50],
              side: BorderSide(
                color: isPresent ? Colors.green[300]! : Colors.red[300]!,
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
          }).toList(),
        ),
      ],
    );
  }

  double _calculateProgress() {
    if (bundle.requiredDocumentTypes.isEmpty) return 1.0;
    
    final presentTypes = bundle.documents.map((doc) => doc.type.name).toSet();
    final requiredCount = bundle.requiredDocumentTypes.length;
    final presentRequiredCount = bundle.requiredDocumentTypes
        .where((type) => presentTypes.contains(type))
        .length;
    
    return presentRequiredCount / requiredCount;
  }

  Color _getProgressColor(double progress) {
    if (progress >= 1.0) return Colors.green;
    if (progress >= 0.7) return Colors.orange;
    return Colors.red;
  }
}
