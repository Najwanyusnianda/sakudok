import 'package:fpdart/fpdart.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../entities/document.dart';
import '../repositories/document_repository.dart';

class GetAllDocuments {
  final DocumentRepository _repository;

  GetAllDocuments(this._repository);

  Future<Either<AppException, List<Document>>> call() {
    return _repository.getAllDocuments();
  }
}
