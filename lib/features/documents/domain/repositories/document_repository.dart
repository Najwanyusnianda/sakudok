import 'package:fpdart/fpdart.dart';
import '../entities/document.dart';

abstract class DocumentRepository {
  // CRUD Operations
  Future<Either<String, List<Document>>> getAllDocuments();
  Future<Either<String, Document>> getDocumentById(int id);
  Future<Either<String, Document>> addDocument(Document document);
  Future<Either<String, Document>> updateDocument(Document document);
  Future<Either<String, bool>> deleteDocument(int id);
  
  // Search & Filter
  Future<Either<String, List<Document>>> searchDocuments(String query);
  Future<Either<String, List<Document>>> getDocumentsByType(String type);
  Future<Either<String, List<Document>>> getDocumentsByTag(String tag);
  Future<Either<String, List<Document>>> getExpiringDocuments(int daysThreshold);
  
  // Bundle Operations
  Future<Either<String, List<Document>>> getDocumentsByBundle(int bundleId);
  Future<Either<String, bool>> addDocumentToBundle(int documentId, int bundleId);
  Future<Either<String, bool>> removeDocumentFromBundle(int documentId, int bundleId);
  
  // Reminder Operations
  Future<Either<String, List<Document>>> getDocumentsWithReminders();
  Future<Either<String, bool>> setDocumentReminder(int documentId, DateTime reminderDate, String? note);
  Future<Either<String, bool>> removeDocumentReminder(int documentId);
  
  // Backup & Restore
  Future<Either<String, String>> exportDocuments();
  Future<Either<String, bool>> importDocuments(String backupData);
  
  // Statistics
  Future<Either<String, Map<String, int>>> getDocumentTypeStatistics();
  Future<Either<String, int>> getTotalDocuments();
  Future<Either<String, int>> getExpiredDocumentsCount();
}
