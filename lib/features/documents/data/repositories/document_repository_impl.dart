// lib/features/documents/data/repositories/document_repository_impl.dart
import 'package:flutter/foundation.dart'; // Import for debugPrint
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/document.dart';
import '../../domain/repositories/document_repository.dart';
import '../datasources/document_local_datasource.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../mappers/document_mapper.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final DocumentLocalDataSource _dataSource;

  DocumentRepositoryImpl(this._dataSource);

  @override
  Future<Either<AppException, List<Document>>> getAllDocuments() async {
    try {
      final dbDocs = await _dataSource.getAllDocuments();
      
      // --- START DEBUGGING ---
      debugPrint("DEBUG: Found ${dbDocs.length} documents in the database. Inspecting each one before mapping...");
      
      final documents = dbDocs.map((doc) {
        try {
          // Print the raw database object before it gets mapped.
          // This helps you see the exact data coming from the database.
          debugPrint("DEBUG: Mapping document with ID: ${doc.id}, Title: ${doc.title}");
          debugPrint("  - Raw tags from DB: ${doc.tags}");
          debugPrint("  - Raw filePaths from DB: ${doc.filePaths}");
          debugPrint("  - Raw metadata from DB: ${doc.metadata}");
          
          // The actual mapping happens here. If a field is null in the DB but
          // non-nullable in the mapper, the error will happen here.
          return DocumentMapper.fromDb(doc);

        } catch (e, stackTrace) {
          // This will catch an error for a single problematic document.
          debugPrint("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
          debugPrint("ERROR: FAILED TO MAP DOCUMENT WITH ID: ${doc.id}.");
          debugPrint("  - This is likely the record with a NULL value in a required field.");
          debugPrint("  - Error: $e");
          debugPrint("  - StackTrace: $stackTrace");
          debugPrint("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
          // Re-throw the error so the UI knows something went wrong.
          throw e;
        }
      }).toList();
      
      debugPrint("DEBUG: Successfully mapped all documents.");
      // --- END DEBUGGING ---

      return right(documents);
    } catch (e) {
      // This will catch the error from the mapping block above.
      return left(AppException('Failed to get documents: $e'));
    }
  }

  @override
  Future<Either<AppException, Document?>> getDocumentById(String id) async {
    try {
      final dbDoc = await _dataSource.getDocumentById(id);
      if (dbDoc == null) {
        return right(null);
      }
      return right(DocumentMapper.fromDb(dbDoc));
    } catch (e) {
      return left(AppException('Failed to get document: $e'));
    }
  }

  @override
  Future<Either<AppException, List<Document>>> searchDocuments(String query) async {
    try {
      final dbDocs = await _dataSource.searchDocuments(query);
      final documents = dbDocs.map((doc) => DocumentMapper.fromDb(doc)).toList();
      return right(documents);
    } catch (e) {
      return left(AppException('Failed to search documents: $e'));
    }
  }

  @override
  Future<Either<AppException, Unit>> addDocument(Document document) async {
    try {
      final companion = DocumentMapper.toDb(document);
      await _dataSource.addDocument(companion);
      return right(unit);
    } catch (e) {
      return left(AppException('Failed to add document: $e'));
    }
  }

  @override
  Future<Either<AppException, Unit>> updateDocument(Document document) async {
    try {
      final companion = DocumentMapper.toDb(document);
      await _dataSource.updateDocument(companion);
      return right(unit);
    } catch (e) {
      return left(AppException('Failed to update document: $e'));
    }
  }

  @override
  Future<Either<AppException, Unit>> deleteDocument(String id) async {
    try {
      await _dataSource.deleteDocument(id);
      return right(unit);
    } catch (e) {
      return left(AppException('Failed to delete document: $e'));
    }
  }
}
