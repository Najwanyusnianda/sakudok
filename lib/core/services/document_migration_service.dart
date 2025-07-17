import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/documents/domain/entities/document.dart';
import '../../features/documents/presentation/providers/document_providers.dart';
import '../providers/file_service_provider.dart';
import '../services/file_service.dart';
import '../exceptions/file_service_exception.dart';

/// Service to migrate existing documents from external paths to app's private directory
class DocumentMigrationService {
  final FileService _fileService;
  final Ref _ref;

  DocumentMigrationService(this._fileService, this._ref);

  /// Migrate all documents to use app's private directory
  Future<DocumentMigrationResult> migrateAllDocuments() async {
    try {
      final documentsNotifier = _ref.read(documentsNotifierProvider.notifier);
      await documentsNotifier.loadDocuments();
      
      final documents = _ref.read(documentsNotifierProvider).value ?? [];
      
      int migratedCount = 0;
      int failedCount = 0;
      List<String> errors = [];

      for (final document in documents) {
        try {
          final migrated = await _migrateDocument(document);
          if (migrated) {
            migratedCount++;
          }
        } catch (e) {
          failedCount++;
          errors.add('Failed to migrate ${document.title}: $e');
        }
      }

      return DocumentMigrationResult(
        totalDocuments: documents.length,
        migratedCount: migratedCount,
        failedCount: failedCount,
        errors: errors,
      );
    } catch (e) {
      throw FileServiceException('Migration failed: $e');
    }
  }

  /// Migrate a single document
  Future<bool> _migrateDocument(Document document) async {
    if (document.filePaths.isEmpty) {
      return false; // Nothing to migrate
    }

    List<String> newFilePaths = [];
    bool needsUpdate = false;

    for (final filePath in document.filePaths) {
      final file = File(filePath);

      // Check if file is already in app's private directory
      if (await _isFileInAppDirectory(filePath)) {
        newFilePaths.add(filePath); // Keep existing path
        continue;
      }

      // Check if external file exists
      if (!await file.exists()) {
        // External file no longer exists, skip it
        continue;
      }

      try {
        // Copy to app's private directory
        final newPath = await _fileService.copyFileToAppDirectory(
          sourceFile: file,
          documentType: document.type,
        );
        newFilePaths.add(newPath);
        needsUpdate = true;
      } catch (e) {
        // If copy fails, skip this file
        continue;
      }
    }

    // Update document if needed
    if (needsUpdate && newFilePaths.isNotEmpty) {
      final updatedDocument = document.copyWith(
        filePaths: newFilePaths,
        updatedAt: DateTime.now(),
      );

      final notifier = _ref.read(documentsNotifierProvider.notifier);
      await notifier.updateDocument(updatedDocument);
      return true;
    }

    return false;
  }

  /// Check if file is already in app's private directory
  Future<bool> _isFileInAppDirectory(String filePath) async {
    try {
      // Check if path contains the app's documents directory
      final appDir = await _fileService.getDocumentsDirectory();
      return filePath.startsWith(appDir.path);
    } catch (e) {
      return false;
    }
  }

  /// Clean up orphaned files after migration
  Future<List<String>> cleanupOrphanedFiles() async {
    try {
      final documents = _ref.read(documentsNotifierProvider).value ?? [];
      final referencedFiles = documents
          .expand((doc) => doc.filePaths)
          .toList();

      return await _fileService.cleanupOrphanedFiles(referencedFiles);
    } catch (e) {
      throw FileServiceException('Cleanup failed: $e');
    }
  }
}

class DocumentMigrationResult {
  final int totalDocuments;
  final int migratedCount;
  final int failedCount;
  final List<String> errors;

  DocumentMigrationResult({
    required this.totalDocuments,
    required this.migratedCount,
    required this.failedCount,
    required this.errors,
  });

  bool get hasErrors => errors.isNotEmpty;
  bool get allMigrated => failedCount == 0;
  double get successRate => totalDocuments > 0 ? migratedCount / totalDocuments : 0.0;
}

/// Provider for DocumentMigrationService
final documentMigrationServiceProvider = Provider<DocumentMigrationService>((ref) {
  final fileService = ref.read(fileServiceProvider);
  return DocumentMigrationService(fileService, ref);
});
