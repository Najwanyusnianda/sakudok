import 'package:fpdart/fpdart.dart';
import '../entities/document.dart';
import '../repositories/document_repository.dart';

class SearchDocuments {
  final DocumentRepository repository;

  const SearchDocuments(this.repository);

  Future<Either<String, List<Document>>> call(String query) async {
    if (query.trim().isEmpty) {
      return left('Query pencarian tidak boleh kosong');
    }

    if (query.trim().length < 2) {
      return left('Query pencarian minimal 2 karakter');
    }

    return await repository.searchDocuments(query.trim());
  }
} 