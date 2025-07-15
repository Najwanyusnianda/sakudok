// lib/features/documents/domain/repositories/document_repository.dart
import 'package:fpdart/fpdart.dart';
import '../entities/document.dart';
import '../../../../core/exceptions/app_exception.dart';

abstract class DocumentRepository {
  Future<Either<AppException, List<Document>>> getAllDocuments();
  Future<Either<AppException, Document?>> getDocumentById(String id);
  Future<Either<AppException, List<Document>>> searchDocuments(String query);
  Future<Either<AppException, Unit>> addDocument(Document document);
  Future<Either<AppException, Unit>> updateDocument(Document document);
  Future<Either<AppException, Unit>> deleteDocument(String id);
}
