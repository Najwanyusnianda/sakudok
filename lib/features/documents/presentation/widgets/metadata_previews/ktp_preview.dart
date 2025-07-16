import 'package:flutter/material.dart';
import '../../../domain/entities/metadata/document_metadata.dart';

class KtpPreview extends StatelessWidget {
  final KTPMetadata metadata;
  
  const KtpPreview({super.key, required this.metadata});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.badge, color: Colors.blue.shade600, size: 16),
              const SizedBox(width: 8),
              Text(
                'KTP Indonesia',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildRow('NIK', metadata.nik),
          _buildRow('Nama', metadata.fullName),
          _buildRow('Tempat Lahir', metadata.birthPlace),
          _buildRow('Berlaku Hingga', metadata.berlakuHingga),
          if (metadata.maritalStatus != null)
            _buildRow('Status', metadata.maritalStatus!),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text.rich(
        TextSpan(
          style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
