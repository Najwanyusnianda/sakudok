// lib/features/bundles/presentation/pages/add_edit_bundle_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/bundle.dart' as domain;
import '../../domain/entities/bundle_template.dart';
import '../providers/bundle_providers.dart';
import '../widgets/bundle_preview.dart';
import '../widgets/template_quick_access.dart';
import '../widgets/bundle_template_selector.dart';
import '../../../../features/bundle_groups/presentation/providers/bundle_group_providers.dart';
import '../../../../features/bundle_groups/domain/entities/bundle_group.dart';

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
  domain.Bundle? _initialBundle;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _isEditing = widget.bundleId != null;

    if (_isEditing) {
      // It's better to fetch the specific bundle to ensure data is fresh
      ref.read(bundleByIdProvider(widget.bundleId!)).whenData((bundle) {
        if (bundle != null) {
          _initialBundle = bundle;
          _nameController.text = bundle.name;
          _descriptionController.text = bundle.description ?? '';
          _selectedGroupId = bundle.groupId;
        }
      });
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
      final now = DateTime.now();
      
      // Create the bundle object with the updated data
      final bundle = domain.Bundle(
        // --- FIX: Use the existing ID if we are editing ---
        id: _isEditing ? widget.bundleId! : '0', 
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isNotEmpty 
            ? _descriptionController.text.trim() 
            : null,
        groupId: _selectedGroupId,
        // Preserve original creation date when editing
        createdAt: _isEditing ? _initialBundle!.createdAt : now,
        updatedAt: now,
        // Preserve existing documents when editing
        documents: _isEditing ? _initialBundle!.documents : [],
      );

      final notifier = ref.read(bundlesNotifierProvider.notifier);

      // --- FIX: Call the correct method based on whether we are editing ---
      if (_isEditing) {
        notifier.updateBundle(bundle);
      } else {
        notifier.createBundle(bundle);
      }

      Navigator.of(context).pop();
    }
  }

  bool _canSave() {
    return _nameController.text.trim().isNotEmpty;
  }

  void _selectTemplate(BundleTemplate template) {
    setState(() {
      _nameController.text = template.name;
      _descriptionController.text = template.description;
    });
    
    // TODO: Create bundle with template slots
    // This will be implemented when we enhance bundle creation
  }

  void _viewAllTemplates() {
    showDialog(
      context: context,
      builder: (context) => BundleTemplateSelector(
        onTemplateSelected: (template) {
          Navigator.of(context).pop();
          _selectTemplate(template);
        },
        onUserTemplateSelected: (userTemplate) {
          Navigator.of(context).pop();
          // Pre-fill form with user template data
          setState(() {
            _nameController.text = userTemplate.name;
            _descriptionController.text = userTemplate.description;
          });
          // TODO: Also pre-populate with required documents from template
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bundleGroupsAsync = ref.watch(bundleGroupsNotifierProvider);
    
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Bundle' : 'Create Bundle'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Bundle Preview
            Expanded(
              flex: 3,
              child: BundlePreview(
                bundleName: _nameController.text.isNotEmpty ? _nameController.text : null,
                description: _descriptionController.text.isNotEmpty ? _descriptionController.text : null,
              ),
            ),
            
            // Input Section
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bundle Name Field
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Bundle Name',
                          hintText: 'Enter bundle name...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.folder_outlined),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a bundle name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {}); // Refresh preview
                        },
                      ),
                      const SizedBox(height: 16),
                      
                      // Description Field
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description (Optional)',
                          hintText: 'Enter description...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.description_outlined),
                        ),
                        maxLines: 2,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          setState(() {}); // Refresh preview
                        },
                      ),
                      const SizedBox(height: 16),
                      
                      // Bundle Group Selection
                      bundleGroupsAsync.when(
                        data: (groups) {
                          if (groups.isEmpty) return const SizedBox.shrink();
                          return DropdownButtonFormField<int?>(
                            value: _selectedGroupId,
                            decoration: InputDecoration(
                              labelText: 'Add to Group (Optional)',
                              hintText: 'Select a group',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.group_outlined),
                            ),
                            items: [
                              const DropdownMenuItem<int?>(
                                value: null,
                                child: Text('No Group'),
                              ),
                              ...groups.whereType<BundleGroup>().map((group) => DropdownMenuItem<int?>(
                                value: group.id,
                                child: Text(group.name),
                              )),
                            ],
                            onChanged: (groupId) {
                              setState(() {
                                _selectedGroupId = groupId;
                              });
                            },
                          );
                        },
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (error, stack) => Text('Error: $error'),
                      ),
                      
                      if (!_isEditing) ...[
                        const SizedBox(height: 24),
                        
                        // Template Quick Access
                        TemplateQuickAccess(
                          onTemplateSelected: _selectTemplate,
                          onViewAllTemplates: _viewAllTemplates,
                        ),
                      ],
                      
                      const Spacer(),
                      
                      // Save Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _canSave() ? _saveBundle : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            disabledBackgroundColor: Colors.grey.shade300,
                          ),
                          child: Text(
                            _isEditing ? 'Update Bundle' : 'Create Bundle & Continue',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}