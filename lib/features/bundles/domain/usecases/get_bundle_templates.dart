// lib/features/bundles/domain/usecases/get_bundle_templates.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../entities/bundle_template.dart';
import '../repositories/bundle_repository.dart';

class GetBundleTemplates {
  final BundleRepository _repository;

  GetBundleTemplates(this._repository);

  Future<Either<AppException, List<BundleTemplate>>> call() {
    return _repository.getBundleTemplates();
  }
}
