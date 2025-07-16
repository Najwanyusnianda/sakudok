import 'package:flutter/material.dart';
import '../../../domain/entities/document_type.dart';
import '../../../domain/entities/metadata/document_metadata.dart';
import 'ktp_metadata_form.dart';
import 'sim_metadata_form.dart';

class SmartMetadataSection extends StatelessWidget {
  final DocumentType selectedType;
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
      case DocumentType.ktp:
        return KTPMetadataForm(
          initialData: currentMetadata,
          onDataChanged: onMetadataChanged,
        );
      
      case DocumentType.sim:
        return SIMMetadataForm(
          initialData: currentMetadata,
          onDataChanged: onMetadataChanged,
        );
      
      case DocumentType.passport:
        return _buildComingSoonForm(
          'Passport',
          Icons.flight,
          Colors.purple,
          [
            'Travel validity alerts',
            'Visa requirement checking',
            'International travel bundles',
            'Embassy contact integration',
          ],
        );
      
      case DocumentType.sertifikat:
        return _buildComingSoonForm(
          'Certificate',
          Icons.workspace_premium,
          Colors.amber,
          [
            'Professional skill tracking',
            'Expiry date management',
            'Portfolio bundle creation',
            'Career progression insights',
          ],
        );
      
      case DocumentType.ijazah:
        return _buildComingSoonForm(
          'Diploma',
          Icons.school,
          Colors.indigo,
          [
            'Academic timeline tracking',
            'GPA and honors recording',
            'Education bundle creation',
            'Career path recommendations',
          ],
        );
      
      case DocumentType.lainnya:
        return _buildGenericForm();
    }
  }

  Widget _buildComingSoonForm(String typeName, IconData icon, MaterialColor color, List<String> features) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.shade50,
            color.shade100,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.shade300),
      ),
      child: Column(
        children: [
          // Icon and Title
          Icon(icon, size: 64, color: color.shade600),
          const SizedBox(height: 16),
          Text(
            'Smart $typeName Form',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Coming Soon',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: color.shade600,
            ),
          ),
          const SizedBox(height: 16),
          
          // Features Preview
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Planned Smart Features:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                ...features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Icon(Icons.auto_awesome, 
                           color: color.shade600, 
                           size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          feature,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Progress Info
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.schedule, color: color.shade600, size: 16),
              const SizedBox(width: 8),
              Text(
                'Intelligent form under development',
                style: TextStyle(
                  fontSize: 12,
                  color: color.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
