import 'package:fpdart/fpdart.dart';
import '../entities/bundle_user_template.dart';
import '../repositories/bundle_repository.dart';
import '../../../../core/exceptions/app_exception.dart';

class CreateBundleUserTemplateUseCase {
  final BundleRepository repository;

  CreateBundleUserTemplateUseCase(this.repository);

  Future<Either<AppException, Unit>> call(BundleUserTemplate template) {
    return repository.createUserTemplate(template);
  }
}
