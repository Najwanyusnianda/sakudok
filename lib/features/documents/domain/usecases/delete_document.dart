import 'package:fpdart/fpdart.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../repositories/document_repository.dart';

class DeleteDocument {
  final DocumentRepository _repository;

  DeleteDocument(this._repository);

  Future<Either<AppException, Unit>> call(String id) {
    return _repository.deleteDocument(id);
  }
} 