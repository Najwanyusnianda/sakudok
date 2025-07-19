// lib/features/bundles/domain/repositories/bundle_repository.dart
import 'package:fpdart/fpdart.dart';
import '../entities/bundle.dart';
import '../entities/bundle_template.dart';
import '../entities/bundle_user_template.dart';
import '../entities/bundle_slot.dart';
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
  
  // User Templates (Custom Templates)
  Future<Either<AppException, List<BundleUserTemplate>>> getUserTemplates();
  Future<Either<AppException, BundleUserTemplate?>> getUserTemplateById(String id);
  Future<Either<AppException, Unit>> createUserTemplate(BundleUserTemplate template);
  Future<Either<AppException, Unit>> updateUserTemplate(BundleUserTemplate template);
  Future<Either<AppException, Unit>> deleteUserTemplate(String id);
  Future<Either<AppException, BundleUserTemplate>> saveBundleAsTemplate(String bundleId, String templateName);
  Stream<List<BundleUserTemplate>> watchUserTemplates();

  // Bundle Slots Management
  Future<Either<AppException, List<BundleSlot>>> getBundleSlots(String bundleId);
  Future<Either<AppException, BundleSlot?>> getBundleSlotById(String id);
  Future<Either<AppException, Unit>> createBundleSlot(BundleSlot slot);
  Future<Either<AppException, Unit>> updateBundleSlot(BundleSlot slot);
  Future<Either<AppException, Unit>> deleteBundleSlot(String id);
  Future<Either<AppException, Unit>> attachDocumentToSlot(String slotId, String documentId);
  Future<Either<AppException, Unit>> detachDocumentFromSlot(String slotId);
}
