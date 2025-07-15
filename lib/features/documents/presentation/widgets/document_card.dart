import 'package:flutter/material.dart';
import '../../domain/entities/document.dart';
import '../../domain/entities/metadata/document_metadata.dart';

class DocumentCard extends StatelessWidget {
  final Document document;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const DocumentCard({
    super.key,
    required this.document,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: _buildLeadingIcon(),
            title: Text(document.title),
            subtitle: Text(document.description ?? ''),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: onDelete,
            ),
            onTap: onTap,
          ),
          _buildMetadataPreview(context),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                if (document.tags.isNotEmpty) ...[
                  const Icon(Icons.label_outline, size: 16),
                  const SizedBox(width: 4),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: document.tags
                            .map((tag) => Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Chip(
                                    label: Text(tag),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
                const Spacer(),
                Text(
                  'Diperbarui: ${_formatDate(document.updatedAt)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadingIcon() {
    return Stack(
      children: [
        Icon(
          _getIconForDocumentType(document.type),
          size: 32,
        ),
        if (document.isFavorite)
          const Positioned(
            right: -4,
            top: -4,
            child: Icon(
              Icons.star,
              size: 16,
              color: Colors.amber,
            ),
          ),
      ],
    );
  }

  Widget _buildMetadataPreview(BuildContext context) {
    return document.metadata.when(
      ktp: (nik, fullName, birthPlace, birthDate, gender, bloodType, address, rt,
          rw, kelurahan, kecamatan, religion, maritalStatus, occupation,
          citizenship, issuedDate, issuedBy) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('NIK: $nik'),
              Text('Nama: $fullName'),
              Text('Alamat: $address, RT $rt/RW $rw'),
            ],
          ),
        );
      },
      ielts: (candidateNumber, testReportNumber, testDate, expiryDate,
          overallBand, listeningScore, readingScore, writingScore, speakingScore,
          testCenter) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Overall Band: $overallBand'),
              Text('Test Date: ${_formatDate(testDate)}'),
              Text('Expires: ${_formatDate(expiryDate)}'),
            ],
          ),
        );
      },
      unknown: (data) {
        return const SizedBox.shrink();
      },
    );
  }

  IconData _getIconForDocumentType(DocumentType type) {
    switch (type) {
      case DocumentType.ktp:
        return Icons.credit_card;
      case DocumentType.sim:
        return Icons.drive_eta;
      case DocumentType.passport:
        return Icons.book;
      case DocumentType.ijazah:
        return Icons.school;
      case DocumentType.sertifikat:
        return Icons.workspace_premium;
      case DocumentType.lainnya:
        return Icons.description;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
