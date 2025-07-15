// lib/features/bundles/domain/usecases/create_bundle.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../entities/bundle.dart';
import '../repositories/bundle_repository.dart';

class CreateBundle {
  final BundleRepository _repository;

  CreateBundle(this._repository);

  Future<Either<AppException, Unit>> call(Bundle bundle) {
    return _repository.createBundle(bundle);
  }
}
