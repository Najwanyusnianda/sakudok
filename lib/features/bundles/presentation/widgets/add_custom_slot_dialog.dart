//lib/features/bundles/presentation/widgets/add_custom_slot_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/bundle_slot.dart';
import '../../../documents/domain/entities/document_type.dart'; // Import MainDocumentType

class AddCustomSlotDialog extends ConsumerStatefulWidget {
  final String bundleId;
  final Function(BundleSlot) onSlotAdded;

  const AddCustomSlotDialog({
    super.key,
    required this.bundleId,
    required this.onSlotAdded,
  });

  @override
  ConsumerState<AddCustomSlotDialog> createState() => _AddCustomSlotDialogState();
}

class _AddCustomSlotDialogState extends ConsumerState<AddCustomSlotDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  // Use the MainDocumentType enum for type safety
  MainDocumentType _selectedDocType = MainDocumentType.OTHER;
  bool _isRequired = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _addSlot() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final newSlot = BundleSlot(
        id: '0', // Temporary ID
        bundleId: widget.bundleId,
        requirementName: _nameController.text.trim(),
        // Store the enum's name
        requiredDocType: _selectedDocType.name,
        isRequired: _isRequired,
        displayOrder: 999, // This should be handled by the repository/notifier
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      widget.onSlotAdded(newSlot);

      if (mounted) Navigator.of(context).pop();

    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add slot: $error'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: const Text('Add Custom Slot'),
      // Let the dialog size itself naturally
      content: Form(
        key: _formKey,
        child: SingleChildScrollView( // Makes the form scrollable if keyboard appears
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Requirement Name',
                  hintText: 'e.g., Passport Copy',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<MainDocumentType>(
                value: _selectedDocType,
                decoration: const InputDecoration(
                  labelText: 'Expected Document Type',
                ),
                // --- IMPROVEMENT: Use the MainDocumentType enum directly ---
                items: MainDocumentType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Row(
                      children: [
                        Icon(type.icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
                        const SizedBox(width: 12),
                        Text(type.displayName),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedDocType = value);
                  }
                },
              ),
              const SizedBox(height: 8),
              // --- IMPROVEMENT: Use SwitchListTile for a cleaner look ---
              SwitchListTile(
                title: const Text('Required'),
                value: _isRequired,
                onChanged: (value) => setState(() => _isRequired = value),
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
              // --- IMPROVEMENT: Use simpler helper text ---
              Text(
                _isRequired
                    ? 'This slot must be filled to complete the bundle.'
                    : 'This slot is optional.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _addSlot,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Add Slot'),
        ),
      ],
    );
  }
}