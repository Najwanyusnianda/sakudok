import 'package:flutter/material.dart';
import '../../../domain/entities/document_type.dart';

class DocumentTypeSelectionStep extends StatelessWidget {
  final DocumentType selectedType;
  final ValueChanged<DocumentType> onTypeChanged;

  const DocumentTypeSelectionStep({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Step Header
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade50, Colors.indigo.shade50],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade600,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.category,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Step 1: Choose Document Type',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Select the type of document to enable smart features and auto-detection',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Document Type Cards
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: DocumentType.values.length,
          itemBuilder: (context, index) {
            final type = DocumentType.values[index];
            final isSelected = type == selectedType;
            
            return _buildTypeCard(context, type, isSelected);
          },
        ),
      ],
    );
  }

  Widget _buildTypeCard(BuildContext context, DocumentType type, bool isSelected) {
    final config = _getTypeConfig(type);
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTypeChanged(type),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? config.color : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
              color: isSelected 
                ? config.color.withOpacity(0.1) 
                : Colors.white,
              boxShadow: isSelected 
                ? [
                    BoxShadow(
                      color: config.color.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected 
                      ? config.color 
                      : config.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    config.icon,
                    size: 28,
                    color: isSelected ? Colors.white : config.color,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Title
                Text(
                  config.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? config.color : Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                
                // Description
                Text(
                  config.description,
                  style: TextStyle(
                    fontSize: 11,
                    color: isSelected 
                      ? config.color.withOpacity(0.8)
                      : Colors.grey.shade500,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                // Smart Features Badge
                if (config.hasSmartFeatures) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isSelected 
                        ? config.color 
                        : config.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Smart OCR',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : config.color,
                      ),
                    ),
                  ),
                ],
              ],
            ),
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
          description: 'Indonesian ID Card',
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
          description: 'Certification Document',
          icon: Icons.workspace_premium,
          color: Colors.orange,
          hasSmartFeatures: true,
        );
      case DocumentType.ijazah:
        return _TypeConfig(
          title: 'Diploma',
          description: 'Educational Certificate',
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
  final Color color;
  final bool hasSmartFeatures;

  const _TypeConfig({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.hasSmartFeatures,
  });
}
