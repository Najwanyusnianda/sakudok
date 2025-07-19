// lib/features/bundles/presentation/widgets/document_slot_card.dart
import 'package:flutter/material.dart';
import '../../domain/entities/bundle_slot.dart';

class DocumentSlotCard extends StatelessWidget {
  final BundleSlot slot;
  final VoidCallback onAttachDocument;
  final VoidCallback? onViewDocument;
  final VoidCallback? onDetachDocument;

  const DocumentSlotCard({
    super.key,
    required this.slot,
    required this.onAttachDocument,
    this.onViewDocument,
    this.onDetachDocument,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRequired = slot.isRequired;
    final isFilled = slot.isFilled;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: _getBorderColor(theme, isRequired, isFilled),
          width: isFilled ? 2 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Status Indicator
            _buildStatusIndicator(theme, isRequired, isFilled),
            const SizedBox(width: 16),
            
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          slot.requirementName,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isFilled ? theme.colorScheme.primary : null,
                          ),
                        ),
                      ),
                      if (isRequired)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Required',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.red.shade700,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Document Type: ${slot.requiredDocType}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  if (isFilled) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 16,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Document attached',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            
            // Action Button
            if (isFilled) ...[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: onViewDocument,
                    icon: const Icon(Icons.visibility_outlined),
                    style: IconButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                      foregroundColor: theme.colorScheme.primary,
                    ),
                    tooltip: 'View Document',
                  ),
                  const SizedBox(height: 4),
                  IconButton(
                    onPressed: onDetachDocument,
                    icon: const Icon(Icons.close, size: 18),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.red.shade50,
                      foregroundColor: Colors.red.shade600,
                    ),
                    tooltip: 'Remove Document',
                  ),
                ],
              ),
            ] else ...[
              ElevatedButton.icon(
                onPressed: onAttachDocument,
                icon: const Icon(Icons.attach_file, size: 18),
                label: const Text('Lampirkan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(ThemeData theme, bool isRequired, bool isFilled) {
    if (isFilled) {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 20,
        ),
      );
    } else {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(
            color: isRequired ? Colors.red.shade300 : Colors.grey.shade300,
            width: 2,
          ),
          shape: BoxShape.circle,
        ),
        child: isRequired
            ? Icon(
                Icons.priority_high,
                color: Colors.red.shade400,
                size: 16,
              )
            : null,
      );
    }
  }

  Color _getBorderColor(ThemeData theme, bool isRequired, bool isFilled) {
    if (isFilled) {
      return theme.colorScheme.primary;
    } else if (isRequired) {
      return Colors.red.shade200;
    } else {
      return Colors.grey.shade200;
    }
  }
}
