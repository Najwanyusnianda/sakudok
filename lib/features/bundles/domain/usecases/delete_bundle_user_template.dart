import 'package:fpdart/fpdart.dart';
import '../repositories/bundle_repository.dart';
import '../../../../core/exceptions/app_exception.dart';

class DeleteBundleUserTemplateUseCase {
  final BundleRepository repository;

  DeleteBundleUserTemplateUseCase(this.repository);

  Future<Either<AppException, Unit>> call(String templateId) {
    return repository.deleteUserTemplate(templateId);
  }
}
