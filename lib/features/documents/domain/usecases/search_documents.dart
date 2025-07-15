import 'package:fpdart/fpdart.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../entities/document.dart';
import '../repositories/document_repository.dart';

class SearchDocuments {
  final DocumentRepository _repository;

  SearchDocuments(this._repository);

  Future<Either<AppException, List<Document>>> call(String query) {
    return _repository.searchDocuments(query);
  }
} 