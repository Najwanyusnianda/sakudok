import 'package:fpdart/fpdart.dart';
import '../entities/document.dart';
import '../repositories/document_repository.dart';

class GetAllDocuments {
  final DocumentRepository repository;

  const GetAllDocuments(this.repository);

  Future<Either<String, List<Document>>> call() async {
    return await repository.getAllDocuments();
  }
}
