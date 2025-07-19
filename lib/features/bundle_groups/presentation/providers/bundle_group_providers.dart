import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/bundle_group_repository_impl.dart';
import '../../domain/entities/bundle_group.dart' as domain;
import '../../domain/repositories/bundle_group_repository.dart';
import '../../domain/usecases/get_all_bundle_groups.dart';
import '../../domain/usecases/add_bundle_group.dart';
import '../../domain/usecases/update_bundle_group.dart';
import '../../domain/usecases/delete_bundle_group.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/usecases/usecase.dart';

// Data Layer Providers
final bundleGroupDataSourceProvider = Provider<AppDatabase>((ref) => AppDatabase());
final bundleGroupRepositoryProvider = Provider<BundleGroupRepository>(
    (ref) => BundleGroupRepositoryImpl(ref.watch(bundleGroupDataSourceProvider)));

// Domain Layer (Use Case) Providers
final getAllBundleGroupsProvider =
    Provider<GetAllBundleGroups>((ref) => GetAllBundleGroups(ref.watch(bundleGroupRepositoryProvider)));
final addBundleGroupProvider =
    Provider<AddBundleGroup>((ref) => AddBundleGroup(ref.watch(bundleGroupRepositoryProvider)));
final updateBundleGroupProvider =
    Provider<UpdateBundleGroup>((ref) => UpdateBundleGroup(ref.watch(bundleGroupRepositoryProvider)));
final deleteBundleGroupProvider =
    Provider<DeleteBundleGroup>((ref) => DeleteBundleGroup(ref.watch(bundleGroupRepositoryProvider)));

// State Notifier for Bundle Group List
final bundleGroupsNotifierProvider =
    StateNotifierProvider<BundleGroupNotifier, AsyncValue<List<domain.BundleGroup>>>((ref) {
  return BundleGroupNotifier(ref);
});

class BundleGroupNotifier extends StateNotifier<AsyncValue<List<domain.BundleGroup>>> {
  final Ref _ref;
  BundleGroupNotifier(this._ref) : super(const AsyncValue.loading()) {
    loadBundleGroups();
  }

  Future<void> loadBundleGroups() async {
    state = const AsyncValue.loading();
    final usecase = _ref.read(getAllBundleGroupsProvider);
    final result = await usecase(NoParams());
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (bundleGroups) => AsyncValue.data(bundleGroups),
    );
  }

  Future<bool> addBundleGroup(domain.BundleGroup bundleGroup) async {
    final usecase = _ref.read(addBundleGroupProvider);
    final result = await usecase(bundleGroup);
    return result.fold(
      (failure) => false,
      (_) {
        loadBundleGroups(); // Refresh list on success
        return true;
      },
    );
  }

  Future<bool> updateBundleGroup(domain.BundleGroup bundleGroup) async {
    final usecase = _ref.read(updateBundleGroupProvider);
    final result = await usecase(bundleGroup);
    return result.fold(
      (failure) => false,
      (_) {
        loadBundleGroups(); // Refresh list on success
        return true;
      },
    );
  }

  Future<bool> deleteBundleGroup(int id) async {
    final usecase = _ref.read(deleteBundleGroupProvider);
    final result = await usecase(id);
    return result.fold(
      (failure) => false,
      (_) {
        loadBundleGroups(); // Refresh list on success
        return true;
      },
    );
  }
}

// Provider for current selected bundle group filter
final selectedBundleGroupProvider = StateProvider<int?>((ref) => null);
