// lib/features/bundles/domain/usecases/get_all_bundles.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../entities/bundle.dart';
import '../repositories/bundle_repository.dart';

class GetAllBundles {
  final BundleRepository _repository;

  GetAllBundles(this._repository);

  Future<Either<AppException, List<Bundle>>> call() {
    return _repository.getAllBundles();
  }
}
