import 'package:fpdart/fpdart.dart';
import '../entities/bundle_user_template.dart';
import '../repositories/bundle_repository.dart';
import '../../../../core/exceptions/app_exception.dart';

class GetBundleUserTemplatesUseCase {
  final BundleRepository repository;

  GetBundleUserTemplatesUseCase(this.repository);

  Future<Either<AppException, List<BundleUserTemplate>>> call() {
    return repository.getUserTemplates();
  }
}
