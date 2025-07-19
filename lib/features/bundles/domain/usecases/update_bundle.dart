// lib/features/bundles/domain/usecases/update_bundle.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../entities/bundle.dart';
import '../repositories/bundle_repository.dart';

class UpdateBundle {
  final BundleRepository _repository;

  UpdateBundle(this._repository);

  Future<Either<AppException, Unit>> call(Bundle bundle) async {
    return await _repository.updateBundle(bundle);
  }
}
