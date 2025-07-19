// lib/features/bundles/domain/usecases/delete_bundle.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../repositories/bundle_repository.dart';

class DeleteBundle {
  final BundleRepository _repository;

  DeleteBundle(this._repository);

  Future<Either<AppException, Unit>> call(String id) async {
    return await _repository.deleteBundle(id);
  }
}
