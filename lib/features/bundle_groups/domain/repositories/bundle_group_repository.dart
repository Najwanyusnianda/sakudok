import 'package:fpdart/fpdart.dart';
import '../entities/bundle_group.dart';
import '../../../../core/errors/failures.dart';

abstract class BundleGroupRepository {
  Future<Either<Failure, List<BundleGroup>>> getAllBundleGroups();
  Future<Either<Failure, BundleGroup?>> getBundleGroupById(int id);
  Future<Either<Failure, BundleGroup>> addBundleGroup(BundleGroup bundleGroup);
  Future<Either<Failure, BundleGroup>> updateBundleGroup(BundleGroup bundleGroup);
  Future<Either<Failure, void>> deleteBundleGroup(int id);
}
