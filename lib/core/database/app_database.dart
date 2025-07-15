//lib/core/database/tables/app_database.dart
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables/documents.dart';
import 'tables/bundles.dart';
import 'tables/bundle_documents.dart';

part 'app_database.g.dart';

typedef DriftDocument = Document;

typedef DriftBundle = Bundle;

typedef DriftBundleDocument = BundleDocument;

@DriftDatabase(tables: [Documents, Bundles, BundleDocuments])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.addColumn(documents, documents.metadata);
        }
      },
    );
  }

  // Document operations (return DriftDocument, not domain)
  Future<List<DriftDocument>> getAllDocuments() async {
    return await select(documents).get();
  }

  Future<DriftDocument?> getDocumentById(int id) async {
    return await (select(documents)..where((d) => d.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertDocument(DocumentsCompanion document) async {
    return await into(documents).insert(document);
  }

  Future<bool> updateDocument(DocumentsCompanion document) async {
    return await update(documents).replace(document);
  }

  Future<int> deleteDocument(int id) async {
    return await (delete(documents)..where((d) => d.id.equals(id))).go();
  }

  Future<List<DriftDocument>> searchDocuments(String query) async {
    return await (select(documents)
      ..where((d) => d.title.contains(query) | d.description.contains(query)))
      .get();
  }

  Future<List<DriftDocument>> getDocumentsByType(String type) async {
    return await (select(documents)..where((d) => d.type.equals(type))).get();
  }

  Future<List<DriftDocument>> getExpiringDocuments(int daysThreshold) async {
    final thresholdDate = DateTime.now().add(Duration(days: daysThreshold));
    return await (select(documents)
      ..where((d) => d.reminderDate.isSmallerOrEqualValue(thresholdDate) & d.reminderDate.isBiggerOrEqualValue(DateTime.now())))
      .get();
  }

  Future<List<DriftDocument>> getDocumentsWithReminders() async {
    return await (select(documents)..where((d) => d.hasReminder.equals(true))).get();
  }

  // Bundle operations
  Future<List<DriftBundle>> getAllBundles() async {
    return await select(bundles).get();
  }

  Future<DriftBundle?> getBundleById(int id) async {
    return await (select(bundles)..where((b) => b.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertBundle(BundlesCompanion bundle) async {
    return await into(bundles).insert(bundle);
  }

  Future<bool> updateBundle(BundlesCompanion bundle) async {
    return await update(bundles).replace(bundle);
  }

  Future<int> deleteBundle(int id) async {
    return await (delete(bundles)..where((b) => b.id.equals(id))).go();
  }

  // Bundle-Document operations
  Future<List<DriftDocument>> getDocumentsByBundle(int bundleId) async {
    final query = select(documents).join([
      innerJoin(bundleDocuments, bundleDocuments.documentId.equalsExp(documents.id)),
    ])..where(bundleDocuments.bundleId.equals(bundleId));

    final results = await query.get();
    return results.map((row) => row.readTable(documents) as DriftDocument).toList();
  }

  Future<int> addDocumentToBundle(int documentId, int bundleId) async {
    return await into(bundleDocuments).insert(
      BundleDocumentsCompanion.insert(
        documentId: documentId,
        bundleId: bundleId,
      ),
    );
  }

  Future<int> removeDocumentFromBundle(int documentId, int bundleId) async {
    return await (delete(bundleDocuments)
          ..where((bd) => bd.documentId.equals(documentId) & bd.bundleId.equals(bundleId)))
        .go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'sakudok.db'));
    return NativeDatabase.createInBackground(file);
  });
}
