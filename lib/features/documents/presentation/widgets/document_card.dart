//lib/features/documents/presentation/widgets/document_card.dart
import 'package:flutter/material.dart';
import '../../domain/entities/document.dart';
import '../../domain/entities/document_type.dart';
import '../../domain/entities/metadata/document_metadata.dart';
import 'metadata_previews/ktp_preview.dart';
import 'metadata_previews/sim_preview.dart';
import 'metadata_previews/passport_preview.dart';
import 'metadata_previews/ielts_preview.dart';
import 'metadata_previews/transcript_preview.dart';
import 'metadata_previews/cv_preview.dart';
import 'metadata_previews/certificate_preview.dart';
import 'metadata_previews/diploma_preview.dart';

class DocumentCard extends StatelessWidget {
  final Document document;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback? onEnableSmartFeatures;

  const DocumentCard({
    super.key,
    required this.document,
    required this.onTap,
    required this.onDelete,
    this.onEnableSmartFeatures,
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
    final hasSmartMetadata = _hasSmartMetadata();
    
    return Column(
      children: [
        // Smart Features Banner
        if (!hasSmartMetadata && onEnableSmartFeatures != null)
          _buildEnableSmartFeaturesBanner(),
        
        // Metadata Preview using Composition Pattern
        document.metadata.map(
          ktp: (metadata) => KtpPreview(metadata: metadata),
          sim: (metadata) => SimPreview(metadata: metadata),
          passport: (metadata) => PassportPreview(metadata: metadata),
          ielts: (metadata) => IeltsPreview(metadata: metadata),
          transcript: (metadata) => TranscriptPreview(metadata: metadata),
          cv: (metadata) => CvPreview(metadata: metadata),
          certificate: (metadata) => CertificatePreview(metadata: metadata),
          diploma: (metadata) => DiplomaPreview(metadata: metadata),
          unknown: (_) => const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildEnableSmartFeaturesBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.auto_awesome, color: Colors.purple.shade600, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Enable smart features for this document',
              style: TextStyle(
                fontSize: 12,
                color: Colors.purple.shade700,
              ),
            ),
          ),
          TextButton(
            onPressed: onEnableSmartFeatures,
            style: TextButton.styleFrom(
              foregroundColor: Colors.purple.shade600,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              minimumSize: Size.zero,
            ),
            child: const Text('Enable', style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }

  bool _hasSmartMetadata() {
    return document.metadata.when(
      ktp: (_, a, b, c, d, e, f, g, h, i) => true,
      sim: (_, a, b, c, d, e, f, g) => true,
      passport: (_, a, b, c, d, e, f, g, h, i) => true,
      ielts: (_, a, b, c, d, e, f, g, h, i, j) => true,
      transcript: (_, a, b, c, d, e, f, g, h) => true,
      cv: (_, a, b, c, d, e, f) => true,
      certificate: (_, a, b, c, d, e, f) => true,
      diploma: (_, a, b, c, d, e, f, g) => true,
      unknown: (_) => false,
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
