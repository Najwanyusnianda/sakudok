// lib/features/bundles/presentation/widgets/add_edit_bundle/bundle_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Update the import path below to the correct location of bundle_group_providers.dart
import '../../../../bundle_groups/presentation/providers/bundle_group_providers.dart';
import '../../providers/bundle_providers.dart';
import '../../../../bundle_groups/domain/entities/bundle_group.dart';

class BundleForm extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final int? initialGroupId;
  final bool isEditing;
  final ValueChanged<int?> onGroupChanged;
  final VoidCallback onCreateFromTemplate;

  const BundleForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.descriptionController,
    required this.initialGroupId,
    required this.isEditing,
    required this.onGroupChanged,
    required this.onCreateFromTemplate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bundleGroupsAsync = ref.watch(bundleGroupsNotifierProvider);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Bundle Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description (Optional)'),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          
          // Bundle Group Selection
          bundleGroupsAsync.when(
            data: (groups) {
              if (groups.isEmpty) return const SizedBox.shrink();
              return DropdownButtonFormField<int?>(
                value: initialGroupId,
                decoration: const InputDecoration(
                  labelText: 'Bundle Group (Optional)',
                  hintText: 'Select a group',
                ),
                items: [
                  const DropdownMenuItem<int?>(
                    value: null,
                    child: Text('No Group'),
                  ),
                  // --- FIX: Filter out any potential nulls from the list ---
                  // whereType<BundleGroup>() safely removes nulls and casts the list.
                  ...groups.whereType<BundleGroup>().map((group) => DropdownMenuItem<int?>(
                    value: group.id,
                    child: Text(group.name),
                  )),
                ],
                onChanged: onGroupChanged,
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Text('Error: $error'),
          ),
          
          if (!isEditing) ...[
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Text(
                    'Or, start with a template',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: onCreateFromTemplate,
                    icon: const Icon(Icons.content_copy_outlined),
                    label: const Text('Choose Template'),
                  ),
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }
}
