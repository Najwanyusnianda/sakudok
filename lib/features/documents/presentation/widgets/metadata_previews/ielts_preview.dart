import 'package:flutter/material.dart';
import '../../../domain/entities/metadata/document_metadata.dart';

class IeltsPreview extends StatelessWidget {
  final IELTSMetadata metadata;
  
  const IeltsPreview({super.key, required this.metadata});

  @override
  Widget build(BuildContext context) {
    final isExpired = DateTime.now().isAfter(metadata.expiryDate);
    final isExpiringSoon = !isExpired && DateTime.now().difference(metadata.expiryDate).inDays > -60; // 2 months warning
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isExpired 
            ? Colors.red.shade50 
            : isExpiringSoon 
                ? Colors.orange.shade50 
                : Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isExpired 
              ? Colors.red.shade200 
              : isExpiringSoon 
                  ? Colors.orange.shade200 
                  : Colors.indigo.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.school,
                color: isExpired 
                    ? Colors.red.shade600 
                    : isExpiringSoon 
                        ? Colors.orange.shade600 
                        : Colors.indigo.shade600,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'IELTS Certificate',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isExpired 
                      ? Colors.red.shade700 
                      : isExpiringSoon 
                          ? Colors.orange.shade700 
                          : Colors.indigo.shade700,
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
          _buildRow('Overall Band', metadata.overallBand.toString(), isExpired || isExpiringSoon),
          if (metadata.candidateName != null)
            _buildRow('Candidate', metadata.candidateName!, isExpired || isExpiringSoon),
          _buildRow('Test Date', _formatDate(metadata.testDate), isExpired || isExpiringSoon),
          _buildRow('Valid Until', _formatDate(metadata.expiryDate), isExpired || isExpiringSoon),
          
          // Score breakdown in a compact format
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(child: _buildScoreChip('L', metadata.listeningScore)),
              const SizedBox(width: 4),
              Expanded(child: _buildScoreChip('R', metadata.readingScore)),
              const SizedBox(width: 4),
              Expanded(child: _buildScoreChip('W', metadata.writingScore)),
              const SizedBox(width: 4),
              Expanded(child: _buildScoreChip('S', metadata.speakingScore)),
            ],
          ),
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

  Widget _buildScoreChip(String skill, double score) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$skill: $score',
        style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
