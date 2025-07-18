import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/bundle_group_providers.dart';
import '../../domain/entities/bundle_group.dart';
import '../widgets/add_edit_bundle_group_dialog.dart';

class ManageBundleGroupsPage extends ConsumerWidget {
  const ManageBundleGroupsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bundleGroups = ref.watch(bundleGroupsNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Manage Bundle Groups',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: bundleGroups.when(
        data: (groups) => _buildGroupsList(context, ref, groups),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
              const SizedBox(height: 16),
              Text('Error loading bundle groups', 
                   style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(error.toString(), style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.read(bundleGroupsNotifierProvider.notifier).loadBundleGroups(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddBundleGroupDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Add Group'),
      ),
    );
  }

  Widget _buildGroupsList(BuildContext context, WidgetRef ref, List<BundleGroup> groups) {
    if (groups.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.folder_outlined,
                size: 80,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                'No bundle groups yet',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Create your first bundle group to organize your document bundles',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => _showAddBundleGroupDialog(context, ref),
                icon: const Icon(Icons.add),
                label: const Text('Create Group'),
              ),
            ],
          ),
        ),
      );
    }

    return ReorderableListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: groups.length,
      onReorder: (oldIndex, newIndex) {
        // Handle reordering logic here
        _reorderGroups(ref, groups, oldIndex, newIndex);
      },
      itemBuilder: (context, index) {
        final group = groups[index];
        return Card(
          key: ValueKey(group.id),
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: group.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                group.icon,
                color: group.color,
              ),
            ),
            title: Text(
              group.name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text('Display order: ${group.displayOrder}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showEditBundleGroupDialog(context, ref, group),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _showDeleteConfirmation(context, ref, group),
                ),
                const Icon(Icons.drag_handle, color: Colors.grey),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddBundleGroupDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AddEditBundleGroupDialog(
        onSave: (bundleGroup) async {
          final success = await ref
              .read(bundleGroupsNotifierProvider.notifier)
              .addBundleGroup(bundleGroup);
          if (success) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bundle group created successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to create bundle group'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
      ),
    );
  }

  void _showEditBundleGroupDialog(BuildContext context, WidgetRef ref, BundleGroup group) {
    showDialog(
      context: context,
      builder: (context) => AddEditBundleGroupDialog(
        bundleGroup: group,
        onSave: (updatedGroup) async {
          final success = await ref
              .read(bundleGroupsNotifierProvider.notifier)
              .updateBundleGroup(updatedGroup);
          if (success) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bundle group updated successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to update bundle group'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, BundleGroup group) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Bundle Group'),
        content: Text(
          'Are you sure you want to delete "${group.name}"? Bundles in this group will be moved to "Uncategorized".',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await ref
                  .read(bundleGroupsNotifierProvider.notifier)
                  .deleteBundleGroup(group.id);
              if (success) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Bundle group deleted successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to delete bundle group'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _reorderGroups(WidgetRef ref, List<BundleGroup> groups, int oldIndex, int newIndex) {
    // Adjust newIndex for proper reordering
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    // Create a copy of the list for reordering
    final reorderedGroups = List<BundleGroup>.from(groups);
    final item = reorderedGroups.removeAt(oldIndex);
    reorderedGroups.insert(newIndex, item);

    // Update display order for all groups
    for (int i = 0; i < reorderedGroups.length; i++) {
      final updatedGroup = reorderedGroups[i].copyWith(displayOrder: i);
      ref.read(bundleGroupsNotifierProvider.notifier).updateBundleGroup(updatedGroup);
    }
  }
}
