import 'package:fpdart/fpdart.dart';
import '../repositories/document_repository.dart';

class DeleteDocument {
  final DocumentRepository repository;

  const DeleteDocument(this.repository);

  Future<Either<String, bool>> call(int id) async {
    if (id <= 0) {
      return left('ID dokumen tidak valid');
    }

    return await repository.deleteDocument(id);
  }
} 