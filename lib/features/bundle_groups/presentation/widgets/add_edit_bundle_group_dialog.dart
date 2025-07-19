// lib/features/bundle_groups/presentation/widgets/add_edit_bundle_group_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/bundle_group.dart';
import '../providers/bundle_group_providers.dart';
import 'bundle_group_form.dart'; // New widget import

class AddEditBundleGroupDialog extends ConsumerStatefulWidget {
  final BundleGroup? bundleGroup;
  final Function(BundleGroup) onSave;

  const AddEditBundleGroupDialog({
    super.key,
    this.bundleGroup,
    required this.onSave,
  });

  @override
  ConsumerState<AddEditBundleGroupDialog> createState() => _AddEditBundleGroupDialogState();
}

class _AddEditBundleGroupDialogState extends ConsumerState<AddEditBundleGroupDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late String _selectedIconName;
  late String _selectedColorHex;
  bool _isLoading = false;

  bool get isEditing => widget.bundleGroup != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();

    if (isEditing) {
      final group = widget.bundleGroup!;
      _nameController.text = group.name;
      _selectedIconName = group.iconName ?? BundleGroup.availableIcons.first;
      _selectedColorHex = group.colorHex ?? BundleGroup.availableColors.first;
    } else {
      _selectedIconName = BundleGroup.availableIcons.first;
      _selectedColorHex = BundleGroup.availableColors.first;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final newGroup = BundleGroup(
        id: isEditing ? widget.bundleGroup!.id : 0,
        name: _nameController.text.trim(),
        iconName: _selectedIconName,
        colorHex: _selectedColorHex,
        displayOrder: isEditing ? widget.bundleGroup!.displayOrder : 0, // Handled by notifier
        createdAt: isEditing ? widget.bundleGroup!.createdAt : DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await widget.onSave(newGroup);

      if (mounted) Navigator.of(context).pop();

    } catch (e) {
      // Error handling can be improved with a SnackBar
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEditing ? 'Edit Group' : 'Add Group'),
      content: SizedBox(
        width: double.maxFinite,
        child: BundleGroupForm(
          formKey: _formKey,
          nameController: _nameController,
          selectedIconName: _selectedIconName,
          selectedColorHex: _selectedColorHex,
          onIconChanged: (iconName) => setState(() => _selectedIconName = iconName),
          onColorChanged: (colorHex) => setState(() => _selectedColorHex = colorHex),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _handleSave,
          child: _isLoading
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : Text(isEditing ? 'Update' : 'Add'),
        ),
      ],
    );
  }
}