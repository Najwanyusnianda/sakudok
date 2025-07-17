import 'dart:io';
import 'package:flutter/material.dart';
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
    if (document.images.isEmpty) {
      return _buildNoImageState(context);
    }

    if (document.images.length == 1) {
      return _buildSingleImage(document.images.first);
    }

    return _buildImageGallery();
  }

  Widget _buildSingleImage(String imagePath) {
    return Center(
      child: InteractiveViewer(
        minScale: 0.5,
        maxScale: 4.0,
        child: _buildImageWidget(imagePath),
      ),
    );
  }

  Widget _buildImageGallery() {
    return PageView.builder(
      controller: pageController,
      onPageChanged: onPageChanged,
      itemCount: document.images.length,
      itemBuilder: (context, index) {
        return Center(
          child: InteractiveViewer(
            minScale: 0.5,
            maxScale: 4.0,
            child: _buildImageWidget(document.images[index]),
          ),
        );
      },
    );
  }

  Widget _buildImageWidget(String imagePath) {
    final file = File(imagePath);

    if (!file.existsSync()) {
      return _buildErrorState('File not found');
    }

    // Check if it's a PDF
    if (imagePath.toLowerCase().endsWith('.pdf')) {
      return _buildPdfPreview();
    }

    // Display image
    return Image.file(
      file,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return _buildErrorState('Cannot display image');
      },
    );
  }

  Widget _buildPdfPreview() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.picture_as_pdf, size: 120, color: Colors.red.shade400),
          const SizedBox(height: 24),
          const Text('PDF Document',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          const SizedBox(height: 32),
          Text(
            'PDF viewing is not yet supported in this preview.',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNoImageState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_not_supported, size: 120, color: Colors.grey.shade600),
          const SizedBox(height: 24),
          const Text('No Images Available',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          const SizedBox(height: 8),
          Text(
            "This document doesn't have any images attached.",
            style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    AddEditDocumentPage(documentId: document.id),
              ));
            },
            icon: const Icon(Icons.edit),
            label: const Text('Edit Document'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 120, color: Colors.orange.shade400),
          const SizedBox(height: 24),
          Text(message,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(
            'The document file may have been moved or deleted.',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
