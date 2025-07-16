import 'package:flutter/material.dart';
import '../../../domain/entities/metadata/document_metadata.dart';

class CvPreview extends StatelessWidget {
  final CVMetadata metadata;
  
  const CvPreview({super.key, required this.metadata});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.cyan.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.cyan.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: Colors.cyan.shade600, size: 16),
              const SizedBox(width: 8),
              Text(
                'CV/Resume',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildRow('Name', metadata.fullName),
          _buildRow('Profession', metadata.profession),
          _buildRow('Email', metadata.email),
          _buildRow('Phone', metadata.phoneNumber),
          if (metadata.yearsOfExperience != null)
            _buildRow('Experience', '${metadata.yearsOfExperience} years'),
          if (metadata.lastUpdated != null)
            _buildRow('Last Updated', _formatDate(metadata.lastUpdated!)),
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
