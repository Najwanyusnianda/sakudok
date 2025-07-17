//lib/features/documents/presentation/widgets/document_capture/document_source_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class DocumentSourceBottomSheet extends StatelessWidget {
  final Function(File file) onDocumentSelected;

  const DocumentSourceBottomSheet({
    super.key,
    required this.onDocumentSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              'Add Document to SakuDok',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose how you want to add your document',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
            const SizedBox(height: 32),

            // Camera Option
            _buildSourceOption(
              context: context,
              icon: Icons.camera_alt,
              title: 'Take Photo',
              subtitle: 'Capture document with camera',
              color: Colors.blue,
              onTap: () => _captureFromCamera(context),
            ),

            const SizedBox(height: 16),

            // File Picker Option
            _buildSourceOption(
              context: context,
              icon: Icons.folder_open,
              title: 'Choose from Storage',
              subtitle: 'Select image or PDF file',
              color: Colors.green,
              onTap: () => _pickFromStorage(context),
            ),

            const SizedBox(height: 24),

            // Cancel Button
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  /// Builds a UI option for a document source (e.g., Camera, Storage).
  Widget _buildSourceOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade400,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  /// Captures an image from the camera.
  Future<void> _captureFromCamera(BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        // Close the bottom sheet first
        if (context.mounted) {
          Navigator.of(context).pop();
        }
        // Then call the callback to navigate to next page
        onDocumentSelected(File(image.path));
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorDialog(context, 'Camera Error',
            'SakuDok needs camera permission to capture documents. Please enable camera access in your device settings.');
      }
    }
  }

  /// Picks a file from the device storage.
  Future<void> _pickFromStorage(BuildContext context) async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        // Close the bottom sheet first
        if (context.mounted) {
          Navigator.of(context).pop();
        }
        // Then call the callback to navigate to next page
        onDocumentSelected(File(result.files.single.path!));
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorDialog(context, 'Storage Access Error',
            'SakuDok needs storage permission to access your files. Please enable storage access in your device settings.');
      }
    }
  }

  /// Shows an error dialog to the user.
  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Open app settings
              // AppSettings.openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }
}
