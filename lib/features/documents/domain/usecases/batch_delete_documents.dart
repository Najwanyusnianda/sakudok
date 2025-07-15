import '../repositories/document_repository.dart';

class BatchDeleteDocuments {
  final DocumentRepository repository;
  BatchDeleteDocuments(this.repository);

  Future<void> call(List<String> ids) async {
    await repository.batchDeleteDocuments(ids);
  }
} 