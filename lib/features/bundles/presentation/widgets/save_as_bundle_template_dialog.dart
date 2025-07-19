import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/bundle_providers.dart';

class SaveAsTemplateDialog extends ConsumerStatefulWidget {
  final String bundleId;
  final String bundleName;

  const SaveAsTemplateDialog({
    super.key,
    required this.bundleId,
    required this.bundleName,
  });

  @override
  ConsumerState<SaveAsTemplateDialog> createState() => _SaveAsTemplateDialogState();
}

class _SaveAsTemplateDialogState extends ConsumerState<SaveAsTemplateDialog> {
  late final TextEditingController _templateNameController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _templateNameController = TextEditingController(
      text: 'Template from ${widget.bundleName}',
    );
  }

  @override
  void dispose() {
    _templateNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.bookmark_add, color: Colors.blue),
          const SizedBox(width: 8),
          const Text('Save as Template'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Create a reusable template from this bundle that you can use for similar documents in the future.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _templateNameController,
            decoration: const InputDecoration(
              labelText: 'Template Name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.label),
            ),
            autofocus: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _saveTemplate,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save Template'),
        ),
      ],
    );
  }

  Future<void> _saveTemplate() async {
    if (_templateNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a template name'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final template = await ref
          .read(userTemplatesNotifierProvider.notifier)
          .saveBundleAsTemplate(widget.bundleId, _templateNameController.text.trim());

      if (template != null && mounted) {
        Navigator.of(context).pop(template);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Template "${template.name}" saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save template. Please try again.'),
            backgroundColor: Colors.red,
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
}
