// lib/features/bundles/presentation/widgets/bundle_progress_indicator.dart
import 'package:flutter/material.dart';
import '../../domain/entities/bundle_slot.dart';

class BundleProgressIndicator extends StatelessWidget {
  final List<BundleSlot> slots;

  const BundleProgressIndicator({
    super.key,
    required this.slots,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final requiredSlots = slots.where((slot) => slot.isRequired).toList();
    final filledRequiredSlots = requiredSlots.where((slot) => slot.isFilled).toList();
    final totalSlots = slots.length;
    final filledSlots = slots.where((slot) => slot.isFilled).length;
    
    final requiredProgress = requiredSlots.isNotEmpty 
        ? filledRequiredSlots.length / requiredSlots.length 
        : 1.0;
    final overallProgress = totalSlots > 0 ? filledSlots / totalSlots : 0.0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.track_changes,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Bundle Progress',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getProgressColor(requiredProgress).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getProgressStatus(requiredProgress),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _getProgressColor(requiredProgress),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Required Documents Progress
            if (requiredSlots.isNotEmpty) ...[
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Required Documents',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${filledRequiredSlots.length}/${requiredSlots.length}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: _getProgressColor(requiredProgress),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: requiredProgress,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getProgressColor(requiredProgress),
                          ),
                          minHeight: 6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
            
            // Overall Progress
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Overall Progress',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${filledSlots}/${totalSlots}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: overallProgress,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          theme.colorScheme.primary,
                        ),
                        minHeight: 6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getProgressColor(double progress) {
    if (progress >= 1.0) {
      return Colors.green;
    } else if (progress >= 0.5) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String _getProgressStatus(double progress) {
    if (progress >= 1.0) {
      return 'Complete';
    } else if (progress >= 0.5) {
      return 'In Progress';
    } else {
      return 'Just Started';
    }
  }
}
