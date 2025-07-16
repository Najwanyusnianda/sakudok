import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../../domain/entities/document.dart';
import '../../domain/entities/document_type.dart';
import '../../domain/entities/metadata/document_metadata.dart';
import '../providers/document_providers.dart';
import '../widgets/document_form/document_type_selection_step.dart';
import '../widgets/document_form/document_capture_step.dart';
import '../widgets/document_form/document_basic_info_section.dart';
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
  final _pageController = PageController();
  
  // Controllers
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _tagsController;
  
  // Form State
  DocumentType _selectedType = DocumentType.ktp;
  File? _capturedDocument;
  Map<String, dynamic>? _extractedData;
  bool _isFavorite = false;
  bool _isLoading = false;
  DateTime? _expiryDate;
  List<String> _tags = [];
  DocumentMetadata? _currentMetadata;
  
  // Flow State
  int _currentStep = 0;
  final int _totalSteps = 4;

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
    _pageController.dispose();
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
    return Column(
      children: [
        // Progress Indicator
        _buildProgressIndicator(),
        
        // Form Content
        Expanded(
          child: Form(
            key: _formKey,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentStep = index;
                });
              },
              children: [
                // Step 1: Document Type Selection
                _buildStepWrapper(
                  DocumentTypeSelectionStep(
                    selectedType: _selectedType,
                    onTypeChanged: (type) {
                      setState(() {
                        _selectedType = type;
                        // Reset subsequent steps when type changes
                        _capturedDocument = null;
                        _extractedData = null;
                        _currentMetadata = null;
                      });
                    },
                  ),
                ),
                
                // Step 2: Document Capture
                _buildStepWrapper(
                  DocumentCaptureStep(
                    capturedDocument: _capturedDocument,
                    extractedData: _extractedData,
                    onDocumentCaptured: (file) {
                      setState(() {
                        _capturedDocument = file;
                        if (file == null) {
                          _extractedData = null;
                        }
                      });
                    },
                    onOCRProcessing: _processOCRData,
                  ),
                ),
                
                // Step 3: Basic Information (Auto-populated)
                _buildStepWrapper(
                  DocumentBasicInfoSection(
                    titleController: _titleController,
                    descriptionController: _descriptionController,
                    tagsController: _tagsController,
                    isFavorite: _isFavorite,
                    extractedData: _extractedData,
                    isAutoPopulated: _extractedData != null,
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
                ),
                
                // Step 4: Smart Metadata
                _buildStepWrapper(
                  SmartMetadataSection(
                    selectedType: _selectedType,
                    currentMetadata: _currentMetadata,
                    onMetadataChanged: (metadata) {
                      setState(() {
                        _currentMetadata = metadata;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepWrapper(Widget child) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Progress Bar
          Row(
            children: List.generate(_totalSteps, (index) {
              final isCompleted = index < _currentStep;
              final isCurrent = index == _currentStep;
              
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(
                    right: index < _totalSteps - 1 ? 8 : 0,
                  ),
                  decoration: BoxDecoration(
                    color: isCompleted || isCurrent 
                      ? Colors.blue.shade600 
                      : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
          
          // Step Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step ${_currentStep + 1} of $_totalSteps',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              Text(
                _getStepTitle(_currentStep),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
        ],
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
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Previous Button
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _previousStep,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Previous'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          
          if (_currentStep > 0) const SizedBox(width: 16),
          
          // Next/Save Button
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _handleNextStep,
              icon: Icon(_currentStep == _totalSteps - 1 
                ? (_isEditing ? Icons.save : Icons.add)
                : Icons.arrow_forward),
              label: Text(_currentStep == _totalSteps - 1 
                ? (_isEditing ? 'Update' : 'Save')
                : 'Next'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 0:
        return 'Document Type';
      case 1:
        return 'Capture Document';
      case 2:
        return 'Basic Information';
      case 3:
        return 'Smart Metadata';
      default:
        return 'Unknown';
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _handleNextStep() {
    if (_currentStep < _totalSteps - 1) {
      // Validate current step
      if (_validateCurrentStep()) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      // Final step - save document
      _saveDocument();
    }
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        // Document type is always valid (has default)
        return true;
      case 1:
        // Document capture - require document for new documents
        if (!_isEditing && _capturedDocument == null) {
          _showSnackBar('Please capture or upload a document', isError: true);
          return false;
        }
        return true;
      case 2:
        // Basic information validation
        return _formKey.currentState?.validate() ?? false;
      case 3:
        // Smart metadata is optional
        return true;
      default:
        return true;
    }
  }

  Future<void> _processOCRData() async {
    // Simulate OCR processing and extract data
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _extractedData = {
        'title': '${_getDocumentTypeDisplayName(_selectedType)} Document',
        'description': 'Auto-extracted description from document',
        'issueDate': DateTime.now().toString(),
        'expiryDate': DateTime.now().add(const Duration(days: 365)).toString(),
      };
      
      // Auto-populate form fields
      if (_extractedData != null) {
        _titleController.text = _extractedData!['title'] ?? '';
        _descriptionController.text = _extractedData!['description'] ?? '';
        
        // Auto-suggest tags based on document type
        final suggestedTags = _getSuggestedTags(_selectedType);
        _tags = suggestedTags;
        _tagsController.text = suggestedTags.join(', ');
      }
    });
  }

  List<String> _getSuggestedTags(DocumentType type) {
    switch (type) {
      case DocumentType.ktp:
        return ['identity', 'personal', 'official'];
      case DocumentType.sim:
        return ['license', 'driving', 'official'];
      case DocumentType.passport:
        return ['travel', 'identity', 'international'];
      case DocumentType.sertifikat:
        return ['certificate', 'achievement', 'professional'];
      case DocumentType.ijazah:
        return ['education', 'academic', 'achievement'];
      case DocumentType.lainnya:
        return ['document', 'general'];
    }
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
