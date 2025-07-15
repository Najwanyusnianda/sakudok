import '../repositories/home_repository.dart';

class GetStorageUsage {
  final HomeRepository repository;

  GetStorageUsage(this.repository);

  Future<double> call() async {
    return await repository.getStorageUsage();
  }
} 