import 'package:flutter/material.dart';
import '../../../domain/entities/document_type.dart';

class DocumentTypeSection extends StatelessWidget {
  final DocumentType selectedType;
  final ValueChanged<DocumentType> onTypeChanged;

  const DocumentTypeSection({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          children: [
            Icon(Icons.category, color: Colors.green.shade700),
            const SizedBox(width: 8),
            Text(
              'Document Type',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Choose the document type to enable smart features and intelligent metadata',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 16),

        // Document Type Dropdown
        DropdownButtonFormField<DocumentType>(
          value: selectedType,
          decoration: const InputDecoration(
            labelText: 'Document Type',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.assignment),
            helperText: 'Different types unlock different smart features',
          ),
          items: DocumentType.values.map((type) {
            return DropdownMenuItem(
              value: type,
              child: Row(
                children: [
                  _getDocumentTypeIcon(type),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_getDocumentTypeDisplayName(type)),
                      Text(
                        _getDocumentTypeDescription(type),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (DocumentType? newValue) {
            if (newValue != null) {
              onTypeChanged(newValue);
            }
          },
        ),
        const SizedBox(height: 16),

        // Smart Features Preview for Selected Type
        _buildSmartFeaturesPreview(),
      ],
    );
  }

  Widget _buildSmartFeaturesPreview() {
    final features = _getSmartFeatures(selectedType);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: Colors.green.shade700),
              const SizedBox(width: 8),
              Text(
                'Smart Features for ${_getDocumentTypeDisplayName(selectedType)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...features.map((feature) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Icon(Icons.check_circle, 
                     color: Colors.green.shade600, 
                     size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    feature,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Icon _getDocumentTypeIcon(DocumentType type) {
    switch (type) {
      case DocumentType.ktp:
        return const Icon(Icons.badge, color: Colors.blue);
      case DocumentType.sim:
        return const Icon(Icons.drive_eta, color: Colors.orange);
      case DocumentType.passport:
        return const Icon(Icons.flight, color: Colors.purple);
      case DocumentType.sertifikat:
        return const Icon(Icons.workspace_premium, color: Colors.amber);
      case DocumentType.ijazah:
        return const Icon(Icons.school, color: Colors.indigo);
      case DocumentType.lainnya:
        return const Icon(Icons.description, color: Colors.grey);
    }
  }

  String _getDocumentTypeDisplayName(DocumentType type) {
    switch (type) {
      case DocumentType.ktp:
        return 'KTP (Identity Card)';
      case DocumentType.sim:
        return 'SIM (Driver License)';
      case DocumentType.passport:
        return 'Passport';
      case DocumentType.sertifikat:
        return 'Certificate';
      case DocumentType.ijazah:
        return 'Diploma';
      case DocumentType.lainnya:
        return 'Other Documents';
    }
  }

  String _getDocumentTypeDescription(DocumentType type) {
    switch (type) {
      case DocumentType.ktp:
        return 'Indonesian Identity Card with NIK';
      case DocumentType.sim:
        return 'Driving License with expiry tracking';
      case DocumentType.passport:
        return 'Travel document with validity checks';
      case DocumentType.sertifikat:
        return 'Professional or skill certificate';
      case DocumentType.ijazah:
        return 'Educational diploma or degree';
      case DocumentType.lainnya:
        return 'General document storage';
    }
  }

  List<String> _getSmartFeatures(DocumentType type) {
    switch (type) {
      case DocumentType.ktp:
        return [
          'Search by NIK instantly',
          'Auto-complete job application bundles',
          'Smart demographic insights',
          'Regional document grouping',
        ];
      case DocumentType.sim:
        return [
          '30-day renewal reminders',
          'License type validation',
          'Vehicle compatibility checking',
          'Auto-complete registration bundles',
        ];
      case DocumentType.passport:
        return [
          '6-month travel validity alerts',
          'Visa requirement checking',
          'Travel bundle auto-completion',
          'Country-specific reminders',
        ];
      case DocumentType.sertifikat:
        return [
          'Expiry date tracking',
          'Professional portfolio bundles',
          'Skill categorization',
          'Achievement timeline',
        ];
      case DocumentType.ijazah:
        return [
          'Education timeline tracking',
          'Academic bundle creation',
          'GPA and honors tracking',
          'Career progression insights',
        ];
      case DocumentType.lainnya:
        return [
          'Basic search and organization',
          'Custom tagging system',
          'General bundle inclusion',
          'Simple reminder system',
        ];
    }
  }
}
