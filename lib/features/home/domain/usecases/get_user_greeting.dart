import '../repositories/home_repository.dart';
import '../entities/user.dart';

class GetUserGreeting {
  final HomeRepository repository;

  GetUserGreeting(this.repository);

  Future<String> call() async {
    final user = await repository.getUser();
    return 'Halo, ${user.name}!';
  }
} 