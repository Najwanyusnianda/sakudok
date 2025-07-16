import 'package:flutter/material.dart';
import '../../../domain/entities/metadata/document_metadata.dart';

class PassportPreview extends StatelessWidget {
  final PassportMetadata metadata;
  
  const PassportPreview({super.key, required this.metadata});

  @override
  Widget build(BuildContext context) {
    final isExpiringSoon = DateTime.now().difference(metadata.expiryDate).inDays > -180; // 6 months warning
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isExpiringSoon ? Colors.orange.shade50 : Colors.purple.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isExpiringSoon ? Colors.orange.shade200 : Colors.purple.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.flight,
                color: isExpiringSoon ? Colors.orange.shade600 : Colors.purple.shade600,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Passport ${metadata.nationality}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isExpiringSoon ? Colors.orange.shade700 : Colors.purple.shade700,
                ),
              ),
              if (isExpiringSoon) ...[
                const SizedBox(width: 8),
                Icon(Icons.schedule, color: Colors.orange.shade600, size: 14),
              ],
            ],
          ),
          const SizedBox(height: 8),
          _buildRow('No. Passport', metadata.passportNumber, isExpiringSoon),
          _buildRow('Nama', metadata.holderName, isExpiringSoon),
          _buildRow('Kewarganegaraan', metadata.nationality, isExpiringSoon),
          _buildRow('Berlaku Sampai', _formatDate(metadata.expiryDate), isExpiringSoon),
          if (metadata.issuingAuthority != null)
            _buildRow('Penerbit', metadata.issuingAuthority!, isExpiringSoon),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, bool isExpiring) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text.rich(
        TextSpan(
          style: TextStyle(
            fontSize: 11,
            color: isExpiring ? Colors.orange.shade700 : Colors.grey.shade700,
          ),
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
