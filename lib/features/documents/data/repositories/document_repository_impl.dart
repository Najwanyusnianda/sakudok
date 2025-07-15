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
      final documents = dbDocs.map((doc) => DocumentMapper.fromDb(doc)).toList();
      return right(documents);
    } catch (e) {
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