import 'package:flutter/material.dart';
import '../../../domain/entities/document.dart';
import '../../../domain/entities/document_type.dart';

class DocumentInfoSheet extends StatelessWidget {
  final Document document;

  const DocumentInfoSheet({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text(
                  'Document Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Title', document.title),
                  _buildInfoRow(
                      'Type', _getDocumentTypeDisplayName(document.mainType)),
                  if (document.description != null &&
                      document.description!.isNotEmpty)
                    _buildInfoRow('Description', document.description!),
                  _buildInfoRow('Created', _formatDateTime(document.createdAt)),
                  _buildInfoRow(
                      'Last Updated', _formatDateTime(document.updatedAt)),
                  if (document.expiryDate != null)
                    _buildInfoRow(
                        'Expires', _formatDateTime(document.expiryDate!)),
                  _buildInfoRow('Files', '${document.filePaths.length} file(s)'),
                  if (document.tags.isNotEmpty)
                    _buildInfoRow('Tags', document.tags.join(', ')),
                  _buildInfoRow('Favorite', document.isFavorite ? 'Yes' : 'No'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  String _getDocumentTypeDisplayName(MainDocumentType type) {
    switch (type) {
      case MainDocumentType.CARD:
        return 'Card';
      case MainDocumentType.DOCUMENT:
        return 'Document';
      case MainDocumentType.OTHER:
        return 'Others ';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
