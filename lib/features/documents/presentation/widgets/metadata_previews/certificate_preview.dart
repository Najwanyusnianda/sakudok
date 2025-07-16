import 'package:flutter/material.dart';
import '../../../domain/entities/metadata/document_metadata.dart';

class CertificatePreview extends StatelessWidget {
  final CertificateMetadata metadata;
  
  const CertificatePreview({super.key, required this.metadata});

  @override
  Widget build(BuildContext context) {
    final hasExpiry = metadata.expiryDate != null;
    final isExpired = hasExpiry && DateTime.now().isAfter(metadata.expiryDate!);
    final isExpiringSoon = hasExpiry && !isExpired && 
        DateTime.now().difference(metadata.expiryDate!).inDays > -90; // 3 months warning
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isExpired 
            ? Colors.red.shade50 
            : isExpiringSoon 
                ? Colors.orange.shade50 
                : Colors.amber.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isExpired 
              ? Colors.red.shade200 
              : isExpiringSoon 
                  ? Colors.orange.shade200 
                  : Colors.amber.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.workspace_premium,
                color: isExpired 
                    ? Colors.red.shade600 
                    : isExpiringSoon 
                        ? Colors.orange.shade600 
                        : Colors.amber.shade600,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  metadata.certificateName,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isExpired 
                        ? Colors.red.shade700 
                        : isExpiringSoon 
                            ? Colors.orange.shade700 
                            : Colors.amber.shade700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isExpired || isExpiringSoon) ...[
                const SizedBox(width: 8),
                Icon(
                  isExpired ? Icons.error : Icons.schedule,
                  color: isExpired ? Colors.red.shade600 : Colors.orange.shade600,
                  size: 14,
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          _buildRow('Holder', metadata.holderName, isExpired || isExpiringSoon),
          _buildRow('Issuer', metadata.issuingOrganization, isExpired || isExpiringSoon),
          _buildRow('Issued', _formatDate(metadata.issuedDate), isExpired || isExpiringSoon),
          if (hasExpiry)
            _buildRow('Expires', _formatDate(metadata.expiryDate!), isExpired || isExpiringSoon),
          if (metadata.level != null)
            _buildRow('Level', metadata.level!, isExpired || isExpiringSoon),
          if (metadata.certificateNumber != null)
            _buildRow('Number', metadata.certificateNumber!, isExpired || isExpiringSoon),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, bool isWarning) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text.rich(
        TextSpan(
          style: TextStyle(
            fontSize: 11,
            color: isWarning ? Colors.red.shade700 : Colors.grey.shade700,
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
