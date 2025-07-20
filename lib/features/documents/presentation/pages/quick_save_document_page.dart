// lib/features/documents/presentation/pages/quick_save_document_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:path/path.dart' as p; // Import the path package
import '../../domain/entities/document.dart';
import '../../domain/entities/document_type.dart';
import '../../domain/entities/metadata/document_metadata.dart';
import '../providers/document_providers.dart';
import '../../../../core/providers/file_service_provider.dart';
import 'package:intl/intl.dart';
import '../widgets/quick_save/document_preview_card.dart';
import '../widgets/quick_save/quick_save_form.dart';

class QuickSaveDocumentPage extends ConsumerStatefulWidget {
  final File documentFile;

  const QuickSaveDocumentPage({super.key, required this.documentFile});

  @override
  ConsumerState<QuickSaveDocumentPage> createState() => _QuickSaveDocumentPageState();
}

class _QuickSaveDocumentPageState extends ConsumerState<QuickSaveDocumentPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  MainDocumentType _selectedMainType = MainDocumentType.OTHER;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    
    // --- IMPROVEMENT: Pre-fill the title with the file name ---
    // Use the path package to get the base name of the file.
    String fileName = p.basename(widget.documentFile.path);
    // Remove the file extension for a cleaner title.
    if (fileName.contains('.')) {
      fileName = fileName.substring(0, fileName.lastIndexOf('.'));
    }
    _titleController.text = fileName;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _saveDocument() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final fileService = ref.read(fileServiceProvider);
      final savedFilePath = await fileService.copyFileToAppDirectory(
        sourceFile: widget.documentFile,
        documentType: _selectedMainType,
      );

      final document = Document(
        id: '', // Handled by repository
        title: _titleController.text.trim(),
        mainType: _selectedMainType,
        metadata: const DocumentMetadata.unknown({}),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        filePaths: [savedFilePath],
      );

      final notifier = ref.read(documentsNotifierProvider.notifier);
      final success = await notifier.addDocument(document);
      
      if (mounted) {
        if (success) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else {
          await fileService.deleteFile(savedFilePath); // Clean up on failure
          _showSnackBar('Failed to save document', isError: true);
        }
      }
    } catch (e) {
      _showSnackBar('An error occurred: $e', isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Save Document')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DocumentPreviewCard(documentFile: widget.documentFile),
            const SizedBox(height: 24),
            QuickSaveForm(
              formKey: _formKey,
              titleController: _titleController,
              selectedMainType: _selectedMainType,
              onTypeChanged: (newType) {
                setState(() => _selectedMainType = newType);
              },
            ),
          ],
        ),
      ),
      // Use a persistent bottom button for the primary action
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          onPressed: _isLoading ? null : _saveDocument,
          icon: _isLoading ? Container() : const Icon(Icons.save_outlined),
          label: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save Document'),
        ),
      ),
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Theme.of(context).colorScheme.error : Colors.green.shade600,
      ),
    );
  }
}