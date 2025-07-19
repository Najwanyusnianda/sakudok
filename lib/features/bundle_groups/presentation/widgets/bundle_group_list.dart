// lib/features/bundle_groups/presentation/widgets/bundle_group_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/bundle_group.dart';
import '../providers/bundle_group_providers.dart';
import 'add_edit_bundle_group_dialog.dart';
import '../../../../core/widgets/empty_state_widget.dart';

class BundleGroupList extends ConsumerWidget {
  final List<BundleGroup> groups;

  const BundleGroupList({super.key, required this.groups});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (groups.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.folder_copy_outlined,
        message: 'No bundle groups yet.',
        //details: 'Create your first group to organize your bundles.',
        actionText: 'Create Group',
        onAction: () => _showAddBundleGroupDialog(context, ref),
      );
    }

    return ReorderableListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: groups.length,
      onReorder: (oldIndex, newIndex) {
        _reorderGroups(ref, groups, oldIndex, newIndex);
      },
      itemBuilder: (context, index) {
        final group = groups[index];
        return Card(
          key: ValueKey(group.id),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: Icon(group.icon, color: group.color, size: 28),
            title: Text(group.name, style: const TextStyle(fontWeight: FontWeight.w600)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () => _showEditBundleGroupDialog(context, ref, group),
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.error),
                  onPressed: () => _showDeleteConfirmation(context, ref, group),
                ),
                const Icon(Icons.drag_handle),
              ],
            ),
          ),
        );
      },
    );
  }

  void _reorderGroups(WidgetRef ref, List<BundleGroup> groups, int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final reorderedGroups = List<BundleGroup>.from(groups);
    final item = reorderedGroups.removeAt(oldIndex);
    reorderedGroups.insert(newIndex, item);

    // Update display order for all groups
    for (int i = 0; i < reorderedGroups.length; i++) {
      final updatedGroup = reorderedGroups[i].copyWith(displayOrder: i);
      ref.read(bundleGroupsNotifierProvider.notifier).updateBundleGroup(updatedGroup);
    }
  }

  void _showAddBundleGroupDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AddEditBundleGroupDialog(
        onSave: (bundleGroup) async {
          await ref.read(bundleGroupsNotifierProvider.notifier).addBundleGroup(bundleGroup);
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
          await ref.read(bundleGroupsNotifierProvider.notifier).updateBundleGroup(updatedGroup);
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, BundleGroup group) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Group'),
        content: Text('Are you sure you want to delete "${group.name}"? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(bundleGroupsNotifierProvider.notifier).deleteBundleGroup(group.id);
            },
            style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}