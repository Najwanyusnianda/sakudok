// lib/features/documents/presentation/widgets/quick_save/document_preview_card.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DocumentPreviewCard extends StatelessWidget {
  final File documentFile;

  const DocumentPreviewCard({super.key, required this.documentFile});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: documentFile.path.toLowerCase().endsWith('.pdf')
            ? _buildPdfPreview(context)
            : _buildImagePreview(),
      ),
    );
  }

  Widget _buildPdfPreview(BuildContext context) {
    // --- IMPROVEMENT: Show the first page of the PDF ---
    // This provides better user feedback than a static icon.
    return SfPdfViewer.file(
      documentFile,
      // Disable interaction to keep it as a static preview
      canShowScrollHead: false,
      canShowScrollStatus: false,
      enableDoubleTapZooming: false,
    );
  }

  Widget _buildImagePreview() {
    return Image.file(
      documentFile,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Center(child: Text('Cannot preview image'));
      },
    );
  }
}