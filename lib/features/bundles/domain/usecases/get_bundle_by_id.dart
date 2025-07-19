// lib/features/bundles/domain/usecases/get_bundle_by_id.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../entities/bundle.dart';
import '../repositories/bundle_repository.dart';

class GetBundleById {
  final BundleRepository _repository;

  GetBundleById(this._repository);

  Future<Either<AppException, Bundle?>> call(String id) async {
    return await _repository.getBundleById(id);
  }
}
