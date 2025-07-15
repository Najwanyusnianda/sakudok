import '../repositories/home_repository.dart';
import '../entities/proactive_card.dart';

class GetProactiveCards {
  final HomeRepository repository;

  GetProactiveCards(this.repository);

  Future<List<ProactiveCard>> call() async {
    return await repository.getProactiveCards();
  }
} 