import 'package:flutter/material.dart';
import '../../domain/entities/bundle_template_requirement.dart';
import '../../../documents/domain/entities/document_type.dart';

class AddRequirementDialog extends StatefulWidget {
  final String templateId;

  const AddRequirementDialog({
    super.key,
    required this.templateId,
  });

  @override
  State<AddRequirementDialog> createState() => _AddRequirementDialogState();
}

class _AddRequirementDialogState extends State<AddRequirementDialog> {
  final _nameController = TextEditingController();
  MainDocumentType _selectedType = MainDocumentType.DOCUMENT;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.add_circle_outline, color: Colors.blue),
          SizedBox(width: 8),
          Text('Add Document Requirement'),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Define a specific document that should be included in bundles created from this template.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<MainDocumentType>(
              value: _selectedType,
              decoration: const InputDecoration(
                labelText: 'Document Category',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              items: MainDocumentType.values.map((type) => DropdownMenuItem(
                value: type,
                child: Row(
                  children: [
                    Icon(type.icon, size: 20),
                    const SizedBox(width: 8),
                    Text(type.displayName),
                  ],
                ),
              )).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedType = value;
                    // Auto-fill the name when type changes
                    if (_nameController.text.isEmpty) {
                      _nameController.text = value.displayName;
                    }
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Custom Name',
                hintText: 'e.g., "CV in English" or "Original KTP"',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.label),
              ),
              autofocus: true,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_nameController.text.trim().isNotEmpty) {
              final requirement = BundleTemplateRequirement(
                id: DateTime.now().millisecondsSinceEpoch.toString(), // Simple ID generation
                bundleUserTemplateId: widget.templateId,
                mainDocumentType: _selectedType,
                name: _nameController.text.trim(),
              );
              Navigator.of(context).pop(requirement);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter a name for this requirement'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: const Text('Add Requirement'),
        ),
      ],
    );
  }
}
