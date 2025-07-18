import 'package:fpdart/fpdart.dart';
import '../repositories/bundle_group_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

class DeleteBundleGroup implements UseCase<void, int> {
  final BundleGroupRepository repository;

  DeleteBundleGroup(this.repository);

  @override
  Future<Either<Failure, void>> call(int params) async {
    return await repository.deleteBundleGroup(params);
  }
}
