import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/document.dart';
import '../../domain/entities/document_type.dart';
import '../../domain/entities/metadata/document_metadata.dart';
import '../providers/document_providers.dart';
import '../widgets/document_form/document_basic_info_section.dart';
import '../widgets/document_form/document_type_section.dart';
import '../widgets/document_form/smart_metadata_section.dart';

class AddEditDocumentPage extends ConsumerStatefulWidget {
  final String? documentId;

  const AddEditDocumentPage({
    super.key,
    this.documentId,
  });

  @override
  ConsumerState<AddEditDocumentPage> createState() => _AddEditDocumentPageState();
}

class _AddEditDocumentPageState extends ConsumerState<AddEditDocumentPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _tagsController;
  
  DocumentType _selectedType = DocumentType.lainnya;
  bool _isFavorite = false;
  bool _isLoading = false;
  DateTime? _expiryDate;
  List<String> _tags = [];
  DocumentMetadata? _currentMetadata;

  bool get _isEditing => widget.documentId != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _tagsController = TextEditingController();
    _loadDocument();
  }

  Future<void> _loadDocument() async {
    if (_isEditing) {
      try {
        final usecase = ref.read(getDocumentByIdProvider);
        final result = await usecase(widget.documentId!);
        result.fold(
          (failure) {
            if (mounted) {
              _showSnackBar(failure.message, isError: true);
            }
          },
          (document) {
            if (mounted && document != null) {
              _populateFields(document);
            }
          },
        );
      } catch (e) {
        if (mounted) {
          _showSnackBar('Error loading document: $e', isError: true);
        }
      }
    }
  }

  void _populateFields(Document document) {
    setState(() {
      _titleController.text = document.title;
      _descriptionController.text = document.description ?? '';
      _selectedType = document.type;
      _isFavorite = document.isFavorite;
      _expiryDate = document.expiryDate;
      _tags = document.tags;
      _tagsController.text = _tags.join(', ');
      _currentMetadata = document.metadata;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(_isEditing ? 'Edit Document' : 'Add New Document'),
      elevation: 0,
      actions: [
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          )
        else
          TextButton.icon(
            onPressed: _saveDocument,
            icon: Icon(_isEditing ? Icons.save : Icons.add),
            label: Text(_isEditing ? 'Update' : 'Save'),
          ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildBody() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Indicator for Multi-step Process
            _buildProgressIndicator(),
            const SizedBox(height: 24),

            // Step 1: Document Basic Information
            DocumentBasicInfoSection(
              titleController: _titleController,
              descriptionController: _descriptionController,
              tagsController: _tagsController,
              isFavorite: _isFavorite,
              onFavoriteChanged: (value) {
                setState(() {
                  _isFavorite = value;
                });
              },
              onTagsChanged: (tags) {
                setState(() {
                  _tags = tags;
                });
              },
            ),
            const SizedBox(height: 32),

            // Step 2: Document Type Selection
            DocumentTypeSection(
              selectedType: _selectedType,
              onTypeChanged: (type) {
                setState(() {
                  _selectedType = type;
                  // Reset metadata when type changes
                  _currentMetadata = null;
                });
              },
            ),
            const SizedBox(height: 32),

            // Step 3: Smart Metadata Collection
            SmartMetadataSection(
              selectedType: _selectedType,
              currentMetadata: _currentMetadata,
              onMetadataChanged: (metadata) {
                setState(() {
                  _currentMetadata = metadata;
                });
              },
            ),
            const SizedBox(height: 32),

            // Save Action Summary
            _buildSaveSummary(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.purple.shade50],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Icon(
            _isEditing ? Icons.edit_document : Icons.note_add,
            color: Colors.blue.shade700,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isEditing ? 'Update Document' : 'Create New Document',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _isEditing 
                    ? 'Modify your document details and smart metadata'
                    : 'Fill in the details below to create an intelligent document',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.save_alt, color: Colors.green.shade700),
              const SizedBox(width: 8),
              Text(
                'Ready to Save',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildSummaryRow('Title', _titleController.text.isEmpty ? 'Not set' : _titleController.text),
          _buildSummaryRow('Type', _getDocumentTypeDisplayName(_selectedType)),
          _buildSummaryRow('Tags', _tags.isEmpty ? 'None' : _tags.join(', ')),
          _buildSummaryRow('Smart Features', _currentMetadata != null ? 'Enabled' : 'Basic'),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _saveDocument,
              icon: Icon(_isEditing ? Icons.update : Icons.save),
              label: Text(_isEditing ? 'Update Document' : 'Save Document'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
      case DocumentType.sertifikat:
        return 'Certificate';
      case DocumentType.ijazah:
        return 'Diploma';
      case DocumentType.lainnya:
        return 'Other Documents';
    }
  }

  Future<void> _saveDocument() async {
    if (!_formKey.currentState!.validate()) {
      _showSnackBar('Please fix the errors above', isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final document = Document(
        id: widget.documentId ?? '',
        title: _titleController.text,
        description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
        type: _selectedType,
        metadata: _currentMetadata ?? const DocumentMetadata.unknown({}),
        tags: _tags,
        isFavorite: _isFavorite,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        expiryDate: _expiryDate,
      );

      if (_isEditing) {
        await _updateDocument(document);
      } else {
        await _addDocument(document);
      }
    } catch (e) {
      _showSnackBar('Error saving document: $e', isError: true);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addDocument(Document document) async {
    final usecase = ref.read(addDocumentProvider);
    final result = await usecase(document);
    result.fold(
      (failure) => _showSnackBar(failure.message, isError: true),
      (_) {
        Navigator.of(context).pop();
        _showSnackBar('Document added successfully');
      },
    );
  }

  Future<void> _updateDocument(Document document) async {
    final usecase = ref.read(updateDocumentProvider);
    final result = await usecase(document);
    result.fold(
      (failure) => _showSnackBar(failure.message, isError: true),
      (_) {
        Navigator.of(context).pop();
        _showSnackBar('Document updated successfully');
      },
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red.shade600 : Colors.green.shade600,
        ),
      );
    }
  }
}
