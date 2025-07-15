// lib/features/bundles/data/datasources/bundle_local_datasource.dart
import '../../../../core/database/app_database.dart' as db;

abstract class BundleLocalDataSource {
  Future<List<db.DriftBundle>> getAllBundles();
  Future<db.DriftBundle?> getBundleById(int id);
  Future<int> insertBundle(db.BundlesCompanion bundle);
  Future<void> updateBundle(db.BundlesCompanion bundle);
  Future<void> deleteBundle(int id);
  
  // Bundle-Document relationships
  Future<void> addDocumentToBundle(int bundleId, int documentId);
  Future<void> removeDocumentFromBundle(int bundleId, int documentId);
  Future<List<db.DriftDocument>> getBundleDocuments(int bundleId);
  Future<List<db.DriftBundleDocument>> getAllBundleDocuments();
}

class BundleLocalDataSourceImpl implements BundleLocalDataSource {
  final db.AppDatabase _database;

  BundleLocalDataSourceImpl(this._database);

  @override
  Future<List<db.DriftBundle>> getAllBundles() async {
    return await _database.getAllBundles();
  }

  @override
  Future<db.DriftBundle?> getBundleById(int id) async {
    return await _database.getBundleById(id);
  }

  @override
  Future<int> insertBundle(db.BundlesCompanion bundle) async {
    return await _database.insertBundle(bundle);
  }

  @override
  Future<void> updateBundle(db.BundlesCompanion bundle) async {
    await _database.updateBundle(bundle);
  }

  @override
  Future<void> deleteBundle(int id) async {
    await _database.deleteBundle(id);
  }

  @override
  Future<void> addDocumentToBundle(int bundleId, int documentId) async {
    await _database.addDocumentToBundle(documentId, bundleId); // Note: parameters swapped in DB
  }

  @override
  Future<void> removeDocumentFromBundle(int bundleId, int documentId) async {
    await _database.removeDocumentFromBundle(documentId, bundleId); // Note: parameters swapped in DB
  }

  @override
  Future<List<db.DriftDocument>> getBundleDocuments(int bundleId) async {
    return await _database.getDocumentsByBundle(bundleId);
  }

  @override
  Future<List<db.DriftBundleDocument>> getAllBundleDocuments() async {
    // This method doesn't exist in the database yet, let's create a simple implementation
    return []; // TODO: Implement in database if needed
  }
}
