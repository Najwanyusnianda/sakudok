// lib/features/bundles/presentation/providers/bundle_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/bundle_repository_impl.dart';
import '../../data/datasources/bundle_local_datasource.dart';
import '../../domain/entities/bundle.dart';
import '../../domain/entities/bundle_template.dart';
import '../../domain/entities/bundle_user_template.dart';
import '../../domain/entities/bundle_slot.dart';
import '../../domain/repositories/bundle_repository.dart';
import '../../domain/usecases/get_all_bundles.dart';
import '../../domain/usecases/create_bundle.dart';
import '../../domain/usecases/update_bundle.dart';
import '../../domain/usecases/delete_bundle.dart';
import '../../domain/usecases/get_bundle_by_id.dart';
import '../../domain/usecases/get_suggested_bundles.dart';
import '../../domain/usecases/get_bundle_templates.dart';
import '../../domain/usecases/create_bundle_user_template.dart';
import '../../domain/usecases/get_bundle_user_templates.dart';
import '../../domain/usecases/save_bundle_as_user_template.dart';
import '../../domain/usecases/delete_bundle_user_template.dart';
import '../../../../core/database/app_database.dart' as db;

// Data Layer Providers
final databaseProvider = Provider<db.AppDatabase>((ref) => db.AppDatabase());

final bundleDataSourceProvider = Provider<BundleLocalDataSource>(
    (ref) => BundleLocalDataSourceImpl(ref.watch(databaseProvider)));

final bundleRepositoryProvider = Provider<BundleRepository>(
    (ref) => BundleRepositoryImpl(ref.watch(bundleDataSourceProvider)));

// Use Case Providers
final getAllBundlesProvider =
    Provider<GetAllBundles>((ref) => GetAllBundles(ref.watch(bundleRepositoryProvider)));

final getBundleByIdProvider =
    Provider<GetBundleById>((ref) => GetBundleById(ref.watch(bundleRepositoryProvider)));

final createBundleProvider =
    Provider<CreateBundle>((ref) => CreateBundle(ref.watch(bundleRepositoryProvider)));

final updateBundleProvider =
    Provider<UpdateBundle>((ref) => UpdateBundle(ref.watch(bundleRepositoryProvider)));

final deleteBundleProvider =
    Provider<DeleteBundle>((ref) => DeleteBundle(ref.watch(bundleRepositoryProvider)));

final getSuggestedBundlesProvider =
    Provider<GetSuggestedBundles>((ref) => GetSuggestedBundles(ref.watch(bundleRepositoryProvider)));

final getBundleTemplatesProvider =
    Provider<GetBundleTemplates>((ref) => GetBundleTemplates(ref.watch(bundleRepositoryProvider)));

// User Template Use Case Providers
final createUserTemplateProvider =
    Provider<CreateBundleUserTemplateUseCase>((ref) => CreateBundleUserTemplateUseCase(ref.watch(bundleRepositoryProvider)));

final getUserTemplatesProvider =
    Provider<GetBundleUserTemplatesUseCase>((ref) => GetBundleUserTemplatesUseCase(ref.watch(bundleRepositoryProvider)));

final saveBundleAsTemplateProvider =
    Provider<SaveBundleAsUserTemplateUseCase>((ref) => SaveBundleAsUserTemplateUseCase(ref.watch(bundleRepositoryProvider)));

final deleteUserTemplateProvider =
    Provider<DeleteBundleUserTemplateUseCase>((ref) => DeleteBundleUserTemplateUseCase(ref.watch(bundleRepositoryProvider)));

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
    await usecase(bundle);
    loadBundles(); // Refresh list
  }

  Future<void> updateBundle(Bundle bundle) async {
    final usecase = _ref.read(updateBundleProvider);
    await usecase(bundle);
    loadBundles(); // Refresh list
  }

  Future<bool> deleteBundle(String bundleId) async {
    final usecase = _ref.read(deleteBundleProvider);
    final result = await usecase(bundleId);
    return result.fold(
      (failure) => false, // Return false on failure
      (_) {
        loadBundles(); // Refresh list
        return true; // Return true on success
      },
    );
  }
}

// --- FIX: Added the missing provider to fetch a single bundle by its ID ---
final bundleByIdProvider = FutureProvider.family<Bundle?, String>((ref, id) async {
  final usecase = ref.watch(getBundleByIdProvider);
  final result = await usecase(id);
  return result.fold(
    (failure) => null, // Return null or throw an error
    (bundle) => bundle,
  );
});

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

// User Template Providers
final userTemplatesProvider = FutureProvider<List<BundleUserTemplate>>((ref) async {
  final usecase = ref.watch(getUserTemplatesProvider);
  final result = await usecase();
  return result.fold(
    (failure) => throw failure,
    (templates) => templates,
  );
});

// State Notifier for User Templates
final userTemplatesNotifierProvider =
    StateNotifierProvider<BundleUserTemplatesNotifier, AsyncValue<List<BundleUserTemplate>>>((ref) {
  return BundleUserTemplatesNotifier(ref);
});

class BundleUserTemplatesNotifier extends StateNotifier<AsyncValue<List<BundleUserTemplate>>> {
  final Ref _ref;
  
  BundleUserTemplatesNotifier(this._ref) : super(const AsyncValue.loading()) {
    loadUserTemplates();
  }

  Future<void> loadUserTemplates() async {
    state = const AsyncValue.loading();
    final usecase = _ref.read(getUserTemplatesProvider);
    final result = await usecase();
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (templates) => AsyncValue.data(templates),
    );
  }

  Future<void> createUserTemplate(BundleUserTemplate template) async {
    final usecase = _ref.read(createUserTemplateProvider);
    await usecase(template);
    loadUserTemplates(); // Refresh list
  }

  Future<BundleUserTemplate?> saveBundleAsTemplate(String bundleId, String templateName) async {
    final usecase = _ref.read(saveBundleAsTemplateProvider);
    final result = await usecase(bundleId, templateName);
    return result.fold(
      (failure) => null,
      (template) {
        loadUserTemplates(); // Refresh list
        return template;
      },
    );
  }

  Future<bool> deleteUserTemplate(String templateId) async {
    final usecase = _ref.read(deleteUserTemplateProvider);
    final result = await usecase(templateId);
    return result.fold(
      (failure) => false,
      (_) {
        loadUserTemplates(); // Refresh list
        return true;
      },
    );
  }
}

// Bundle Slots Providers
final bundleSlotsProvider = FutureProvider.family<List<BundleSlot>, String>((ref, bundleId) async {
  final repository = ref.watch(bundleRepositoryProvider);
  final result = await repository.getBundleSlots(bundleId);
  return result.fold(
    (failure) => throw failure,
    (slots) => slots,
  );
});

// Bundle Slot Actions
final createBundleSlotProvider = Provider<Future<bool> Function(BundleSlot)>((ref) {
  return (BundleSlot slot) async {
    final repository = ref.read(bundleRepositoryProvider);
    final result = await repository.createBundleSlot(slot);
    return result.fold(
      (failure) => false,
      (_) => true,
    );
  };
});
