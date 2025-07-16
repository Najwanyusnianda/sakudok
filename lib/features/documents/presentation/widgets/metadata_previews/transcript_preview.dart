import 'package:flutter/material.dart';
import '../../../domain/entities/metadata/document_metadata.dart';

class TranscriptPreview extends StatelessWidget {
  final TranscriptMetadata metadata;
  
  const TranscriptPreview({super.key, required this.metadata});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.school, color: Colors.teal.shade600, size: 16),
              const SizedBox(width: 8),
              Text(
                'Academic Transcript',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildRow('Student', metadata.studentName),
          _buildRow('University', metadata.university),
          _buildRow('Degree', '${metadata.degree} in ${metadata.major}'),
          _buildRow('GPA', metadata.gpa.toString()),
          _buildRow('Graduation', _formatDate(metadata.graduationDate)),
          if (metadata.facultyDean != null)
            _buildRow('Dean', metadata.facultyDean!),
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
