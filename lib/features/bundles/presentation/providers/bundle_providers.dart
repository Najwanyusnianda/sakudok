// lib/features/bundles/presentation/providers/bundle_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/bundle_repository_impl.dart';
import '../../data/datasources/bundle_local_datasource.dart';
import '../../domain/entities/bundle.dart';
import '../../domain/entities/bundle_template.dart';
import '../../domain/repositories/bundle_repository.dart';
import '../../domain/usecases/get_all_bundles.dart';
import '../../domain/usecases/create_bundle.dart';
import '../../domain/usecases/get_suggested_bundles.dart';
import '../../domain/usecases/get_bundle_templates.dart';
import '../../../../core/database/app_database.dart' as db;

// Data Layer Providers
final bundleDataSourceProvider = Provider<BundleLocalDataSource>(
    (ref) => BundleLocalDataSourceImpl(ref.watch(databaseProvider)));

final bundleRepositoryProvider = Provider<BundleRepository>(
    (ref) => BundleRepositoryImpl(ref.watch(bundleDataSourceProvider)));

// Use Case Providers
final getAllBundlesProvider =
    Provider<GetAllBundles>((ref) => GetAllBundles(ref.watch(bundleRepositoryProvider)));

final createBundleProvider =
    Provider<CreateBundle>((ref) => CreateBundle(ref.watch(bundleRepositoryProvider)));

final getSuggestedBundlesProvider =
    Provider<GetSuggestedBundles>((ref) => GetSuggestedBundles(ref.watch(bundleRepositoryProvider)));

final getBundleTemplatesProvider =
    Provider<GetBundleTemplates>((ref) => GetBundleTemplates(ref.watch(bundleRepositoryProvider)));

// Database provider (assuming it exists in document providers)
final databaseProvider = Provider<db.AppDatabase>((ref) => db.AppDatabase());

// State Notifier for Bundle List
final bundlesNotifierProvider =
    StateNotifierProvider<BundleNotifier, AsyncValue<List<Bundle>>>((ref) {
  return BundleNotifier(ref);
});

class BundleNotifier extends StateNotifier<AsyncValue<List<Bundle>>> {
  final Ref _ref;
  
  BundleNotifier(this._ref) : super(const AsyncValue.loading()) {
    loadBundles();
  }

  Future<void> loadBundles() async {
    state = const AsyncValue.loading();
    final usecase = _ref.read(getAllBundlesProvider);
    final result = await usecase();
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (bundles) => AsyncValue.data(bundles),
    );
  }

  Future<void> createBundle(Bundle bundle) async {
    final usecase = _ref.read(createBundleProvider);
    final result = await usecase(bundle);
    result.fold(
      (failure) {
        // Handle error - could show snackbar or update state
      },
      (_) => loadBundles(), // Refresh list on success
    );
  }

  Future<void> createBundleFromTemplate(String templateId, String name) async {
    final repository = _ref.read(bundleRepositoryProvider);
    final result = await repository.createBundleFromTemplate(templateId, name);
    result.fold(
      (failure) {
        // Handle error
      },
      (_) => loadBundles(), // Refresh list on success
    );
  }
}

// Provider for suggested bundles
final suggestedBundlesProvider = FutureProvider<List<Bundle>>((ref) async {
  final usecase = ref.watch(getSuggestedBundlesProvider);
  final result = await usecase();
  return result.fold(
    (failure) => throw failure,
    (bundles) => bundles,
  );
});

// Provider for bundle templates
final bundleTemplatesProvider = FutureProvider<List<BundleTemplate>>((ref) async {
  final usecase = ref.watch(getBundleTemplatesProvider);
  final result = await usecase();
  return result.fold(
    (failure) => throw failure,
    (templates) => templates,
  );
});

// Provider for bundle statistics
final bundleStatisticsProvider = FutureProvider<Map<String, int>>((ref) async {
  final repository = ref.watch(bundleRepositoryProvider);
  final result = await repository.getBundleStatistics();
  return result.fold(
    (failure) => throw failure,
    (stats) => stats,
  );
});
