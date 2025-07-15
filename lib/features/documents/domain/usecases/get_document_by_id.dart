import 'package:fpdart/fpdart.dart';
import '../entities/document.dart';
import '../repositories/document_repository.dart';

class GetDocumentById {
  final DocumentRepository repository;

  const GetDocumentById(this.repository);

  Future<Either<String, Document>> call(int id) async {
    if (id <= 0) {
      return left('ID dokumen tidak valid');
    }

    return await repository.getDocumentById(id);
  }
}
