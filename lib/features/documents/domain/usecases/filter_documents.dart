import '../repositories/document_repository.dart';
import '../entities/document.dart';

class FilterDocuments {
  final DocumentRepository repository;
  FilterDocuments(this.repository);

  Future<List<Document>> call({
    List<String>? categories,
    List<String>? tags,
    DateTime? startDate,
    DateTime? endDate,
    bool? isFavorite,
    bool? isExpired,
  }) async {
    return await repository.filterDocuments(
      categories: categories,
      tags: tags,
      startDate: startDate,
      endDate: endDate,
      isFavorite: isFavorite,
      isExpired: isExpired,
    );
  }
} 