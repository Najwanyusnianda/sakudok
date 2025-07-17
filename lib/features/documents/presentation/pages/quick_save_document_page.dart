import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../../domain/entities/document.dart';
import '../../domain/entities/document_type.dart';
import '../../domain/entities/metadata/document_metadata.dart';
import '../providers/document_providers.dart';
import '../../../../core/providers/file_service_provider.dart';
import 'package:intl/intl.dart';

class QuickSaveDocumentPage extends ConsumerStatefulWidget {
  final File documentFile;

  const QuickSaveDocumentPage({
    super.key,
    required this.documentFile,
  });

  @override
  ConsumerState<QuickSaveDocumentPage> createState() => _QuickSaveDocumentPageState();
}

class _QuickSaveDocumentPageState extends ConsumerState<QuickSaveDocumentPage> {
  final _titleController = TextEditingController();
  DocumentType _selectedType = DocumentType.lainnya;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Auto-populate with default title
    final now = DateTime.now();
    final dateTime = DateFormat('dd MMM yyyy, HH:mm').format(now);
    _titleController.text = 'Dokumen - $dateTime';
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _saveDocument() async {
    if (_titleController.text.trim().isEmpty) {
      _showSnackBar('Please enter a document title', isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // --- START DEBUGGING ---
      // 1. Print the original path of the file you are saving.
      // This should be a temporary path or a path from a public directory (e.g., Downloads).
      debugPrint("DEBUG: Original file path: ${widget.documentFile.path}");
      // --- END DEBUGGING ---

      // Copy file to app's private directory using FileService
      final fileService = ref.read(fileServiceProvider);
      final savedFilePath = await fileService.copyFileToAppDirectory(
        sourceFile: widget.documentFile,
        documentType: _selectedType,
      );

      // --- START DEBUGGING ---
      // 2. Print the new path returned by your FileService.
      // This should be a path inside your app's private data directory.
      debugPrint("DEBUG: New saved file path: $savedFilePath");
      // --- END DEBUGGING ---

      // Create document with the saved file path
      final document = Document(
        id: '', // Will be assigned by repository
        title: _titleController.text.trim(),
        type: _selectedType,
        metadata: const DocumentMetadata.unknown({}),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        filePaths: [savedFilePath], // Store the private app directory path
      );

      // --- START DEBUGGING ---
      // 3. Print the path that is actually being saved in the Document object.
      // This confirms you are using the new path.
      debugPrint("DEBUG: Path being saved to database: ${document.filePaths.first}");
      // --- END DEBUGGING ---

      // Save using DocumentNotifier
      final notifier = ref.read(documentsNotifierProvider.notifier);
      final success = await notifier.addDocument(document);
      
      if (success) {
        _showSnackBar('Document saved successfully!');
        if (mounted) Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        await fileService.deleteFile(savedFilePath);
        _showSnackBar('Failed to save document', isError: true);
      }
    } catch (e) {
      _showSnackBar('Failed to save document: $e', isError: true);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // --- No changes to the UI or other methods below this line ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Quick Save'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveDocument,
            child: Text(
              'Save',
              style: TextStyle(
                color: _isLoading ? Colors.white54 : Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Document Preview
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: widget.documentFile.path.toLowerCase().endsWith('.pdf')
                      ? _buildPdfPreview()
                      : _buildImagePreview(),
                ),
              ),
            ),
            // Input Section
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Document Title Field
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Document Title',
                        hintText: 'Enter document title...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.title),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),
                    // Document Type Selection
                    DropdownButtonFormField<DocumentType>(
                      value: _selectedType,
                      decoration: InputDecoration(
                        labelText: 'Document Type',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.category),
                      ),
                      items: DocumentType.values.map((type) {
                        return DropdownMenuItem<DocumentType>(
                          value: type,
                          child: Row(
                            children: [
                              Icon(
                                _getIconForDocumentType(type),
                                size: 20,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 8),
                              Text(type.name),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (DocumentType? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedType = newValue;
                          });
                        }
                      },
                    ),
                    const Spacer(),
                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _saveDocument,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text(
                                'Save Document',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPdfPreview() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.picture_as_pdf,
          size: 64,
          color: Colors.red.shade400,
        ),
        const SizedBox(height: 8),
        Text(
          'PDF Document',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  Widget _buildImagePreview() {
    return Image.file(
      widget.documentFile,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Center(child: Text('Cannot preview image'));
      },
    );
  }

  IconData _getIconForDocumentType(DocumentType type) {
    switch (type) {
      case DocumentType.ktp:
        return Icons.badge;
      case DocumentType.sim:
        return Icons.directions_car;
      case DocumentType.passport:
        return Icons.flight;
      case DocumentType.ijazah:
        return Icons.school;
      case DocumentType.sertifikat:
        return Icons.verified;
      case DocumentType.lainnya:
      default:
        return Icons.description;
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade600 : Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
