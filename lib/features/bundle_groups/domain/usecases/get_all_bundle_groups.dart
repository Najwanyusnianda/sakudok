import 'package:fpdart/fpdart.dart';
import '../entities/bundle_group.dart';
import '../repositories/bundle_group_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetAllBundleGroups implements UseCase<List<BundleGroup>, NoParams> {
  final BundleGroupRepository repository;

  GetAllBundleGroups(this.repository);

  @override
  Future<Either<Failure, List<BundleGroup>>> call(NoParams params) async {
    return await repository.getAllBundleGroups();
  }
}
