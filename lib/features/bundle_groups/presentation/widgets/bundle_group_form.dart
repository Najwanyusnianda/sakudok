// lib/features/bundle_groups/presentation/widgets/bundle_group_form.dart
import 'package:flutter/material.dart';
import '../../domain/entities/bundle_group.dart';
import 'icon_picker.dart';
import 'color_picker.dart';

class BundleGroupForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final String selectedIconName;
  final String selectedColorHex;
  final ValueChanged<String> onIconChanged;
  final ValueChanged<String> onColorChanged;

  const BundleGroupForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.selectedIconName,
    required this.selectedColorHex,
    required this.onIconChanged,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Group Name'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a group name';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            Text('Icon', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            IconPicker(
              selectedIconName: selectedIconName,
              onIconChanged: onIconChanged,
            ),
            const SizedBox(height: 24),
            Text('Color', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ColorPicker(
              selectedColorHex: selectedColorHex,
              onColorChanged: onColorChanged,
            ),
          ],
        ),
      ),
    );
  }
}
