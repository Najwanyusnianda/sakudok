//lib/core/database/tables/app_database.dart
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sakudok/features/documents/domain/entities/document_type.dart';
import 'tables/documents.dart';
import 'tables/bundles.dart';
import 'tables/bundle_documents.dart';
import 'tables/bundle_groups.dart';
import 'tables/bundle_slots.dart';

part 'app_database.g.dart';

typedef DriftDocument = Document;

typedef DriftBundle = Bundle;

typedef DriftBundleDocument = BundleDocument;

typedef DriftBundleGroup = BundleGroup;

typedef DriftBundleSlot = BundleSlot;

@DriftDatabase(tables: [Documents, Bundles, BundleDocuments, BundleGroups, BundleSlots])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.addColumn(documents, documents.metadata);
          await m.createTable(bundleGroups);
          await m.addColumn(bundles, bundles.groupId);
        }
        if (from < 3) {
          // Create the new BundleSlots table
          await m.createTable(bundleSlots);
        }
        if (from < 4) {
          // Add new document type columns and migrate existing data
          await m.addColumn(documents, documents.mainType);
          await m.addColumn(documents, documents.subType);
          
          // Migrate existing data: map old 'type' to new mainType/subType structure
          await customStatement('''
            UPDATE documents 
            SET mainType = CASE 
              WHEN type IN ('ktp', 'sim', 'passport') THEN 'CARD'
              WHEN type IN ('ijazah', 'sertifikat') THEN 'DOCUMENT'
              ELSE 'OTHER'
            END,
            subType = CASE 
              WHEN type IN ('ktp', 'sim', 'passport', 'ijazah', 'sertifikat') THEN type
              ELSE 'lainnya'
            END
          ''');
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
    return await (select(documents)..where((d) => d.mainType.equals(type))).get();
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
    return results.map((row) => row.readTable(documents)).toList();
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

  // Bundle Slots operations
  Future<List<BundleSlot>> getBundleSlots(int bundleId) async {
    return await (select(bundleSlots)
          ..where((bs) => bs.bundleId.equals(bundleId))
          ..orderBy([(bs) => OrderingTerm.asc(bs.displayOrder)]))
        .get();
  }

  Future<BundleSlot?> getBundleSlotById(int id) async {
    return await (select(bundleSlots)..where((bs) => bs.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertBundleSlot(BundleSlotsCompanion bundleSlot) async {
    return await into(bundleSlots).insert(bundleSlot);
  }

  Future<bool> updateBundleSlot(BundleSlotsCompanion bundleSlot) async {
    return await update(bundleSlots).replace(bundleSlot);
  }

  Future<int> deleteBundleSlot(int id) async {
    return await (delete(bundleSlots)..where((bs) => bs.id.equals(id))).go();
  }

  Future<int> attachDocumentToSlot(int slotId, int documentId) async {
    return await (update(bundleSlots)..where((bs) => bs.id.equals(slotId)))
        .write(BundleSlotsCompanion(
          attachedDocId: Value(documentId),
          updatedAt: Value(DateTime.now()),
        ));
  }

  Future<int> detachDocumentFromSlot(int slotId) async {
    return await (update(bundleSlots)..where((bs) => bs.id.equals(slotId)))
        .write(BundleSlotsCompanion(
          attachedDocId: const Value(null),
          updatedAt: Value(DateTime.now()),
        ));
  }

  // Bundle Group operations
  Future<List<DriftBundleGroup>> getAllBundleGroups() async {
    return await (select(bundleGroups)..orderBy([(bg) => OrderingTerm.asc(bg.displayOrder)])).get();
  }

  Future<DriftBundleGroup?> getBundleGroupById(int id) async {
    return await (select(bundleGroups)..where((bg) => bg.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertBundleGroup(BundleGroupsCompanion bundleGroup) async {
    return await into(bundleGroups).insert(bundleGroup);
  }

  Future<bool> updateBundleGroup(BundleGroupsCompanion bundleGroup) async {
    return await update(bundleGroups).replace(bundleGroup);
  }

  Future<int> deleteBundleGroup(int id) async {
    // First, set groupId to null for all bundles in this group
    await (update(bundles)..where((b) => b.groupId.equals(id)))
        .write(BundlesCompanion(groupId: Value(null)));
    
    // Then delete the group
    return await (delete(bundleGroups)..where((bg) => bg.id.equals(id))).go();
  }

  Future<List<DriftBundle>> getBundlesByGroup(int? groupId) async {
    if (groupId == null) {
      return await (select(bundles)..where((b) => b.groupId.isNull())).get();
    } else {
      return await (select(bundles)..where((b) => b.groupId.equals(groupId))).get();
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'sakudok.db'));
    return NativeDatabase.createInBackground(file);
  });
}
