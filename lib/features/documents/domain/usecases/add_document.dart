import 'package:fpdart/fpdart.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../entities/document.dart';
import '../repositories/document_repository.dart';

class AddDocument {
  final DocumentRepository _repository;

  AddDocument(this._repository);

  Future<Either<AppException, Unit>> call(Document document) {
    return _repository.addDocument(document);
  }
}
