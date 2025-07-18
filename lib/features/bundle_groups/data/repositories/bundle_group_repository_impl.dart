import 'package:fpdart/fpdart.dart';
import 'package:drift/drift.dart';
// --- FIX: Added 'as domain' prefix to avoid name collision ---
import '../../domain/entities/bundle_group.dart' as domain;
import '../../domain/repositories/bundle_group_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/database/app_database.dart';

class BundleGroupRepositoryImpl implements BundleGroupRepository {
  final AppDatabase database;

  BundleGroupRepositoryImpl(this.database);

  @override
  Future<Either<Failure, List<domain.BundleGroup>>> getAllBundleGroups() async {
    try {
      final driftBundleGroups = await database.getAllBundleGroups();
      final bundleGroups = driftBundleGroups
          .map((driftBg) => _mapDriftToEntity(driftBg))
          .toList();
      return Right(bundleGroups);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get all bundle groups: $e'));
    }
  }

  @override
  Future<Either<Failure, domain.BundleGroup?>> getBundleGroupById(int id) async {
    try {
      final driftBundleGroup = await database.getBundleGroupById(id);
      if (driftBundleGroup == null) {
        return const Right(null);
      }
      return Right(_mapDriftToEntity(driftBundleGroup));
    } catch (e) {
      return Left(DatabaseFailure('Failed to get bundle group by ID: $e'));
    }
  }

  @override
  Future<Either<Failure, domain.BundleGroup>> addBundleGroup(domain.BundleGroup bundleGroup) async {
    try {
      final companion = BundleGroupsCompanion.insert(
        name: bundleGroup.name,
        iconName: Value(bundleGroup.iconName),
        colorHex: Value(bundleGroup.colorHex),
        displayOrder: Value(bundleGroup.displayOrder),
      );
      
      final id = await database.insertBundleGroup(companion);
      
      // Fetch the newly created record to get accurate timestamps
      final newDriftGroup = await database.getBundleGroupById(id);
      if (newDriftGroup == null) {
        return Left(DatabaseFailure('Failed to retrieve new bundle group after creation.'));
      }

      return Right(_mapDriftToEntity(newDriftGroup));
    } catch (e) {
      return Left(DatabaseFailure('Failed to add bundle group: $e'));
    }
  }

  @override
  Future<Either<Failure, domain.BundleGroup>> updateBundleGroup(domain.BundleGroup bundleGroup) async {
    try {
      final now = DateTime.now();
      final companion = BundleGroupsCompanion(
        id: Value(bundleGroup.id),
        name: Value(bundleGroup.name),
        iconName: Value(bundleGroup.iconName),
        colorHex: Value(bundleGroup.colorHex),
        displayOrder: Value(bundleGroup.displayOrder),
        updatedAt: Value(now),
      );
      
      await database.updateBundleGroup(companion);
      return Right(bundleGroup.copyWith(updatedAt: now));
    } catch (e) {
      return Left(DatabaseFailure('Failed to update bundle group: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBundleGroup(int id) async {
    try {
      await database.deleteBundleGroup(id);
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure('Failed to delete bundle group: $e'));
    }
  }

  // --- FIX: Use the prefixed 'domain.BundleGroup' for the return type ---
  domain.BundleGroup _mapDriftToEntity(DriftBundleGroup driftBundleGroup) {
    return domain.BundleGroup(
      id: driftBundleGroup.id,
      name: driftBundleGroup.name,
      iconName: driftBundleGroup.iconName,
      colorHex: driftBundleGroup.colorHex,
      displayOrder: driftBundleGroup.displayOrder,
      createdAt: driftBundleGroup.createdAt,
      updatedAt: driftBundleGroup.updatedAt,
    );
  }
}
