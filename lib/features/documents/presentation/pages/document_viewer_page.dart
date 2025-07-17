// lib/features/documents/presentation/pages/document_viewer_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import '../../domain/entities/document.dart';
import '../../domain/entities/document_type.dart';
import 'add_edit_document_page.dart';

class DocumentViewerPage extends StatefulWidget {
  final Document document;

  const DocumentViewerPage({
    super.key,
    required this.document,
  });

  @override
  State<DocumentViewerPage> createState() => _DocumentViewerPageState();
}

class _DocumentViewerPageState extends State<DocumentViewerPage> {
  PageController? _pageController;
  int _currentIndex = 0;
  bool _showAppBar = true;

  @override
  void initState() {
    super.initState();
    if (widget.document.images.length > 1) {
      _pageController = PageController();
    }
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: _showAppBar ? _buildAppBar() : null,
      body: GestureDetector(
        onTap: () {
          setState(() {
            _showAppBar = !_showAppBar;
          });
        },
        child: widget.document.images.isEmpty
            ? _buildNoImageState()
            : widget.document.images.length == 1
                ? _buildSingleImage()
                : _buildImageGallery(),
      ),
      bottomNavigationBar: _showAppBar && widget.document.images.length > 1
          ? _buildBottomNavigationBar()
          : null,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black.withValues(alpha: 0.7),
      foregroundColor: Colors.white,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.document.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (widget.document.images.length > 1)
            Text(
              '${_currentIndex + 1} of ${widget.document.images.length}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddEditDocumentPage(
                  documentId: widget.document.id,
                ),
              ),
            );
          },
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) => _handleMenuAction(value),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'share',
              child: Row(
                children: [
                  Icon(Icons.share, size: 16),
                  SizedBox(width: 8),
                  Text('Share'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'info',
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 16),
                  SizedBox(width: 8),
                  Text('Document Info'),
                ],
              ),
            ),
          ],
        ),
      ],
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  Widget _buildSingleImage() {
    final imagePath = widget.document.images.first;
    
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
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      itemCount: widget.document.images.length,
      itemBuilder: (context, index) {
        return Center(
          child: InteractiveViewer(
            minScale: 0.5,
            maxScale: 4.0,
            child: _buildImageWidget(widget.document.images[index]),
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
          Icon(
            Icons.picture_as_pdf,
            size: 120,
            color: Colors.red.shade400,
          ),
          const SizedBox(height: 24),
          const Text(
            'PDF Document',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.document.title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Text(
            'PDF viewing is not yet supported.\nTap the edit button to manage this document.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNoImageState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported,
            size: 120,
            color: Colors.grey.shade600,
          ),
          const SizedBox(height: 24),
          const Text(
            'No Images Available',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This document doesn\'t have any images attached.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddEditDocumentPage(
                    documentId: widget.document.id,
                  ),
                ),
              );
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
          Icon(
            Icons.error_outline,
            size: 120,
            color: Colors.orange.shade400,
          ),
          const SizedBox(height: 24),
          Text(
            message,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'The document file may have been moved or deleted.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      color: Colors.black.withValues(alpha: 0.7),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: _currentIndex > 0
                  ? () {
                      _pageController?.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  : null,
              icon: Icon(
                Icons.chevron_left,
                color: _currentIndex > 0 ? Colors.white : Colors.grey.shade600,
                size: 32,
              ),
            ),
            Text(
              '${_currentIndex + 1} / ${widget.document.images.length}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(
              onPressed: _currentIndex < widget.document.images.length - 1
                  ? () {
                      _pageController?.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  : null,
              icon: Icon(
                Icons.chevron_right,
                color: _currentIndex < widget.document.images.length - 1
                    ? Colors.white
                    : Colors.grey.shade600,
                size: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'share':
        _shareDocument();
        break;
      case 'info':
        _showDocumentInfo();
        break;
    }
  }

  void _shareDocument() {
    // TODO: Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Share functionality coming soon'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showDocumentInfo() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
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
                    _buildInfoRow('Title', widget.document.title),
                    _buildInfoRow('Type', _getDocumentTypeDisplayName(widget.document.type)),
                    if (widget.document.description != null && widget.document.description!.isNotEmpty)
                      _buildInfoRow('Description', widget.document.description!),
                    _buildInfoRow('Created', _formatDateTime(widget.document.createdAt)),
                    _buildInfoRow('Last Updated', _formatDateTime(widget.document.updatedAt)),
                    if (widget.document.expiryDate != null)
                      _buildInfoRow('Expires', _formatDateTime(widget.document.expiryDate!)),
                    _buildInfoRow('Images', '${widget.document.images.length} file(s)'),
                    if (widget.document.tags.isNotEmpty)
                      _buildInfoRow('Tags', widget.document.tags.join(', ')),
                    _buildInfoRow('Favorite', widget.document.isFavorite ? 'Yes' : 'No'),
                  ],
                ),
              ),
            ),
          ],
        ),
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
            label,
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

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
