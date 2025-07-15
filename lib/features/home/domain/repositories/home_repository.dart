import '../entities/user.dart';
import '../entities/document.dart';
import '../entities/proactive_card.dart';

abstract class HomeRepository {
  Future<User> getUser();
  Future<double> getStorageUsage();
  Future<List<Document>> getFavoriteDocuments();
  Future<List<ProactiveCard>> getProactiveCards();
} 