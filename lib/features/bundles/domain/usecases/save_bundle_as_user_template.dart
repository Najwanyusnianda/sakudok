import 'package:fpdart/fpdart.dart';
import '../entities/bundle_user_template.dart';
import '../repositories/bundle_repository.dart';
import '../../../../core/exceptions/app_exception.dart';

class SaveBundleAsUserTemplateUseCase {
  final BundleRepository repository;

  SaveBundleAsUserTemplateUseCase(this.repository);

  Future<Either<AppException, BundleUserTemplate>> call(String bundleId, String templateName) {
    return repository.saveBundleAsTemplate(bundleId, templateName);
  }
}
