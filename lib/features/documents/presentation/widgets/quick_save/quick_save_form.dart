// lib/features/documents/presentation/widgets/quick_save/quick_save_form.dart
import 'package:flutter/material.dart';
import '../../../domain/entities/document_type.dart';

class QuickSaveForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final MainDocumentType selectedMainType;
  final ValueChanged<MainDocumentType> onTypeChanged;

  const QuickSaveForm({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.selectedMainType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Document Title',
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          Text(
            'Document Category',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          SegmentedButton<MainDocumentType>(
            segments: MainDocumentType.values.map((type) {
              return ButtonSegment<MainDocumentType>(
                value: type,
                icon: Icon(type.icon, size: 20),
                label: Text(type.displayName),
              );
            }).toList(),
            selected: {selectedMainType},
            onSelectionChanged: (newSelection) {
              onTypeChanged(newSelection.first);
            },
          ),
        ],
      ),
    );
  }
}