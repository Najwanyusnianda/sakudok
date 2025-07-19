//lib/features/bundles/presentation/pages/bundle_detail_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/bundle_providers.dart';
import '../widgets/save_as_bundle_template_dialog.dart';
import '../widgets/document_slot_card.dart';
import '../widgets/bundle_progress_indicator.dart';
import '../widgets/document_selection_dialog.dart';
import '../widgets/add_custom_slot_dialog.dart';
import '../../domain/entities/bundle.dart';
import '../../domain/entities/bundle_slot.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_state_widget.dart';

class BundleDetailPage extends ConsumerWidget {
  final String bundleId;

  const BundleDetailPage({
    super.key,
    required this.bundleId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bundleAsync = ref.watch(bundleByIdProvider(bundleId));
    final bundleSlotsAsync = ref.watch(bundleSlotsProvider(bundleId));

    return Scaffold(
      body: bundleAsync.when(
        data: (bundle) => bundle != null 
            ? _buildBundleDetail(context, ref, bundle, bundleSlotsAsync)
            : const Center(child: Text('Bundle not found')),
        loading: () => const LoadingWidget(message: 'Loading bundle...'),
        error: (error, stack) => ErrorStateWidget(
          message: 'Failed to load bundle.',
          error: error.toString(),
          onRetry: () => ref.invalidate(bundleByIdProvider(bundleId)),
        ),
      ),
    );
  }

  Widget _buildBundleDetail(BuildContext context, WidgetRef ref, Bundle bundle, AsyncValue<List<BundleSlot>> slotsAsync) {
    return CustomScrollView(
      slivers: [
        // Dynamic Header with SliverAppBar
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              bundle.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                shadows: [Shadow(color: Colors.black26, blurRadius: 2)],
              ),
            ),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  ],
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.folder_outlined,
                  size: 64,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) => _handleMenuAction(context, ref, value, bundle),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'add_custom_slot',
                  child: Row(
                    children: [
                      Icon(Icons.add_circle_outline, size: 20),
                      SizedBox(width: 8),
                      Text('Add Custom Slot'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'save_template',
                  child: Row(
                    children: [
                      Icon(Icons.bookmark_add, size: 20),
                      SizedBox(width: 8),
                      Text('💾 Save as Template'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 20),
                      SizedBox(width: 8),
                      Text('Edit Bundle'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'export',
                  child: Row(
                    children: [
                      Icon(Icons.download, size: 20),
                      SizedBox(width: 8),
                      Text('Export Bundle'),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 20, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Delete Bundle', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        
        // Content
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bundle Info Card
                _buildBundleInfoCard(context, bundle),
                const SizedBox(height: 16),
                
                // Progress Indicator
                slotsAsync.when(
                  data: (slots) => slots.isNotEmpty 
                      ? Column(
                          children: [
                            BundleProgressIndicator(slots: slots),
                            const SizedBox(height: 16),
                          ],
                        )
                      : const SizedBox.shrink(),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
                
                // Document Slots Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Document Checklist',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _addCustomSlot(context, ref, bundle),
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Add Slot'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Document Slots List
                slotsAsync.when(
                  data: (slots) => _buildSlotsList(context, ref, bundle, slots),
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  error: (error, stack) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Failed to load document slots',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            error.toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => ref.invalidate(bundleSlotsProvider(bundleId)),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBundleInfoCard(BuildContext context, Bundle bundle) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bundle Information',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            if (bundle.description != null && bundle.description!.isNotEmpty) ...[
              Text(
                bundle.description!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
            ],
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  'Created: ${_formatDate(bundle.createdAt)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.update, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  'Updated: ${_formatDate(bundle.updatedAt)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlotsList(BuildContext context, WidgetRef ref, Bundle bundle, List<BundleSlot> slots) {
    if (slots.isEmpty) {
      return _buildEmptySlotsList(context, ref, bundle);
    }

    return Column(
      children: slots.map((slot) => DocumentSlotCard(
        slot: slot,
        onAttachDocument: () => _attachDocumentToSlot(context, ref, slot),
        onViewDocument: slot.isFilled ? () => _viewAttachedDocument(context, slot) : null,
        onDetachDocument: slot.isFilled ? () => _detachDocumentFromSlot(context, ref, slot) : null,
      )).toList(),
    );
  }

  Widget _buildEmptySlotsList(BuildContext context, WidgetRef ref, Bundle bundle) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(
              Icons.checklist_outlined,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No document slots yet',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add custom slots to create a checklist for this bundle',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _addCustomSlot(context, ref, bundle),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add First Slot'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Action Methods
  void _attachDocumentToSlot(BuildContext context, WidgetRef ref, BundleSlot slot) {
    showDialog(
      context: context,
      builder: (context) => DocumentSelectionDialog(
        slotName: slot.requirementName,
        requiredDocType: slot.requiredDocType,
        onDocumentSelected: (document) async {
          // TODO: Implement attach document to slot
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Attached ${document.title} to ${slot.requirementName}')),
          );
          // Refresh slots
          ref.invalidate(bundleSlotsProvider(slot.bundleId));
        },
      ),
    );
  }

  void _viewAttachedDocument(BuildContext context, BundleSlot slot) {
    // TODO: Navigate to document viewer
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Document viewer coming soon!')),
    );
  }

  void _detachDocumentFromSlot(BuildContext context, WidgetRef ref, BundleSlot slot) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Document'),
        content: Text('Remove document from ${slot.requirementName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              // TODO: Implement detach document from slot
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Document removed')),
              );
              // Refresh slots
              ref.invalidate(bundleSlotsProvider(slot.bundleId));
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _addCustomSlot(BuildContext context, WidgetRef ref, Bundle bundle) {
    showDialog(
      context: context,
      builder: (context) => AddCustomSlotDialog(
        bundleId: bundle.id,
        onSlotAdded: (slot) async {
          // Create the slot using the repository
          final createSlotFunction = ref.read(createBundleSlotProvider);
          final success = await createSlotFunction(slot);
          
          if (success) {
            // Refresh the slots list
            ref.invalidate(bundleSlotsProvider(bundle.id));
            
            // Show success message
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added "${slot.requirementName}" slot'),
                  backgroundColor: Colors.green,
                  action: SnackBarAction(
                    label: 'Dismiss',
                    textColor: Colors.white,
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                ),
              );
            }
          } else {
            // Show error message
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to add slot. Please try again.'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
      ),
    );
  }

  void _handleMenuAction(BuildContext context, WidgetRef ref, String action, Bundle bundle) {
    switch (action) {
      case 'add_custom_slot':
        _addCustomSlot(context, ref, bundle);
        break;
      case 'save_template':
        _showSaveAsTemplateDialog(context, ref, bundle);
        break;
      case 'edit':
        // TODO: Navigate to edit page
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Edit bundle functionality coming soon!')),
        );
        break;
      case 'export':
        // TODO: Implement export functionality
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Export bundle functionality coming soon!')),
        );
        break;
      case 'delete':
        _confirmDeleteBundle(context, ref, bundle);
        break;
    }
  }

  void _showSaveAsTemplateDialog(BuildContext context, WidgetRef ref, Bundle bundle) {
    showDialog(
      context: context,
      builder: (context) => SaveAsTemplateDialog(
        bundleId: bundle.id,
        bundleName: bundle.name,
      ),
    );
  }

  void _confirmDeleteBundle(BuildContext context, WidgetRef ref, Bundle bundle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Bundle'),
        content: Text('Are you sure you want to delete "${bundle.name}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final success = await ref.read(bundlesNotifierProvider.notifier).deleteBundle(bundle.id);
              if (success && context.mounted) {
                Navigator.of(context).pop(); // Go back to bundle list
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Bundle deleted successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
