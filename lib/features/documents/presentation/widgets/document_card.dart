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
  final VoidCallback? onEdit;
  final VoidCallback? onEnableSmartFeatures;

  const DocumentCard({
    super.key,
    required this.document,
    required this.onTap,
    required this.onDelete,
    this.onEdit,
    this.onEnableSmartFeatures,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row: Document type, title, and actions
              _buildHeaderRow(context),
              const SizedBox(height: 12),
              
              // Description
              if (document.description != null && document.description!.isNotEmpty) ...[
                Text(
                  document.description!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
              ],
              
              // Metadata Preview (for smart documents)
              _buildMetadataPreview(context),
              
              // Tags
              if (document.tags.isNotEmpty) ...[
                const SizedBox(height: 12),
                _buildTagsRow(context),
              ],
              
              const SizedBox(height: 12),
              
              // Footer Row: Update date and status indicators
              _buildFooterRow(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Row(
      children: [
        // Document Type Icon
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _getDocumentTypeColor(document.type).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            _getIconForDocumentType(document.type),
            color: _getDocumentTypeColor(document.type),
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        
        // Document Type Label and Title
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Document Type Label
              Text(
                _getDocumentTypeDisplayName(document.type),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _getDocumentTypeColor(document.type),
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 2),
              
              // Document Title
              Text(
                document.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        
        // Status Indicators and Actions
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Favorite Star
            if (document.isFavorite)
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.star_rounded,
                  color: Colors.amber.shade600,
                  size: 18,
                ),
              ),
            
            // Expiry Warning
            if (_hasExpiryWarning()) ...[
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.warning_rounded,
                      color: Colors.orange.shade700,
                      size: 12,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      _getExpiryText(),
                      style: TextStyle(
                        color: Colors.orange.shade700,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            // More Actions Menu
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.grey.shade600,
                size: 18,
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'view',
                  child: Row(
                    children: [
                      Icon(Icons.visibility_outlined, size: 16),
                      SizedBox(width: 8),
                      Text('View'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit_outlined, size: 16),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                if (onEnableSmartFeatures != null && !_hasSmartMetadata())
                  const PopupMenuItem(
                    value: 'smart',
                    child: Row(
                      children: [
                        Icon(Icons.auto_awesome, size: 16),
                        SizedBox(width: 8),
                        Text('Enable Smart Features'),
                      ],
                    ),
                  ),
                const PopupMenuItem(
                  value: 'share',
                  child: Row(
                    children: [
                      Icon(Icons.share_outlined, size: 16),
                      SizedBox(width: 8),
                      Text('Share'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline, size: 16, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Delete', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case 'view':
                    onTap();
                    break;
                  case 'edit':
                    onEdit?.call();
                    break;
                  case 'smart':
                    onEnableSmartFeatures?.call();
                    break;
                  case 'share':
                    // TODO: Implement share functionality
                    break;
                  case 'delete':
                    onDelete();
                    break;
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTagsRow(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: document.tags.take(3).map((tag) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Text(
          tag,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey.shade700,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      )).toList()..addAll(
        document.tags.length > 3 ? [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '+${document.tags.length - 3}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ] : [],
      ),
    );
  }

  Widget _buildFooterRow(BuildContext context) {
    return Row(
      children: [
        // Update Date
        Icon(
          Icons.schedule,
          color: Colors.grey.shade500,
          size: 14,
        ),
        const SizedBox(width: 4),
        Text(
          'Updated ${_formatDate(document.updatedAt)}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey.shade600,
            fontSize: 11,
          ),
        ),
        
        const Spacer(),
        
        // Smart Features Indicator
        if (_hasSmartMetadata())
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.purple.shade200),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: Colors.purple.shade600,
                  size: 10,
                ),
                const SizedBox(width: 2),
                Text(
                  'Smart',
                  style: TextStyle(
                    color: Colors.purple.shade700,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        else if (onEnableSmartFeatures != null)
          GestureDetector(
            onTap: onEnableSmartFeatures,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple.shade200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.auto_awesome_outlined,
                    color: Colors.purple.shade600,
                    size: 12,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Enable Smart Features',
                    style: TextStyle(
                      color: Colors.purple.shade700,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMetadataPreview(BuildContext context) {
    // Metadata Preview using Composition Pattern
    return document.metadata.map(
      ktp: (metadata) => KtpPreview(metadata: metadata),
      sim: (metadata) => SimPreview(metadata: metadata),
      passport: (metadata) => PassportPreview(metadata: metadata),
      ielts: (metadata) => IeltsPreview(metadata: metadata),
      transcript: (metadata) => TranscriptPreview(metadata: metadata),
      cv: (metadata) => CvPreview(metadata: metadata),
      certificate: (metadata) => CertificatePreview(metadata: metadata),
      diploma: (metadata) => DiplomaPreview(metadata: metadata),
      unknown: (_) => const SizedBox.shrink(),
    );
  }

  Color _getDocumentTypeColor(DocumentType type) {
    switch (type) {
      case DocumentType.ktp:
        return Colors.blue.shade600;
      case DocumentType.sim:
        return Colors.green.shade600;
      case DocumentType.passport:
        return Colors.purple.shade600;
      case DocumentType.ijazah:
        return Colors.indigo.shade600;
      case DocumentType.sertifikat:
        return Colors.orange.shade600;
      case DocumentType.lainnya:
        return Colors.grey.shade600;
    }
  }

  String _getDocumentTypeDisplayName(DocumentType type) {
    switch (type) {
      case DocumentType.ktp:
        return 'KTP (Identity Card)';
      case DocumentType.sim:
        return 'SIM (Driver License)';
      case DocumentType.passport:
        return 'Passport';
      case DocumentType.ijazah:
        return 'Diploma';
      case DocumentType.sertifikat:
        return 'Certificate';
      case DocumentType.lainnya:
        return 'Other Document';
    }
  }

  bool _hasExpiryWarning() {
    return document.expiryDate != null && 
           document.expiryDate!.difference(DateTime.now()).inDays <= 60;
  }

  String _getExpiryText() {
    if (document.expiryDate == null) return '';
    
    final daysLeft = document.expiryDate!.difference(DateTime.now()).inDays;
    if (daysLeft <= 0) {
      return 'Expired';
    } else if (daysLeft <= 7) {
      return '${daysLeft}d left';
    } else if (daysLeft <= 30) {
      return '${(daysLeft / 7).ceil()}w left';
    } else {
      return '${(daysLeft / 30).ceil()}m left';
    }
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
