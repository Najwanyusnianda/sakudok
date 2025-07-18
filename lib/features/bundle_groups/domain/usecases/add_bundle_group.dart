import 'package:fpdart/fpdart.dart';
import '../entities/bundle_group.dart';
import '../repositories/bundle_group_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

class AddBundleGroup implements UseCase<BundleGroup, BundleGroup> {
  final BundleGroupRepository repository;

  AddBundleGroup(this.repository);

  @override
  Future<Either<Failure, BundleGroup>> call(BundleGroup params) async {
    return await repository.addBundleGroup(params);
  }
}
