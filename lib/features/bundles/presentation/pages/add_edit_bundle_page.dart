import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/bundle.dart';
import '../providers/bundle_providers.dart';
import '../widgets/bundle_template_selector.dart';
import '../../../bundle_groups/presentation/providers/bundle_group_providers.dart';
import '../../../bundle_groups/domain/entities/bundle_group.dart';


class AddEditBundlePage extends ConsumerStatefulWidget {
  final String? bundleId;

  const AddEditBundlePage({super.key, this.bundleId});

  @override
  ConsumerState<AddEditBundlePage> createState() => _AddEditBundlePageState();
}

class _AddEditBundlePageState extends ConsumerState<AddEditBundlePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  int? _selectedGroupId;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _isEditing = widget.bundleId != null;

    if (_isEditing) {
      // Load existing bundle data
      final bundlesState = ref.read(bundlesNotifierProvider);
      if (bundlesState.hasValue) {
        final bundle = bundlesState.value!.firstWhere((b) => b.id == widget.bundleId);
        _nameController.text = bundle.name;
        _descriptionController.text = bundle.description ?? '';
        _selectedGroupId = bundle.groupId;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveBundle() {
    if (_formKey.currentState!.validate()) {
      final bundle = Bundle(
        id: widget.bundleId ?? DateTime.now().toIso8601String(),
        name: _nameController.text,
        description: _descriptionController.text,
        groupId: _selectedGroupId, // Include selected group
        createdAt: _isEditing
            ? ref
                .read(bundlesNotifierProvider)
                .value!
                .firstWhere((b) => b.id == widget.bundleId)
                .createdAt
            : DateTime.now(),
        updatedAt: DateTime.now(),
        documents: _isEditing
            ? ref.read(bundlesNotifierProvider).value!.firstWhere((b) => b.id == widget.bundleId).documents
            : [],
      );

      ref.read(bundlesNotifierProvider.notifier).createBundle(bundle);

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bundleGroupsAsync = ref.watch(bundleGroupsNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Bundle' : 'Create Bundle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveBundle,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Bundle Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (Optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              
              // Bundle Group Selection
              bundleGroupsAsync.when(
                data: (groups) {
                  if (groups.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bundle Group (Optional)',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<int?>(
                        value: _selectedGroupId,
                        decoration: const InputDecoration(
                          hintText: 'Select a group',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          const DropdownMenuItem<int?>(
                            value: null,
                            child: Text('No Group (Uncategorized)'),
                          ),
                          ...groups.map((group) => DropdownMenuItem<int?>(
                            value: group.id,
                            child: Row(
                              children: [
                                Icon(group.icon, size: 16, color: group.color),
                                const SizedBox(width: 8),
                                Text(group.name),
                              ],
                            ),
                          )),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedGroupId = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => Text('Error loading groups: $error'),
              ),
              
              if (!_isEditing) ...[
                const Divider(),
                const SizedBox(height: 16),
                Text(
                  'Or create from a template',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => BundleTemplateSelector(
                        onTemplateSelected: (template) {
                          Navigator.of(context).pop();
                          // Pre-fill form with template data
                          _nameController.text = template.name;
                          _descriptionController.text = template.description;
                        },
                      ),
                    );
                  },
                  child: const Text('Choose Template'),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
