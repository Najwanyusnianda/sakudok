// lib/features/bundles/data/repositories/bundle_repository_impl.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../../domain/entities/bundle.dart';
import '../../domain/entities/bundle_template.dart';
import '../../domain/repositories/bundle_repository.dart';
import '../datasources/bundle_local_datasource.dart';
import '../mappers/bundle_mapper.dart';

class BundleRepositoryImpl implements BundleRepository {
  final BundleLocalDataSource _localDataSource;

  BundleRepositoryImpl(this._localDataSource);

  @override
  Future<Either<AppException, List<Bundle>>> getAllBundles() async {
    try {
      final bundles = await _localDataSource.getAllBundles();
      final domainBundles = <Bundle>[];
      
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
  Future<Either<AppException, Bundle?>> getBundleById(String id) async {
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
  Future<Either<AppException, Unit>> createBundle(Bundle bundle) async {
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
  Future<Either<AppException, Unit>> updateBundle(Bundle bundle) async {
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
  Future<Either<AppException, List<Bundle>>> getSuggestedBundles() async {
    try {
      // TODO: Implement smart bundle suggestions
      // final documents = await _documentDataSource.getAllDocuments();
      // final domainDocuments = documents.map(DocumentMapper.fromDb).toList();
      // final suggestions = SmartBundleService.suggestBundles(domainDocuments);
      // final patternSuggestions = SmartBundleService.detectDocumentPatterns(domainDocuments);
      
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
  Future<Either<AppException, Bundle>> createBundleFromTemplate(String templateId, String name) async {
    try {
      // Find the template
      final template = BundleTemplates.defaultTemplates.firstWhere(
        (t) => t.id == templateId,
        orElse: () => throw Exception('Template not found'),
      );
      
      // Create bundle from template
      final bundle = Bundle(
        id: '0', // Will be assigned by database
        name: name,
        description: template.description,
        template: template.id,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        type: BundleType.template,
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
            'smart': bundles.where((b) => b.type == BundleType.smart).length,
            'manual': bundles.where((b) => b.type == BundleType.manual).length,
            'template': bundles.where((b) => b.type == BundleType.template).length,
          };
          return Right(stats);
        },
      );
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }
}
