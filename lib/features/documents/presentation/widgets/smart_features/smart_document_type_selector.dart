import 'package:flutter/material.dart';
import '../../../domain/entities/document_type.dart';

class SmartDocumentTypeSelector extends StatelessWidget {
  final DocumentType? selectedType;
  final Function(DocumentType) onTypeSelected;
  final bool isLoading;

  const SmartDocumentTypeSelector({
    super.key,
    this.selectedType,
    required this.onTypeSelected,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.category_outlined, color: Colors.blue.shade600),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Choose Document Type',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Select the type to enable smart features like auto-detection and reminders',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 24),
            
            // Document Types
            if (isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                ),
              )
            else
              ...DocumentType.values.map((type) => _buildTypeOption(context, type)),
            
            const SizedBox(height: 16),
            
            // Info Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.blue.shade600, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Smart features include automatic data extraction, expiry reminders, and intelligent organization.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeOption(BuildContext context, DocumentType type) {
    final config = _getTypeConfig(type);
    final isSelected = selectedType == type;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          onTypeSelected(type);
          Navigator.of(context).pop(type);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? config.color.shade50 : Colors.white,
            border: Border.all(
              color: isSelected ? config.color.shade300 : Colors.grey.shade200,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: config.color.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  config.icon,
                  color: config.color.shade700,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      config.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      config.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              if (config.hasSmartFeatures) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Smart',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
              ],
              const SizedBox(width: 8),
              Icon(
                isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                color: isSelected ? config.color.shade600 : Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _TypeConfig _getTypeConfig(DocumentType type) {
    switch (type) {
      case DocumentType.ktp:
        return _TypeConfig(
          title: 'KTP',
          description: 'Indonesian Identity Card',
          icon: Icons.badge,
          color: Colors.blue,
          hasSmartFeatures: true,
        );
      case DocumentType.sim:
        return _TypeConfig(
          title: 'SIM',
          description: 'Driver License',
          icon: Icons.drive_eta,
          color: Colors.green,
          hasSmartFeatures: true,
        );
      case DocumentType.passport:
        return _TypeConfig(
          title: 'Passport',
          description: 'Travel Document',
          icon: Icons.flight,
          color: Colors.purple,
          hasSmartFeatures: true,
        );
      case DocumentType.sertifikat:
        return _TypeConfig(
          title: 'Certificate',
          description: 'Professional Certification',
          icon: Icons.workspace_premium,
          color: Colors.amber,
          hasSmartFeatures: true,
        );
      case DocumentType.ijazah:
        return _TypeConfig(
          title: 'Diploma',
          description: 'Education Certificate',
          icon: Icons.school,
          color: Colors.indigo,
          hasSmartFeatures: true,
        );
      case DocumentType.lainnya:
        return _TypeConfig(
          title: 'Other',
          description: 'General Document',
          icon: Icons.description,
          color: Colors.grey,
          hasSmartFeatures: false,
        );
    }
  }
}

class _TypeConfig {
  final String title;
  final String description;
  final IconData icon;
  final MaterialColor color;
  final bool hasSmartFeatures;

  _TypeConfig({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.hasSmartFeatures,
  });
}
