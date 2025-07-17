//lib/features/documents/presentation/providers/document_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/document_repository_impl.dart';
import '../../data/datasources/document_local_datasource.dart';
import '../../domain/entities/document.dart';
import '../../domain/repositories/document_repository.dart';
import '../../domain/usecases/add_document.dart';
import '../../domain/usecases/get_all_documents.dart';
import '../../domain/usecases/get_document_by_id.dart';
import '../../domain/usecases/delete_document.dart';
import '../../domain/usecases/search_documents.dart';
import '../../domain/usecases/update_document.dart';
import '../../../../core/database/app_database.dart' as db;

// Data Layer Providers
final databaseProvider = Provider<db.AppDatabase>((ref) => db.AppDatabase());
final documentDataSourceProvider = Provider<DocumentLocalDataSource>(
    (ref) => DocumentLocalDataSourceImpl(ref.watch(databaseProvider)));
final documentRepositoryProvider = Provider<DocumentRepository>(
    (ref) => DocumentRepositoryImpl(ref.watch(documentDataSourceProvider)));

// Domain Layer (Use Case) Providers
final getAllDocumentsProvider =
    Provider<GetAllDocuments>((ref) => GetAllDocuments(ref.watch(documentRepositoryProvider)));
final getDocumentByIdProvider =
    Provider<GetDocumentById>((ref) => GetDocumentById(ref.watch(documentRepositoryProvider)));
final addDocumentProvider =
    Provider<AddDocument>((ref) => AddDocument(ref.watch(documentRepositoryProvider)));
final updateDocumentProvider =
    Provider<UpdateDocument>((ref) => UpdateDocument(ref.watch(documentRepositoryProvider)));
final deleteDocumentProvider =
    Provider<DeleteDocument>((ref) => DeleteDocument(ref.watch(documentRepositoryProvider)));
final searchDocumentsProvider =
    Provider<SearchDocuments>((ref) => SearchDocuments(ref.watch(documentRepositoryProvider)));

// State Notifier for Document List
final documentsNotifierProvider =
    StateNotifierProvider<DocumentNotifier, AsyncValue<List<Document>>>((ref) {
  return DocumentNotifier(ref);
});

class DocumentNotifier extends StateNotifier<AsyncValue<List<Document>>> {
  final Ref _ref;
  DocumentNotifier(this._ref) : super(const AsyncValue.loading()) {
    loadDocuments();
  }

  Future<void> loadDocuments() async {
    state = const AsyncValue.loading();
    final usecase = _ref.read(getAllDocumentsProvider);
    final result = await usecase();
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (documents) => AsyncValue.data(documents),
    );
  }

  Future<bool> addDocument(Document document) async {
    final usecase = _ref.read(addDocumentProvider);
    final result = await usecase(document);
    return result.fold(
      (failure) {
        // Return false to indicate failure
        return false;
      },
      (_) {
        loadDocuments(); // Refresh list on success
        return true; // Return true to indicate success
      },
    );
  }

  Future<void> updateDocument(Document document) async {
    final usecase = _ref.read(updateDocumentProvider);
    final result = await usecase(document);
    result.fold(
      (failure) {}, // Error handled by the list's global state
      (_) => loadDocuments(),
    );
  }

  Future<void> deleteDocument(String id) async {
    final usecase = _ref.read(deleteDocumentProvider);
    final result = await usecase(id);
    result.fold(
      (failure) {}, // Error handled by the list's global state
      (_) => loadDocuments(),
    );
  }
}

// Provider for a single document, useful for detail pages
final documentByIdProvider =
    FutureProvider.family<Document?, String>((ref, id) async {
  final usecase = ref.watch(getDocumentByIdProvider);
  final result = await usecase(id);
  return result.fold(
    (failure) => throw failure, // Let the UI handle the error state
    (document) => document,
  );
});

// Providers for search functionality
final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = FutureProvider<List<Document>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) {
    // This part is tricky, we want to show all documents without re-fetching
    // A better approach would be to have a single source of truth for the list
    // and filter it. For now, we'll re-fetch.
    final usecase = ref.watch(getAllDocumentsProvider);
    final result = await usecase();
    return result.fold(
      (failure) => throw failure,
      (documents) => documents,
    );
  } else {
    final usecase = ref.watch(searchDocumentsProvider);
    final result = await usecase(query);
    return result.fold(
      (failure) => throw failure,
      (documents) => documents,
    );
  }
}); 