import '../repositories/home_repository.dart';
import '../entities/document.dart';

class GetFavoriteDocuments {
  final HomeRepository repository;

  GetFavoriteDocuments(this.repository);

  Future<List<Document>> call() async {
    return await repository.getFavoriteDocuments();
  }
} 