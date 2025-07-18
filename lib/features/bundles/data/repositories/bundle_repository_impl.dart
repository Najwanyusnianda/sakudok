// lib/features/bundles/data/repositories/bundle_repository_impl.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/exceptions/app_exception.dart';
// --- FIX: Added 'as domain' prefix to avoid name collision ---
import '../../domain/entities/bundle.dart' as domain;
import '../../domain/entities/bundle_template.dart';
import '../../domain/repositories/bundle_repository.dart';
import '../datasources/bundle_local_datasource.dart';
import '../mappers/bundle_mapper.dart';

class BundleRepositoryImpl implements BundleRepository {
  final BundleLocalDataSource _localDataSource;

  BundleRepositoryImpl(this._localDataSource);

  @override
  // --- FIX: Use the prefixed 'domain.Bundle' ---
  Future<Either<AppException, List<domain.Bundle>>> getAllBundles() async {
    try {
      final bundles = await _localDataSource.getAllBundles();
      // --- FIX: Use the prefixed 'domain.Bundle' ---
      final domainBundles = <domain.Bundle>[];
      
      // Get documents for each bundle
      for (final bundle in bundles) {
        final documents = await _localDataSource.getBundleDocuments(bundle.id);
        domainBundles.add(BundleMapper.fromDb(bundle, documents: documents));
      }
      
      return Right(domainBundles);
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  @override
  // --- FIX: Use the prefixed 'domain.Bundle' ---
  Future<Either<AppException, domain.Bundle?>> getBundleById(String id) async {
    try {
      final bundleId = int.tryParse(id);
      if (bundleId == null) {
        return Left(AppException('Invalid bundle ID'));
      }
      
      final bundle = await _localDataSource.getBundleById(bundleId);
      if (bundle == null) {
        return const Right(null);
      }
      
      final documents = await _localDataSource.getBundleDocuments(bundleId);
      return Right(BundleMapper.fromDb(bundle, documents: documents));
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  @override
  // --- FIX: Use the prefixed 'domain.Bundle' ---
  Future<Either<AppException, Unit>> createBundle(domain.Bundle bundle) async {
    try {
      final bundleCompanion = BundleMapper.toDb(bundle);
      final bundleId = await _localDataSource.insertBundle(bundleCompanion);
      
      // Add documents to bundle if any
      for (final document in bundle.documents) {
        final documentId = int.tryParse(document.id);
        if (documentId != null) {
          await _localDataSource.addDocumentToBundle(bundleId, documentId);
        }
      }
      
      return const Right(unit);
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  @override
  // --- FIX: Use the prefixed 'domain.Bundle' ---
  Future<Either<AppException, Unit>> updateBundle(domain.Bundle bundle) async {
    try {
      final bundleCompanion = BundleMapper.toDb(bundle);
      await _localDataSource.updateBundle(bundleCompanion);
      return const Right(unit);
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<AppException, Unit>> deleteBundle(String id) async {
    try {
      final bundleId = int.tryParse(id);
      if (bundleId == null) {
        return Left(AppException('Invalid bundle ID'));
      }
      
      await _localDataSource.deleteBundle(bundleId);
      return const Right(unit);
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<AppException, Unit>> addDocumentToBundle(String bundleId, String documentId) async {
    try {
      final bId = int.tryParse(bundleId);
      final dId = int.tryParse(documentId);
      
      if (bId == null || dId == null) {
        return Left(AppException('Invalid bundle or document ID'));
      }
      
      await _localDataSource.addDocumentToBundle(bId, dId);
      return const Right(unit);
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<AppException, Unit>> removeDocumentFromBundle(String bundleId, String documentId) async {
    try {
      final bId = int.tryParse(bundleId);
      final dId = int.tryParse(documentId);
      
      if (bId == null || dId == null) {
        return Left(AppException('Invalid bundle or document ID'));
      }
      
      await _localDataSource.removeDocumentFromBundle(bId, dId);
      return const Right(unit);
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  @override
  // --- FIX: Use the prefixed 'domain.Bundle' ---
  Future<Either<AppException, List<domain.Bundle>>> getSuggestedBundles() async {
    try {
      return const Right([]); // Return empty for now
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<AppException, List<BundleTemplate>>> getBundleTemplates() async {
    try {
      // Return predefined templates
      return const Right(BundleTemplates.defaultTemplates);
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  @override
  // --- FIX: Use the prefixed 'domain.Bundle' ---
  Future<Either<AppException, domain.Bundle>> createBundleFromTemplate(String templateId, String name) async {
    try {
      // Find the template
      final template = BundleTemplates.defaultTemplates.firstWhere(
        (t) => t.id == templateId,
        orElse: () => throw Exception('Template not found'),
      );
      
      // Create bundle from template
      // --- FIX: Use the prefixed 'domain.Bundle' and 'domain.BundleType' ---
      final bundle = domain.Bundle(
        id: '0', // Will be assigned by database
        name: name,
        description: template.description,
        template: template.id,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        type: domain.BundleType.template,
        requiredDocumentTypes: template.requiredDocumentTypes,
        suggestedDocumentTypes: template.optionalDocumentTypes,
      );
      
      // Save the bundle
      final createResult = await createBundle(bundle);
      return createResult.fold(
        (error) => Left(error),
        (_) => Right(bundle),
      );
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<AppException, List<String>>> getIncompleteBundles() async {
    try {
      final bundlesResult = await getAllBundles();
      return bundlesResult.fold(
        (error) => Left(error),
        (bundles) {
          final incomplete = bundles
              .where((bundle) => !bundle.isComplete)
              .map((bundle) => bundle.id)
              .toList();
          return Right(incomplete);
        },
      );
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<AppException, Map<String, int>>> getBundleStatistics() async {
    try {
      final bundlesResult = await getAllBundles();
      return bundlesResult.fold(
        (error) => Left(error),
        (bundles) {
          final stats = <String, int>{
            'total': bundles.length,
            'complete': bundles.where((b) => b.isComplete).length,
            'incomplete': bundles.where((b) => !b.isComplete).length,
            // --- FIX: Use the prefixed 'domain.BundleType' ---
            'smart': bundles.where((b) => b.type == domain.BundleType.smart).length,
            'manual': bundles.where((b) => b.type == domain.BundleType.manual).length,
            'template': bundles.where((b) => b.type == domain.BundleType.template).length,
          };
          return Right(stats);
        },
      );
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }
}
