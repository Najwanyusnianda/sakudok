// lib/features/documents/presentation/widgets/document_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../../domain/entities/document.dart';
import '../../domain/entities/document_type.dart';
import 'document_list/data_quick_view_modal.dart'; // Ensure this path is correct

class DocumentCard extends StatelessWidget {
  final Document document;
  final VoidCallback onViewFile; // Opens the actual document attachment
  final VoidCallback? onViewData; // Opens the DataQuickViewModal
  final VoidCallback? onManageData; // Navigates to the data input/edit form
  final VoidCallback? onContextMenu; // Opens the 3-dot menu

  const DocumentCard({
    super.key,
    required this.document,
    required this.onViewFile,
    this.onViewData,
    this.onManageData,
    this.onContextMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2, // Subtle shadow for modern look
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias, // Ensures InkWell ripple stays within rounded corners
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section 1: Primary Document Info & File Access
          // This entire section is the tap target for onViewFile
          _buildPrimaryFileSection(context),

          // Section 2: Data Quick View & Last Updated (if structured data exists)
          if (_hasStructuredData())
            _buildDataQuickViewAndUpdatedSection(context),

          // Section 3: Data Management Action & Context Menu
          _buildDataManagementAndContextMenuSection(context),
        ],
      ),
    );
  }

  // --- Helper Widgets for Sections ---

Widget _buildPrimaryFileSection(BuildContext context) {
    return InkWell(
      onTap: onViewFile, // Tapping anywhere here opens the file
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Document Type Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _getDocumentTypeColor(document.mainType).withOpacity(0.1), // Lighter background
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getDocumentIcon(document.mainType, document.filePaths.isNotEmpty ? document.filePaths.first.split('.').last : ''), // More specific icon
                color: _getDocumentTypeColor(document.mainType),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Document Name and File Type
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                          color: Colors.grey.shade900, // Stronger text color
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getFileTypeLabel(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),

            // Status indicators (Favorite, Expiry Warning)
            _buildStatusIndicators(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicators(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Use minimum space
      children: [
        if (document.isFavorite)
          Icon(
            Icons.star_rounded, // Use rounded star for modern look
            color: Colors.amber.shade600,
            size: 20,
          ),
        if (_hasExpiryWarning())
          Padding(
            padding: EdgeInsets.only(top: document.isFavorite ? 4 : 0), // Add padding only if favorite is also present
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.warning_rounded, // Use rounded warning icon
                color: Colors.orange.shade700,
                size: 14,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDataQuickViewAndUpdatedSection(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onViewData != null) {
          onViewData!();
        } else {
          // Default behavior: show data quick view modal
          DataQuickViewModal.show(
            context,
            document,
            onEditData: onManageData,
            onViewFile: onViewFile,
          );
        }
      },
      // Removed Container with blue background and borders for minimalism
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              Icons.dashboard_rounded, // More intuitive icon for data/dashboard
              size: 18,
              color: Theme.of(context).primaryColor, // Use primary blue
            ),
            const SizedBox(width: 8),
            Text(
              'View Data',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).primaryColor, // Use primary blue
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Spacer(), // Pushes updated info to the right
            Icon(
              Icons.access_time_rounded, // Rounded time icon
              size: 16,
              color: Colors.grey.shade600,
            ),
            const SizedBox(width: 4),
            Text(
              'Updated ${_formatLastUpdated()}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                    // fontSize: 11, // Keep default bodySmall or adjust slightly
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataManagementAndContextMenuSection(BuildContext context) {
    final hasMetadata = _hasStructuredData();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16), // Adjust padding for bottom section
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space
        children: [
          // Data Management Action (InkWell for better tap feedback)
          Expanded(
            child: InkWell(
              onTap: onManageData,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                // Removed BoxDecoration border for a cleaner look
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Keep content compact
                  children: [
                    Icon(
                      hasMetadata ? Icons.edit_note_rounded : Icons.add_box_rounded, // More specific icons
                      size: 18,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      hasMetadata ? 'Manage Data' : 'Add Data',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Context Menu (InkWell for better tap feedback)
          InkWell(
            onTap: onContextMenu,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(8), // Padding for tap target
              // Removed BoxDecoration border for a cleaner look
              child: Icon(
                Icons.more_vert_rounded, // Rounded variant
                size: 20, // Slightly larger for easier tapping
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Methods ---

  bool _hasStructuredData() {
    // This logic assumes document.metadata is an actual object/map
    // and not just an empty default Object instance.
    // You might need to refine this based on your actual Document entity structure.
    // For example, if metadata is a Map<String, dynamic>, check if it's not empty.
    return document.metadata != null; // Assuming metadata is a Map or similar
  }

  String _getFileTypeLabel() {
    if (document.filePaths.isNotEmpty) {
      final path = document.filePaths.first;
      final extension = path.split('.').last.toLowerCase();
      switch (extension) {
        case 'pdf':
          return 'PDF Document';
        case 'jpg':
        case 'jpeg':
          return 'JPEG Image';
        case 'png':
          return 'PNG Image';
        case 'doc':
        case 'docx':
          return 'Word Document';
        default:
          return 'Document';
      }
    }
    return 'Document';
  }

  IconData _getDocumentIcon(MainDocumentType type, String fileExtension) {
    // You can make these icons more specific based on your design system
    switch (type) {
      case MainDocumentType.CARD:
        return Icons.credit_card_rounded; // More specific for cards
      case MainDocumentType.DOCUMENT:
        switch (fileExtension.toLowerCase()) {
          case 'pdf':
            return Icons.picture_as_pdf_rounded;
          case 'jpg':
          case 'jpeg':
          case 'png':
            return Icons.image_rounded;
          case 'doc':
          case 'docx':
            return Icons.description_rounded; // For general documents like Word
          default:
            return Icons.insert_drive_file_rounded; // Generic file icon
        }
      case MainDocumentType.OTHER:
        return Icons.folder_open_rounded; // Generic folder for 'other'
    }
  }

  bool _hasExpiryWarning() {
    if (document.expiryDate == null) return false;

    final now = DateTime.now();
    final difference = document.expiryDate!.difference(now).inDays;
    return difference <= 60 && difference >= 0;
  }

  String _formatLastUpdated() {
    final now = DateTime.now();
    final difference = now.difference(document.updatedAt);

    if (difference.inDays > 7) {
      return DateFormat('dd MMM yyyy').format(document.updatedAt); // More precise for older
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  Color _getDocumentTypeColor(MainDocumentType type) {
    switch (type) {
      case MainDocumentType.CARD:
        return Colors.blue.shade700; // Deeper blue
      case MainDocumentType.DOCUMENT:
        return Colors.green.shade700; // Deeper green
      case MainDocumentType.OTHER:
        return Colors.grey.shade700; // Deeper grey
    }
  }
}
