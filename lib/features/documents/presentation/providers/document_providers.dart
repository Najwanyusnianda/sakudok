import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../../data/repositories/document_repository_impl.dart';
import '../../data/datasources/document_local_datasource.dart';
import '../../domain/entities/document.dart';
import '../../domain/repositories/document_repository.dart';
import '../../domain/usecases/add_document.dart';
import '../../domain/usecases/get_all_documents.dart';
import '../../domain/usecases/get_document_by_id.dart';
import '../../../../core/database/app_database.dart' as db;

// Database provider
final databaseProvider = Provider<db.AppDatabase>((ref) {
  return db.AppDatabase();
});

// Data source provider
final documentDataSourceProvider = Provider<DocumentLocalDataSource>((ref) {
  final database = ref.watch(databaseProvider);
  return DocumentLocalDataSourceImpl(database);
});

// Repository provider
final documentRepositoryProvider = Provider<DocumentRepository>((ref) {
  final dataSource = ref.watch(documentDataSourceProvider);
  return DocumentRepositoryImpl(dataSource);
});

// Use case providers
final getAllDocumentsProvider = Provider<GetAllDocuments>((ref) {
  final repository = ref.watch(documentRepositoryProvider);
  return GetAllDocuments(repository);
});

final getDocumentByIdProvider = Provider<GetDocumentById>((ref) {
  final repository = ref.watch(documentRepositoryProvider);
  return GetDocumentById(repository);
});

final addDocumentProvider = Provider<AddDocument>((ref) {
  final repository = ref.watch(documentRepositoryProvider);
  return AddDocument(repository);
});

// State providers
final documentsProvider = FutureProvider<List<Document>>((ref) async {
  final useCase = ref.watch(getAllDocumentsProvider);
  final result = await useCase();
  return result.fold(
    (failure) => throw Exception(failure),
    (documents) => documents,
  );
});

final documentByIdProvider = FutureProvider.family<Document, int>((ref, id) async {
  final useCase = ref.watch(getDocumentByIdProvider);
  final result = await useCase(id);
  return result.fold(
    (failure) => throw Exception(failure),
    (document) => document,
  );
});

// Notifier for document operations
class DocumentNotifier extends StateNotifier<AsyncValue<List<Document>>> {
  final GetAllDocuments _getAllDocuments;
  final AddDocument _addDocument;

  DocumentNotifier(this._getAllDocuments, this._addDocument)
      : super(const AsyncValue.loading()) {
    loadDocuments();
  }

  Future<void> loadDocuments() async {
    state = const AsyncValue.loading();
    final result = await _getAllDocuments();
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (documents) => AsyncValue.data(documents),
    );
  }

  Future<void> addDocument(Document document) async {
    final result = await _addDocument(document);
    result.fold(
      (failure) => throw Exception(failure),
      (_) => loadDocuments(), // Reload documents after adding
    );
  }
}

final documentsNotifierProvider = StateNotifierProvider<DocumentNotifier, AsyncValue<List<Document>>>((ref) {
  final getAllDocuments = ref.watch(getAllDocumentsProvider);
  final addDocument = ref.watch(addDocumentProvider);
  return DocumentNotifier(getAllDocuments, addDocument);
}); 