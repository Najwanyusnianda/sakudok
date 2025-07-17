// lib/features/documents/data/datasources/document_local_datasource.dart
import 'package:flutter/foundation.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/exceptions/database_exception.dart';

abstract class DocumentLocalDataSource {
  Future<List<DriftDocument>> getAllDocuments();
  Future<DriftDocument?> getDocumentById(String id);
  Future<List<DriftDocument>> searchDocuments(String query);
  Future<void> addDocument(DocumentsCompanion document);
  Future<void> updateDocument(DocumentsCompanion document);
  Future<void> deleteDocument(String id);
}

class DocumentLocalDataSourceImpl implements DocumentLocalDataSource {
  final AppDatabase _database;

  DocumentLocalDataSourceImpl(this._database);

  @override
  Future<List<DriftDocument>> getAllDocuments() async {
    // --- START DEBUGGING ---
    try {
      debugPrint("--- DATASOURCE: Calling _database.getAllDocuments() ---");
      final result = await _database.getAllDocuments();
      debugPrint("--- DATASOURCE: Successfully retrieved ${result.length} documents from the database. ---");
      return result;
    } catch (e, stackTrace) {
      // This will catch any error that happens during the database query itself.
      debugPrint("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      debugPrint("CRITICAL ERROR: FAILED TO GET DOCUMENTS FROM DATABASE.");
      debugPrint("The error is in your Drift/database query logic.");
      debugPrint("Error: $e");
      debugPrint("StackTrace: $stackTrace");
      debugPrint("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      // Re-throw the error as a specific exception.
      throw DatabaseException('Failed to get documents from datasource: $e');
    }
    // --- END DEBUGGING ---
  }

  @override
  Future<DriftDocument?> getDocumentById(String id) async {
    final docId = int.tryParse(id);
    if (docId == null) return null;
    try {
      return await _database.getDocumentById(docId);
    } catch (e) {
      throw DatabaseException('Failed to get document: $e');
    }
  }

  @override
  Future<List<DriftDocument>> searchDocuments(String query) async {
    try {
      return await _database.searchDocuments(query);
    } catch (e) {
      throw DatabaseException('Failed to search documents: $e');
    }
  }

  @override
  Future<void> addDocument(DocumentsCompanion document) async {
    try {
      debugPrint("--- DATASOURCE: Inserting document into database... ---");
      await _database.insertDocument(document);
      debugPrint("--- DATASOURCE: Document inserted successfully. ---");
    } catch (e) {
      throw DatabaseException('Failed to add document: $e');
    }
  }

  @override
  Future<void> updateDocument(DocumentsCompanion document) async {
    try {
      await _database.updateDocument(document);
    } catch (e) {
      throw DatabaseException('Failed to update document: $e');
    }
  }

  @override
  Future<void> deleteDocument(String id) async {
    final docId = int.tryParse(id);
    if (docId == null) return;
    try {
      await _database.deleteDocument(docId);
    } catch (e) {
      throw DatabaseException('Failed to delete document: $e');
    }
  }
}
