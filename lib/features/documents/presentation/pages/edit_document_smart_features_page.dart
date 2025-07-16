import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/document.dart';
import '../../domain/entities/metadata/document_metadata.dart';
import '../providers/document_providers.dart';
import '../widgets/document_form/smart_metadata_section.dart';

class EditDocumentSmartFeaturesPage extends ConsumerStatefulWidget {
  final String documentId;

  const EditDocumentSmartFeaturesPage({
    super.key,
    required this.documentId,
  });

  @override
  ConsumerState<EditDocumentSmartFeaturesPage> createState() => _EditDocumentSmartFeaturesPageState();
}

class _EditDocumentSmartFeaturesPageState extends ConsumerState<EditDocumentSmartFeaturesPage> {
  Document? _document;
  DocumentMetadata? _currentMetadata;
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadDocument();
  }

  Future<void> _loadDocument() async {
    try {
      final usecase = ref.read(getDocumentByIdProvider);
      final result = await usecase(widget.documentId);
      result.fold(
        (failure) {
          if (mounted) {
            _showSnackBar(failure.message, isError: true);
          }
        },
        (document) {
          if (document != null) {
            setState(() {
              _document = document;
              _currentMetadata = document.metadata;
              _isLoading = false;
            });
          }
        },
      );
    } catch (e) {
      if (mounted) {
        _showSnackBar('Error loading document: $e', isError: true);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_document == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Text('Document not found'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enable Smart Features'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        actions: [
          if (_isSaving)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.purple.shade50,
                  Colors.blue.shade50,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.auto_awesome, color: Colors.purple.shade700, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Unlock Smart Features',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'for "${_document!.title}"',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.purple.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.lightbulb, color: Colors.amber.shade600, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Add document details to enable smart reminders, intelligent search, and automatic bundle organization.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Form Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: SmartMetadataSection(
                selectedType: _document!.type,
                currentMetadata: _currentMetadata,
                onMetadataChanged: (metadata) {
                  setState(() {
                    _currentMetadata = metadata;
                  });
                },
              ),
            ),
          ),
          
          // Bottom Actions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _saveSmartFeatures,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Enable Smart Features',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveSmartFeatures() async {
    if (_currentMetadata == null) {
      _showSnackBar('Please fill in the document details first', isError: true);
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      // Update document with new metadata
      final updatedDocument = _document!.copyWith(
        metadata: _currentMetadata!,
        type: _document!.type, // Keep existing type but with smart metadata
        updatedAt: DateTime.now(),
      );

      final usecase = ref.read(updateDocumentProvider);
      final result = await usecase(updatedDocument);
      
      result.fold(
        (failure) {
          _showSnackBar(failure.message, isError: true);
        },
        (_) {
          _showSnackBar('Smart features enabled successfully!');
          Navigator.of(context).pop(updatedDocument);
        },
      );
    } catch (e) {
      _showSnackBar('Error enabling smart features: $e', isError: true);
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (mounted) {
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
}
