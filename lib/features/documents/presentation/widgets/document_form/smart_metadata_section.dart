import 'package:flutter/material.dart';
import '../../../domain/entities/document_type.dart';
import '../../../domain/entities/metadata/document_metadata.dart';
import 'ktp_metadata_form.dart';

class SmartMetadataSection extends StatelessWidget {
  final MainDocumentType selectedType;
  final DocumentMetadata? currentMetadata;
  final ValueChanged<DocumentMetadata> onMetadataChanged;

  const SmartMetadataSection({
    super.key,
    required this.selectedType,
    this.currentMetadata,
    required this.onMetadataChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          children: [
            Icon(Icons.smart_toy, color: Colors.purple.shade700),
            const SizedBox(width: 8),
            Text(
              'Smart Document Data',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'This data enables intelligent features like smart search, proactive reminders, and bundle auto-completion',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 16),

        // Metadata Form based on document type
        _buildMetadataForm(context),
      ],
    );
  }

  Widget _buildMetadataForm(BuildContext context) {
    switch (selectedType) {
      case MainDocumentType.CARD:
        // For v1.0, show KTP form as the primary card example
        // TODO: In v2.0, detect specific card type and show appropriate form
        return KTPMetadataForm(
          initialData: currentMetadata,
          onDataChanged: onMetadataChanged,
        );
      
      case MainDocumentType.DOCUMENT:
        // For v1.0, show a generic document form
        // TODO: In v2.0, detect specific document type and show appropriate form
        return _buildGenericForm();
      
      case MainDocumentType.OTHER:
        return _buildGenericForm();
    }
  }

  Widget _buildGenericForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Icon(Icons.description, size: 48, color: Colors.grey.shade600),
          const SizedBox(height: 16),
          Text(
            'General Document',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'No specific metadata form needed for general documents. Use tags and description for organization.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue.shade700, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Tip: For better organization, consider categorizing as a specific document type',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
