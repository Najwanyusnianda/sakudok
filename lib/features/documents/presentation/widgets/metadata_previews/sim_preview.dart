import 'package:flutter/material.dart';
import '../../../domain/entities/metadata/document_metadata.dart';

class SimPreview extends StatelessWidget {
  final SIMMetadata metadata;
  
  const SimPreview({super.key, required this.metadata});

  @override
  Widget build(BuildContext context) {
    final isExpiringSoon = DateTime.now().difference(metadata.expiryDate).inDays > -30;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isExpiringSoon ? Colors.red.shade50 : Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isExpiringSoon ? Colors.red.shade200 : Colors.green.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.drive_eta,
                color: isExpiringSoon ? Colors.red.shade600 : Colors.green.shade600,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'SIM ${metadata.simType}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isExpiringSoon ? Colors.red.shade700 : Colors.green.shade700,
                ),
              ),
              if (isExpiringSoon) ...[
                const SizedBox(width: 8),
                Icon(Icons.warning, color: Colors.red.shade600, size: 14),
              ],
            ],
          ),
          const SizedBox(height: 8),
          _buildRow('No. SIM', metadata.simNumber, isExpiringSoon),
          _buildRow('Nama', metadata.holderName, isExpiringSoon),
          _buildRow('Berlaku Sampai', _formatDate(metadata.expiryDate), isExpiringSoon),
          if (metadata.issuingOffice != null)
            _buildRow('Diterbitkan', metadata.issuingOffice!, isExpiringSoon),
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
            color: isExpiring ? Colors.red.shade700 : Colors.grey.shade700,
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
