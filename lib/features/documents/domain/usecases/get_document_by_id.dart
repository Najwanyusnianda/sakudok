import 'package:fpdart/fpdart.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../entities/document.dart';
import '../repositories/document_repository.dart';

class GetDocumentById {
  final DocumentRepository _repository;

  GetDocumentById(this._repository);

  Future<Either<AppException, Document?>> call(String id) {
    return _repository.getDocumentById(id);
  }
}
