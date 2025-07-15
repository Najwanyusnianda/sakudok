import 'package:flutter/material.dart';
import '../../../domain/entities/document.dart';
import '../../../domain/entities/document_type.dart';
import 'document_metadata_form.dart';

class DocumentForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController tagsController;
  final DocumentType selectedType;
  final bool isFavorite;
  final DateTime? expiryDate;
  final ValueChanged<DocumentType> onTypeChanged;
  final ValueChanged<bool> onFavoriteChanged;
  final ValueChanged<DateTime?> onExpiryDateChanged;
  final bool isLoading;
  final VoidCallback onSave;
  final String submitLabel;

  const DocumentForm({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
    required this.tagsController,
    required this.selectedType,
    required this.isFavorite,
    this.expiryDate,
    required this.onTypeChanged,
    required this.onFavoriteChanged,
    required this.onExpiryDateChanged,
    required this.isLoading,
    required this.onSave,
    required this.submitLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Judul',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Judul tidak boleh kosong';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Deskripsi',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: tagsController,
            decoration: const InputDecoration(
              labelText: 'Tag (pisahkan dengan koma)',
              border: OutlineInputBorder(),
              hintText: 'pribadi, penting, arsip',
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<DocumentType>(
            value: selectedType,
            decoration: const InputDecoration(
              labelText: 'Jenis Dokumen',
              border: OutlineInputBorder(),
            ),
            items: DocumentType.values.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(_getDocumentTypeLabel(type)),
              );
            }).toList(),
            onChanged: onTypeChanged,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Tanggal Kadaluarsa',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              TextButton.icon(
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  expiryDate != null
                      ? '${expiryDate!.day}/${expiryDate!.month}/${expiryDate!.year}'
                      : 'Pilih Tanggal',
                ),
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: expiryDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 3650)),
                  );
                  onExpiryDateChanged(date);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          CheckboxListTile(
            title: const Text('Tandai sebagai favorit'),
            value: isFavorite,
            onChanged: (value) {
              if (value != null) {
                onFavoriteChanged(value);
              }
            },
          ),
          const SizedBox(height: 16),
          DocumentMetadataForm(
            type: selectedType,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: isLoading ? null : onSave,
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : Text(submitLabel),
          ),
        ],
      ),
    );
  }

  String _getDocumentTypeLabel(DocumentType type) {
    switch (type) {
      case DocumentType.ktp:
        return 'KTP';
      case DocumentType.sim:
        return 'SIM';
      case DocumentType.passport:
        return 'Paspor';
      case DocumentType.ijazah:
        return 'Ijazah';
      case DocumentType.sertifikat:
        return 'Sertifikat';
      case DocumentType.lainnya:
        return 'Lainnya';
    }
  }
} 