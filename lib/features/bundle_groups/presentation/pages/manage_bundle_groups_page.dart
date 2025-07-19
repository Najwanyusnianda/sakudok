// lib/features/bundle_groups/presentation/pages/manage_bundle_groups_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/bundle_group_providers.dart';
import '../../domain/entities/bundle_group.dart';
import '../widgets/add_edit_bundle_group_dialog.dart';
import '../widgets/bundle_group_list.dart'; // New widget import
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/empty_state_widget.dart';

class ManageBundleGroupsPage extends ConsumerWidget {
  const ManageBundleGroupsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bundleGroupsAsync = ref.watch(bundleGroupsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Groups'),
      ),
      body: bundleGroupsAsync.when(
        data: (groups) => BundleGroupList(groups: groups),
        loading: () => const LoadingWidget(message: 'Loading groups...'),
        error: (error, stack) => ErrorStateWidget(
          message: 'Failed to load bundle groups.',
          error: error.toString(),
          onRetry: () => ref.invalidate(bundleGroupsNotifierProvider),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddBundleGroupDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Add Group'),
      ),
    );
  }

  void _showAddBundleGroupDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AddEditBundleGroupDialog(
        onSave: (bundleGroup) async {
          await ref
              .read(bundleGroupsNotifierProvider.notifier)
              .addBundleGroup(bundleGroup);
        },
      ),
    );
  }
}
