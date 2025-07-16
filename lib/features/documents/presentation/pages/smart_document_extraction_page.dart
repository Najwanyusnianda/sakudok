import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../../domain/entities/document_type.dart';
import '../../domain/entities/metadata/document_metadata.dart';
import '../../domain/usecases/extract_text_and_metadata.dart';
import '../widgets/document_form/smart_metadata_section.dart';

class SmartDocumentExtractionPage extends ConsumerStatefulWidget {
  final File? documentFile;
  final String? existingDocumentId;
  final String? initialTitle;

  const SmartDocumentExtractionPage({
    super.key,
    this.documentFile,
    this.existingDocumentId,
    this.initialTitle,
  });

  @override
  ConsumerState<SmartDocumentExtractionPage> createState() => _SmartDocumentExtractionPageState();
}

class _SmartDocumentExtractionPageState extends ConsumerState<SmartDocumentExtractionPage> {
  DocumentType? _selectedType;
  DocumentMetadata? _extractedMetadata;
  DocumentMetadata? _currentMetadata;
  ExtractedDocumentData? _extractionResult;
  bool _isExtracting = false;
  String? _extractionError;
  int _currentStep = 0; // 0: Type Selection, 1: Extraction, 2: Verification

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Document Features'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          // Progress Indicator
          _buildProgressIndicator(),
          
          // Content
          Expanded(
            child: _buildCurrentStep(),
          ),
          
          // Bottom Actions
          if (_currentStep > 0) _buildBottomActions(),
        ],
      ),
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
      child: Row(
        children: [
          _buildStepIndicator(0, 'Type', _currentStep >= 0),
          _buildStepConnector(_currentStep >= 1),
          _buildStepIndicator(1, 'Extract', _currentStep >= 1),
          _buildStepConnector(_currentStep >= 2),
          _buildStepIndicator(2, 'Verify', _currentStep >= 2),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step, String label, bool isActive) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isActive ? Colors.blue.shade600 : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${step + 1}',
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? Colors.blue.shade600 : Colors.grey.shade600,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepConnector(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 20),
        color: isActive ? Colors.blue.shade600 : Colors.grey.shade300,
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildTypeSelectionStep();
      case 1:
        return _buildExtractionStep();
      case 2:
        return _buildVerificationStep();
      default:
        return Container();
    }
  }

  Widget _buildTypeSelectionStep() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Choose Document Type',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select the type for intelligent data extraction and smart features',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 32),
          
          // Document Types
          Expanded(
            child: ListView.builder(
              itemCount: DocumentType.values.length,
              itemBuilder: (context, index) {
                final type = DocumentType.values[index];
                return _buildTypeCard(type);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeCard(DocumentType type) {
    final config = _getTypeConfig(type);
    final isSelected = _selectedType == type;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedType = type;
          });
          _startExtraction();
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? config.color.shade50 : Colors.white,
            border: Border.all(
              color: isSelected ? config.color.shade300 : Colors.grey.shade200,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: config.color.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  config.icon,
                  color: config.color.shade700,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      config.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      config.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              if (config.hasSmartFeatures) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Smart OCR',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.shade400,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExtractionStep() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isExtracting) ...[
            // Loading State
            const CircularProgressIndicator(strokeWidth: 3),
            const SizedBox(height: 24),
            Text(
              'Analyzing Document...',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Using intelligent OCR to extract data from your ${_getTypeConfig(_selectedType!).title}',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 32),
            LinearProgressIndicator(
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
            ),
          ] else if (_extractionError != null) ...[
            // Error State
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.orange.shade600,
            ),
            const SizedBox(height: 24),
            Text(
              'Automatic Detection Failed',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Don\'t worry! You can still add the details manually to enable smart features.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _currentStep = 2;
                  _extractionError = null;
                });
              },
              icon: const Icon(Icons.edit),
              label: const Text('Enter Details Manually'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVerificationStep() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(Icons.verified, color: Colors.green.shade600),
              const SizedBox(width: 8),
              Text(
                'Verify Information',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          if (_extractionResult?.hasHighConfidence == true) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green.shade600, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Great! We detected your data with ${(_extractionResult!.confidence * 100).toInt()}% confidence. Please review and edit if needed.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue.shade600, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Please fill in the details below to enable smart features like reminders and intelligent organization.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          const SizedBox(height: 16),
          
          // Metadata Form
          Expanded(
            child: SmartMetadataSection(
              selectedType: _selectedType!,
              currentMetadata: _currentMetadata ?? _extractedMetadata,
              onMetadataChanged: (metadata) {
                setState(() {
                  _currentMetadata = metadata;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
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
          if (_currentStep > 0)
            TextButton(
              onPressed: () {
                setState(() {
                  _currentStep--;
                });
              },
              child: const Text('Back'),
            ),
          const Spacer(),
          ElevatedButton(
            onPressed: _currentStep == 2 ? _saveChanges : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  void _startExtraction() async {
    if (widget.documentFile == null) return;
    
    setState(() {
      _currentStep = 1;
      _isExtracting = true;
      _extractionError = null;
    });

    try {
      // Create extraction use case
      final extractionUseCase = ExtractTextAndMetadataUseCase();
      final result = await extractionUseCase(
        widget.documentFile!.path,
        _selectedType!,
      );

      result.fold(
        (failure) {
          setState(() {
            _isExtracting = false;
            _extractionError = failure.message;
          });
        },
        (extractedData) {
          setState(() {
            _isExtracting = false;
            _extractionResult = extractedData;
            _extractedMetadata = extractedData.metadata;
            _currentStep = 2;
          });
        },
      );
    } catch (e) {
      setState(() {
        _isExtracting = false;
        _extractionError = 'Failed to process document: $e';
      });
    }
  }

  void _saveChanges() async {
    // Save the updated document with smart metadata
    // Implementation depends on whether this is a new document or updating existing
    Navigator.of(context).pop(_currentMetadata);
  }

  _TypeConfig _getTypeConfig(DocumentType type) {
    switch (type) {
      case DocumentType.ktp:
        return _TypeConfig(
          title: 'KTP',
          description: 'Indonesian Identity Card',
          icon: Icons.badge,
          color: Colors.blue,
          hasSmartFeatures: true,
        );
      case DocumentType.sim:
        return _TypeConfig(
          title: 'SIM',
          description: 'Driver License',
          icon: Icons.drive_eta,
          color: Colors.green,
          hasSmartFeatures: true,
        );
      case DocumentType.passport:
        return _TypeConfig(
          title: 'Passport',
          description: 'Travel Document',
          icon: Icons.flight,
          color: Colors.purple,
          hasSmartFeatures: true,
        );
      case DocumentType.sertifikat:
        return _TypeConfig(
          title: 'Certificate',
          description: 'Professional Certification',
          icon: Icons.workspace_premium,
          color: Colors.amber,
          hasSmartFeatures: true,
        );
      case DocumentType.ijazah:
        return _TypeConfig(
          title: 'Diploma',
          description: 'Education Certificate',
          icon: Icons.school,
          color: Colors.indigo,
          hasSmartFeatures: true,
        );
      case DocumentType.lainnya:
        return _TypeConfig(
          title: 'Other',
          description: 'General Document',
          icon: Icons.description,
          color: Colors.grey,
          hasSmartFeatures: false,
        );
    }
  }
}

class _TypeConfig {
  final String title;
  final String description;
  final IconData icon;
  final MaterialColor color;
  final bool hasSmartFeatures;

  _TypeConfig({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.hasSmartFeatures,
  });
}
