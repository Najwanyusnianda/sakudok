import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/bundle_providers.dart';
import '../../domain/entities/bundle_user_template.dart';
import '../../domain/entities/bundle_template_requirement.dart';
import '../../../documents/domain/entities/document_type.dart';
import '../widgets/add_bundle_template_requirement_dialog.dart';

class CreateEditTemplatePage extends ConsumerStatefulWidget {
  final BundleUserTemplate? template; // null for create, non-null for edit

  const CreateEditTemplatePage({
    super.key,
    this.template,
  });

  @override
  ConsumerState<CreateEditTemplatePage> createState() => _CreateEditTemplatePageState();
}

class _CreateEditTemplatePageState extends ConsumerState<CreateEditTemplatePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  List<BundleTemplateRequirement> _requirements = [];
  bool _isLoading = false;

  bool get _isEditing => widget.template != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.template?.name ?? '');
    _descriptionController = TextEditingController(text: widget.template?.description ?? '');
    _requirements = widget.template?.requirements ?? [];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Template' : 'Create Template'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveTemplate,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    _isEditing ? 'Update' : 'Save',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Template Info Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Template Information',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Template Name',
                          hintText: 'e.g., Job Application Bundle',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.bookmark),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a template name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description (optional)',
                          hintText: 'Describe what this template is for',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.description),
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Requirements Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Document Requirements',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: _addRequirement,
                            icon: const Icon(Icons.add, size: 18),
                            label: const Text('Add Requirement'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Define what documents should be included in bundles created from this template',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      if (_requirements.isEmpty)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.description_outlined,
                                size: 48,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No requirements added yet',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Add document requirements to define what should be included',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.grey.shade500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      else
                        ..._requirements.asMap().entries.map((entry) {
                          final index = entry.key;
                          final requirement = entry.value;
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                child: Icon(
                                  _getDocumentTypeIcon(requirement.documentType),
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 20,
                                ),
                              ),
                              title: Text(requirement.name),
                              subtitle: Text(_getDocumentTypeLabel(requirement.documentType)),
                              trailing: IconButton(
                                icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                                onPressed: () => _removeRequirement(index),
                              ),
                            ),
                          );
                        }).toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addRequirement() async {
    final requirement = await showDialog<BundleTemplateRequirement>(
      context: context,
      builder: (context) => AddRequirementDialog(
        templateId: widget.template?.id ?? 'temp_id',
      ),
    );

    if (requirement != null) {
      setState(() {
        _requirements.add(requirement);
      });
    }
  }

  void _removeRequirement(int index) {
    setState(() {
      _requirements.removeAt(index);
    });
  }

  Future<void> _saveTemplate() async {
    if (!_formKey.currentState!.validate()) return;

    if (_requirements.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one document requirement'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final template = BundleUserTemplate(
        id: widget.template?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        requirements: _requirements,
        createdAt: widget.template?.createdAt ?? DateTime.now(),
      );

      await ref.read(userTemplatesNotifierProvider.notifier).createUserTemplate(template);

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Template "${template.name}" ${_isEditing ? 'updated' : 'created'} successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  IconData _getDocumentTypeIcon(DocumentType type) {
    switch (type) {
      case DocumentType.ktp:
        return Icons.credit_card;
      case DocumentType.passport:
        return Icons.book;
      case DocumentType.sim:
        return Icons.directions_car;
      case DocumentType.ijazah:
        return Icons.school;
      case DocumentType.sertifikat:
        return Icons.workspace_premium;
      case DocumentType.lainnya:
        return Icons.insert_drive_file;
    }
  }

  String _getDocumentTypeLabel(DocumentType type) {
    switch (type) {
      case DocumentType.ktp:
        return 'KTP / ID Card';
      case DocumentType.passport:
        return 'Passport';
      case DocumentType.sim:
        return 'Driver\'s License';
      case DocumentType.ijazah:
        return 'Certificate / Diploma';
      case DocumentType.sertifikat:
        return 'Certificate';
      case DocumentType.lainnya:
        return 'Other Document';
    }
  }
}
