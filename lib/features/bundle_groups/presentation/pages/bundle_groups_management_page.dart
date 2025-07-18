import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/bundle_group_providers.dart';
import '../widgets/add_edit_bundle_group_dialog.dart';
import '../../domain/entities/bundle_group.dart';

class BundleGroupsManagementPage extends ConsumerStatefulWidget {
  const BundleGroupsManagementPage({super.key});

  @override
  ConsumerState<BundleGroupsManagementPage> createState() => _BundleGroupsManagementPageState();
}

class _BundleGroupsManagementPageState extends ConsumerState<BundleGroupsManagementPage> {
  @override
  Widget build(BuildContext context) {
    final bundleGroupsAsync = ref.watch(bundleGroupsNotifierProvider);

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
      body: bundleGroupsAsync.when(
        data: (bundleGroups) => _buildBundleGroupsList(context, bundleGroups),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorState(context, error),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddBundleGroupDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Group'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildBundleGroupsList(BuildContext context, List<BundleGroup> bundleGroups) {
    if (bundleGroups.isEmpty) {
      return _buildEmptyState(context);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(bundleGroupsNotifierProvider.notifier).loadBundleGroups();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: bundleGroups.length,
        itemBuilder: (context, index) {
          final group = bundleGroups[index];
          return _buildBundleGroupCard(context, group);
        },
      ),
    );
  }

  Widget _buildBundleGroupCard(BuildContext context, BundleGroup group) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: group.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            group.icon,
            color: group.color,
            size: 28,
          ),
        ),
        title: Text(
          group.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          'Display Order: ${group.displayOrder}',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) => _handleMenuAction(context, value, group),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, size: 20),
                  SizedBox(width: 8),
                  Text('Edit'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, size: 20, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Delete', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_open,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No Bundle Groups Yet',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Create groups to organize your bundles\nlike Work, Education, Travel, etc.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _showAddBundleGroupDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Create First Group'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              'Error Loading Groups',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.red.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await ref.read(bundleGroupsNotifierProvider.notifier).loadBundleGroups();
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddBundleGroupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddEditBundleGroupDialog(),
    );
  }

  void _showEditBundleGroupDialog(BuildContext context, BundleGroup group) {
    showDialog(
      context: context,
      builder: (context) => AddEditBundleGroupDialog(bundleGroup: group),
    );
  }

  void _handleMenuAction(BuildContext context, String action, BundleGroup group) {
    switch (action) {
      case 'edit':
        _showEditBundleGroupDialog(context, group);
        break;
      case 'delete':
        _showDeleteConfirmation(context, group);
        break;
    }
  }

  void _showDeleteConfirmation(BuildContext context, BundleGroup group) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Bundle Group'),
        content: Text(
          'Are you sure you want to delete "${group.name}"?\n\n'
          'Bundles in this group will not be deleted, but they will become uncategorized.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _deleteBundleGroup(group);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteBundleGroup(BundleGroup group) async {
    final success = await ref
        .read(bundleGroupsNotifierProvider.notifier)
        .deleteBundleGroup(group.id);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'Bundle group deleted successfully'
                : 'Failed to delete bundle group',
          ),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    }
  }
}
