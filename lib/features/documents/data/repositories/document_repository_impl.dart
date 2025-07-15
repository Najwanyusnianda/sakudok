import 'package:fpdart/fpdart.dart';
import '../../domain/entities/document.dart' as domain;
import '../../domain/repositories/document_repository.dart';
import '../datasources/document_local_datasource.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final DocumentLocalDataSource localDataSource;

  const DocumentRepositoryImpl(this.localDataSource);

  @override
  Future<Either<String, List<domain.Document>>> getAllDocuments() async {
    return await localDataSource.getAllDocuments();
  }

  @override
  Future<Either<String, domain.Document>> getDocumentById(int id) async {
    return await localDataSource.getDocumentById(id);
  }

  @override
  Future<Either<String, domain.Document>> addDocument(domain.Document document) async {
    return await localDataSource.addDocument(document);
  }

  @override
  Future<Either<String, domain.Document>> updateDocument(domain.Document document) async {
    return await localDataSource.updateDocument(document);
  }

  @override
  Future<Either<String, bool>> deleteDocument(int id) async {
    return await localDataSource.deleteDocument(id);
  }

  @override
  Future<Either<String, List<domain.Document>>> searchDocuments(String query) async {
    return await localDataSource.searchDocuments(query);
  }

  @override
  Future<Either<String, List<domain.Document>>> getDocumentsByType(String type) async {
    return await localDataSource.getDocumentsByType(type);
  }

  @override
  Future<Either<String, List<domain.Document>>> getDocumentsByTag(String tag) async {
    // Implementation for tag-based search
    final allDocuments = await localDataSource.getAllDocuments();
    return allDocuments.map((documents) {
      return documents.where((doc) => 
        doc.tags?.contains(tag) == true
      ).toList();
    });
  }

  @override
  Future<Either<String, List<domain.Document>>> getExpiringDocuments(int daysThreshold) async {
    return await localDataSource.getExpiringDocuments(daysThreshold);
  }

  @override
  Future<Either<String, List<domain.Document>>> getDocumentsByBundle(int bundleId) async {
    // This would need to be implemented in the data source
    // For now, return empty list
    return right([]);
  }

  @override
  Future<Either<String, bool>> addDocumentToBundle(int documentId, int bundleId) async {
    // This would need to be implemented in the data source
    // For now, return success
    return right(true);
  }

  @override
  Future<Either<String, bool>> removeDocumentFromBundle(int documentId, int bundleId) async {
    // This would need to be implemented in the data source
    // For now, return success
    return right(true);
  }

  @override
  Future<Either<String, List<domain.Document>>> getDocumentsWithReminders() async {
    // This would need to be implemented in the data source
    // For now, return empty list
    return right([]);
  }

  @override
  Future<Either<String, bool>> setDocumentReminder(int documentId, DateTime reminderDate, String? note) async {
    // This would need to be implemented in the data source
    // For now, return success
    return right(true);
  }

  @override
  Future<Either<String, bool>> removeDocumentReminder(int documentId) async {
    // This would need to be implemented in the data source
    // For now, return success
    return right(true);
  }

  @override
  Future<Either<String, String>> exportDocuments() async {
    // This would need to be implemented
    // For now, return empty string
    return right('');
  }

  @override
  Future<Either<String, bool>> importDocuments(String backupData) async {
    // This would need to be implemented
    // For now, return success
    return right(true);
  }

  @override
  Future<Either<String, Map<String, int>>> getDocumentTypeStatistics() async {
    final documents = await localDataSource.getAllDocuments();
    return documents.map((docList) {
      final stats = <String, int>{};
      for (final doc in docList) {
        stats[doc.type] = (stats[doc.type] ?? 0) + 1;
      }
      return stats;
    });
  }

  @override
  Future<Either<String, int>> getTotalDocuments() async {
    final documents = await localDataSource.getAllDocuments();
    return documents.map((docList) => docList.length);
  }

  @override
  Future<Either<String, int>> getExpiredDocumentsCount() async {
    final documents = await localDataSource.getAllDocuments();
    return documents.map((docList) {
      return docList.where((doc) {
        final schema = doc.schema;
        if (schema == null || !schema.hasExpiry) return false;
        
        final expiryDate = doc.getField<DateTime>('berlakuHingga');
        return expiryDate != null && expiryDate.isBefore(DateTime.now());
      }).length;
    });
  }
}
