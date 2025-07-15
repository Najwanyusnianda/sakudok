// lib/features/bundles/domain/repositories/bundle_repository.dart
import 'package:fpdart/fpdart.dart';
import '../entities/bundle.dart';
import '../entities/bundle_template.dart';
import '../../../../core/exceptions/app_exception.dart';

abstract class BundleRepository {
  // Basic CRUD operations
  Future<Either<AppException, List<Bundle>>> getAllBundles();
  Future<Either<AppException, Bundle?>> getBundleById(String id);
  Future<Either<AppException, Unit>> createBundle(Bundle bundle);
  Future<Either<AppException, Unit>> updateBundle(Bundle bundle);
  Future<Either<AppException, Unit>> deleteBundle(String id);
  
  // Document management
  Future<Either<AppException, Unit>> addDocumentToBundle(String bundleId, String documentId);
  Future<Either<AppException, Unit>> removeDocumentFromBundle(String bundleId, String documentId);
  
  // Smart bundle features
  Future<Either<AppException, List<Bundle>>> getSuggestedBundles();
  Future<Either<AppException, List<BundleTemplate>>> getBundleTemplates();
  Future<Either<AppException, Bundle>> createBundleFromTemplate(String templateId, String name);
  
  // Bundle analysis
  Future<Either<AppException, List<String>>> getIncompleteBundles();
  Future<Either<AppException, Map<String, int>>> getBundleStatistics();
}
