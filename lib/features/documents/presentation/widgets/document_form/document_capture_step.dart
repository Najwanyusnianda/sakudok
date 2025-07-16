import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class DocumentCaptureStep extends StatefulWidget {
  final File? capturedDocument;
  final ValueChanged<File?> onDocumentCaptured;
  final VoidCallback? onOCRProcessing;
  final Map<String, dynamic>? extractedData;

  const DocumentCaptureStep({
    super.key,
    required this.capturedDocument,
    required this.onDocumentCaptured,
    this.onOCRProcessing,
    this.extractedData,
  });

  @override
  State<DocumentCaptureStep> createState() => _DocumentCaptureStepState();
}

class _DocumentCaptureStepState extends State<DocumentCaptureStep>
    with TickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();
  late AnimationController _pulseController;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Step Header
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.primaryContainer.withOpacity(0.3), 
                colorScheme.secondaryContainer.withOpacity(0.3)
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorScheme.outline.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: colorScheme.onPrimary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Step 2: Capture Document',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Take a photo or upload your document for smart text extraction',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onPrimaryContainer.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Document Preview or Capture Options
        if (widget.capturedDocument != null)
          _buildDocumentPreview()
        else
          _buildCaptureOptions(),

        // OCR Processing Status
        if (_isProcessing) _buildProcessingStatus(),

        // Extracted Data Preview
        if (widget.extractedData != null && widget.extractedData!.isNotEmpty)
          _buildExtractedDataPreview(),
      ],
    );
  }

  Widget _buildCaptureOptions() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outline.withOpacity(0.3), width: 1),
        borderRadius: BorderRadius.circular(16),
        color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
      ),
      child: Column(
        children: [
          // Camera Option
          _buildCaptureOption(
            icon: Icons.camera_alt,
            title: 'Take Photo',
            subtitle: 'Use camera to capture document',
            color: colorScheme.primary,
            onTap: _captureFromCamera,
          ),
          const SizedBox(height: 16),
          
          // Gallery Option
          _buildCaptureOption(
            icon: Icons.photo_library,
            title: 'Choose from Gallery',
            subtitle: 'Select existing photo from gallery',
            color: colorScheme.secondary,
            onTap: _pickFromGallery,
          ),
          const SizedBox(height: 16),
          
          // File Picker Option
          _buildCaptureOption(
            icon: Icons.folder,
            title: 'Upload File',
            subtitle: 'Choose PDF or image file',
            color: colorScheme.tertiary,
            onTap: _pickFile,
          ),
          
          const SizedBox(height: 20),
          
          // Tips
          _buildCaptureTips(),
        ],
      ),
    );
  }

  Widget _buildCaptureOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
            color: color.withOpacity(0.05),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: color.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: color, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCaptureTips() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outline.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.tips_and_updates, 
                color: colorScheme.onSecondaryContainer,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Tips for better results:',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSecondaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...([
            '• Ensure good lighting and avoid shadows',
            '• Keep document flat and fully visible',
            '• Avoid blurry or tilted photos',
            '• Text should be clearly readable',
          ]).map((tip) => Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(
              tip,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSecondaryContainer.withOpacity(0.8),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildDocumentPreview() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade300),
        color: Colors.green.shade50,
      ),
      child: Column(
        children: [
          // Preview Header
          Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green.shade600),
              const SizedBox(width: 8),
              Text(
                'Document Captured',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () => widget.onDocumentCaptured(null),
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('Retake'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.green.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Image Preview
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.file(
                widget.capturedDocument!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Icon(
                      Icons.broken_image,
                      size: 48,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Process OCR Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isProcessing ? null : _processOCR,
              icon: _isProcessing 
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.auto_awesome),
              label: Text(_isProcessing ? 'Processing...' : 'Extract Text with AI'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingStatus() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (_pulseController.value * 0.1),
                child: Icon(
                  Icons.psychology,
                  color: Colors.blue.shade600,
                  size: 24,
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Processing Document...',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Extracting text and analyzing content',
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

  Widget _buildExtractedDataPreview() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.purple.shade50,
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: Colors.purple.shade600),
              const SizedBox(width: 8),
              Text(
                'Extracted Information',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...widget.extractedData!.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      '${entry.key}:',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      entry.value?.toString() ?? 'Not detected',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Future<void> _captureFromCamera() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        preferredCameraDevice: CameraDevice.rear,
      );
      
      if (photo != null) {
        widget.onDocumentCaptured(File(photo.path));
      }
    } catch (e) {
      _showError('Failed to capture photo: $e');
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      
      if (image != null) {
        widget.onDocumentCaptured(File(image.path));
      }
    } catch (e) {
      _showError('Failed to pick image: $e');
    }
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );

      if (result != null && result.files.single.path != null) {
        widget.onDocumentCaptured(File(result.files.single.path!));
      }
    } catch (e) {
      _showError('Failed to pick file: $e');
    }
  }

  Future<void> _processOCR() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      // Simulate OCR processing
      await Future.delayed(const Duration(seconds: 2));
      
      if (widget.onOCRProcessing != null) {
        widget.onOCRProcessing!();
      }
    } catch (e) {
      _showError('OCR processing failed: $e');
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red.shade600,
        ),
      );
    }
  }
}
