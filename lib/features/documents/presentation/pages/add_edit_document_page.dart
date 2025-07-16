// lib/features/documents/presentation/pages/add_edit_document_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/document.dart';
import '../../domain/entities/document_type.dart';
import '../../domain/entities/metadata/document_metadata.dart';
import '../providers/document_providers.dart';
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
  
  // Controllers
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _tagsController;
  
  // Form State
  DocumentType _selectedType = DocumentType.ktp;
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
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(_isEditing ? 'Edit Document' : 'Add New Document'),
      elevation: 0,
      centerTitle: true,
      actions: [
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
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
            // Document Type Section
            _buildDocumentTypeSection(),
            const SizedBox(height: 24),
            
            // Basic Information Section
            _buildBasicInfoSection(),
            const SizedBox(height: 24),
            
            // Smart Metadata Section
            _buildSmartMetadataSection(),
            const SizedBox(height: 80), // Space for bottom button
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentTypeSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Document Type',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<DocumentType>(
              value: _selectedType,
              decoration: const InputDecoration(
                labelText: 'Select Document Type',
                border: OutlineInputBorder(),
              ),
              items: DocumentType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(_getDocumentTypeDisplayName(type)),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedType = value;
                    _currentMetadata = null; // Reset metadata when type changes
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Information',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Title Field
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Document Title *',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a document title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Description Field
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (Optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            
            // Tags Field
            TextFormField(
              controller: _tagsController,
              decoration: const InputDecoration(
                labelText: 'Tags (comma separated)',
                border: OutlineInputBorder(),
                hintText: 'e.g., important, personal, work',
              ),
              onChanged: (value) {
                _tags = value.split(',').map((tag) => tag.trim()).where((tag) => tag.isNotEmpty).toList();
              },
            ),
            const SizedBox(height: 16),
            
            // Favorite Toggle
            SwitchListTile(
              title: const Text('Mark as Favorite'),
              subtitle: const Text('Add to favorites for quick access'),
              value: _isFavorite,
              onChanged: (value) {
                setState(() {
                  _isFavorite = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmartMetadataSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.auto_awesome, color: Colors.purple.shade600, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Smart Features',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Add intelligent metadata specific to your document type',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            SmartMetadataSection(
              selectedType: _selectedType,
              currentMetadata: _currentMetadata,
              onMetadataChanged: (metadata) {
                setState(() {
                  _currentMetadata = metadata;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: _isLoading ? null : _saveDocument,
        icon: Icon(_isEditing ? Icons.save : Icons.add),
        label: Text(_isEditing ? 'Update Document' : 'Save Document'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade600,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          minimumSize: const Size(double.infinity, 50),
        ),
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
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }
}
