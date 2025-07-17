import 'dart:io';
import 'package:flutter/material.dart';
// ADDED: Import the Syncfusion PDF Viewer package
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../core/theme/app_theme.dart'; // Make sure you have your AppTheme imported
import '../../../domain/entities/document.dart';
import '../../pages/add_edit_document_page.dart';

class DocumentViewerBody extends StatelessWidget {
  final Document document;
  final PageController? pageController;
  final Function(int) onPageChanged;

  const DocumentViewerBody({
    super.key,
    required this.document,
    this.pageController,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Check if document has any files
    //check path
    print('Document images: ${document.images}');
    if (document.images.isEmpty) {
      return _buildNoImageState(context);
    }

    // Case A: The document is a PDF
    // Check if the first file in the list is a PDF
    final firstFile = document.images.first;
    if (firstFile.toLowerCase().endsWith('.pdf')) {
      return _buildPdfViewer(context, firstFile);
    }

    // Case B: The document contains only images
    if (document.images.length == 1) {
      return _buildSingleItem(context, document.images.first);
    }

    // Multiple images
    return _buildItemGallery(context);
  }

  Widget _buildSingleItem(BuildContext context, String path) {
    return Center(
      child: InteractiveViewer(
        minScale: 0.5,
        maxScale: 4.0,
        child: _buildItemWidget(context, path),
      ),
    );
  }

  Widget _buildItemGallery(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      onPageChanged: onPageChanged,
      itemCount: document.images.length,
      itemBuilder: (context, index) {
        return Center(
          child: InteractiveViewer(
            minScale: 0.5,
            maxScale: 4.0,
            child: _buildItemWidget(context, document.images[index]),
          ),
        );
      },
    );
  }

  Widget _buildItemWidget(BuildContext context, String path) {
    final file = File(path);

    if (!file.existsSync()) {
      return _buildErrorState(context, 'File not found at path: $path');
    }

    // Only handle images here, as PDFs are routed to their own viewer.
    return Image.file(
      file,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return _buildErrorState(context, 'Cannot display image: ${error.toString()}');
      },
    );
  }

  Widget _buildPdfViewer(BuildContext context, String path) {
    final file = File(path);

    if (!file.existsSync()) {
      return _buildErrorState(context, 'PDF file not found at path: $path');
    }

    // The SfPdfViewer widget handles its own loading and error states.
    return SfPdfViewer.file(
      file,
      // The onDocumentLoadFailed callback is for logic (like logging), not for UI.
      // The viewer will show its own default error message if a document fails to load.
      onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
        // You can add logging or analytics here.
        debugPrint('Error loading PDF: ${details.error}');
        debugPrint(details.description);
      },
    );
  }

  Widget _buildNoImageState(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceXl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported_outlined,
            size: 120,
            color: colorScheme.onSurfaceVariant.withOpacity(0.5),
          ),
          const SizedBox(height: AppTheme.spaceLg),
          Text(
            'No Files Available',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppTheme.spaceSm),
          Text(
            "This document doesn't have any files attached.",
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spaceXl),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    AddEditDocumentPage(documentId: document.id),
              ));
            },
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Edit Document'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceXl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 120,
            color: colorScheme.error.withOpacity(0.7),
          ),
          const SizedBox(height: AppTheme.spaceLg),
          Text(
            'Error Loading File',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spaceSm),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
