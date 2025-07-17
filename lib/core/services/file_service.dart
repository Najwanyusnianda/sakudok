import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../../features/documents/domain/entities/document_type.dart';
import '../exceptions/file_service_exception.dart';

class FileService {
  static const String _documentsFolder = 'documents';
  static const String _imagesFolder = 'images';
  static const String _pdfsFolder = 'pdfs';

  /// Get the app's private documents directory (public method for migration)
  Future<Directory> getDocumentsDirectory() async {
    return await _getDocumentsDirectory();
  }

  /// Get the app's private documents directory
  Future<Directory> _getDocumentsDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final documentsDir = Directory(path.join(appDir.path, _documentsFolder));
    if (!await documentsDir.exists()) {
      await documentsDir.create(recursive: true);
    }
    return documentsDir;
  }

  /// Get the directory for a specific document type
  Future<Directory> _getTypeDirectory(DocumentType type) async {
    final documentsDir = await _getDocumentsDirectory();
    final typeFolder = _getTypeFolderName(type);
    final typeDir = Directory(path.join(documentsDir.path, typeFolder));
    if (!await typeDir.exists()) {
      await typeDir.create(recursive: true);
    }
    return typeDir;
  }

  /// Get the images subdirectory for a document type
  Future<Directory> _getImagesDirectory(DocumentType type) async {
    final typeDir = await _getTypeDirectory(type);
    final imagesDir = Directory(path.join(typeDir.path, _imagesFolder));
    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }
    return imagesDir;
  }

  /// Get the PDFs subdirectory for a document type
  Future<Directory> _getPdfsDirectory(DocumentType type) async {
    final typeDir = await _getTypeDirectory(type);
    final pdfsDir = Directory(path.join(typeDir.path, _pdfsFolder));
    if (!await pdfsDir.exists()) {
      await pdfsDir.create(recursive: true);
    }
    return pdfsDir;
  }

  /// Get folder name for document type
  String _getTypeFolderName(DocumentType type) {
    switch (type) {
      case DocumentType.ktp:
        return 'identity_cards';
      case DocumentType.sim:
        return 'driving_licenses';
      case DocumentType.passport:
        return 'passports';
      case DocumentType.ijazah:
        return 'diplomas';
      case DocumentType.sertifikat:
        return 'certificates';
      case DocumentType.lainnya:
        return 'others';
    }
  }

  /// Copy a file to the app's private directory
  Future<String> copyFileToAppDirectory({
    required File sourceFile,
    required DocumentType documentType,
    String? customFileName,
  }) async {
    try {
      // Validate source file exists
      if (!await sourceFile.exists()) {
        throw FileServiceException('Source file does not exist: ${sourceFile.path}');
      }

      // Get file extension
      final extension = path.extension(sourceFile.path).toLowerCase();
      
      // Determine destination directory based on file type
      Directory destDir;
      if (_isImageFile(extension)) {
        destDir = await _getImagesDirectory(documentType);
      } else if (_isPdfFile(extension)) {
        destDir = await _getPdfsDirectory(documentType);
      } else {
        throw FileServiceException('Unsupported file type: $extension');
      }

      // Generate unique filename
      final fileName = customFileName ?? _generateUniqueFileName(extension);
      final destPath = path.join(destDir.path, fileName);

      // Copy the file
      final destFile = await sourceFile.copy(destPath);
      
      // Verify the copy was successful
      if (!await destFile.exists()) {
        throw FileServiceException('Failed to copy file to: $destPath');
      }

      return destFile.path;
    } catch (e) {
      throw FileServiceException('Error copying file: $e');
    }
  }

  /// Save file data to the app's private directory
  Future<String> saveFileData({
    required Uint8List data,
    required DocumentType documentType,
    required String extension,
    String? customFileName,
  }) async {
    try {
      // Determine destination directory based on file type
      Directory destDir;
      if (_isImageFile(extension)) {
        destDir = await _getImagesDirectory(documentType);
      } else if (_isPdfFile(extension)) {
        destDir = await _getPdfsDirectory(documentType);
      } else {
        throw FileServiceException('Unsupported file type: $extension');
      }

      // Generate unique filename
      final fileName = customFileName ?? _generateUniqueFileName(extension);
      final destPath = path.join(destDir.path, fileName);

      // Write the file
      final file = File(destPath);
      await file.writeAsBytes(data);

      return destPath;
    } catch (e) {
      throw FileServiceException('Error saving file data: $e');
    }
  }

  /// Delete a file from the app's directory
  Future<bool> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      throw FileServiceException('Error deleting file: $e');
    }
  }

  /// Check if a file exists in the app's directory
  Future<bool> fileExists(String filePath) async {
    try {
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  /// Get file size in bytes
  Future<int> getFileSize(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        return await file.length();
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  /// Get all files for a specific document type
  Future<List<String>> getFilesForType(DocumentType type) async {
    try {
      final typeDir = await _getTypeDirectory(type);
      final List<String> allFiles = [];

      // Get images
      final imagesDir = Directory(path.join(typeDir.path, _imagesFolder));
      if (await imagesDir.exists()) {
        final imageFiles = await imagesDir.list().where((entity) => entity is File).cast<File>().map((file) => file.path).toList();
        allFiles.addAll(imageFiles);
      }

      // Get PDFs
      final pdfsDir = Directory(path.join(typeDir.path, _pdfsFolder));
      if (await pdfsDir.exists()) {
        final pdfFiles = await pdfsDir.list().where((entity) => entity is File).cast<File>().map((file) => file.path).toList();
        allFiles.addAll(pdfFiles);
      }

      return allFiles;
    } catch (e) {
      throw FileServiceException('Error getting files for type: $e');
    }
  }

  /// Clean up orphaned files (files not referenced by any document)
  Future<List<String>> cleanupOrphanedFiles(List<String> referencedFiles) async {
    try {
      final documentsDir = await _getDocumentsDirectory();
      final List<String> deletedFiles = [];

      await for (final entity in documentsDir.list(recursive: true)) {
        if (entity is File && !referencedFiles.contains(entity.path)) {
          await entity.delete();
          deletedFiles.add(entity.path);
        }
      }

      return deletedFiles;
    } catch (e) {
      throw FileServiceException('Error cleaning up orphaned files: $e');
    }
  }

  /// Get total storage used by the app
  Future<int> getTotalStorageUsed() async {
    try {
      final documentsDir = await _getDocumentsDirectory();
      int totalSize = 0;

      await for (final entity in documentsDir.list(recursive: true)) {
        if (entity is File) {
          final size = await entity.length();
          totalSize += size;
        }
      }

      return totalSize;
    } catch (e) {
      return 0;
    }
  }

  /// Move file from one document type to another
  Future<String> moveFileToType({
    required String currentPath,
    required DocumentType newType,
  }) async {
    try {
      final currentFile = File(currentPath);
      if (!await currentFile.exists()) {
        throw FileServiceException('Source file does not exist: $currentPath');
      }

      // Get file extension and determine new directory
      final extension = path.extension(currentPath).toLowerCase();
      Directory destDir;
      if (_isImageFile(extension)) {
        destDir = await _getImagesDirectory(newType);
      } else if (_isPdfFile(extension)) {
        destDir = await _getPdfsDirectory(newType);
      } else {
        throw FileServiceException('Unsupported file type: $extension');
      }

      // Generate new path
      final fileName = path.basename(currentPath);
      final newPath = path.join(destDir.path, fileName);

      // Move the file
      final newFile = await currentFile.rename(newPath);
      return newFile.path;
    } catch (e) {
      throw FileServiceException('Error moving file: $e');
    }
  }

  /// Generate a unique filename with timestamp and random suffix
  String _generateUniqueFileName(String extension) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = DateTime.now().microsecond;
    return 'doc_${timestamp}_$random$extension';
  }

  /// Check if file extension is an image
  bool _isImageFile(String extension) {
    const imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];
    return imageExtensions.contains(extension.toLowerCase());
  }

  /// Check if file extension is a PDF
  bool _isPdfFile(String extension) {
    return extension.toLowerCase() == '.pdf';
  }

  /// Get file extension from file path
  String getFileExtension(String filePath) {
    return path.extension(filePath).toLowerCase();
  }

  /// Get file name without extension
  String getFileNameWithoutExtension(String filePath) {
    return path.basenameWithoutExtension(filePath);
  }

  /// Format file size for display
  String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}
