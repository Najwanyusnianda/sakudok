import 'package:drift/drift.dart';
import 'bundles.dart';
import 'documents.dart';

class BundleDocuments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bundleId => integer().references(Bundles, #id)();
  IntColumn get documentId => integer().references(Documents, #id)();
  DateTimeColumn get addedAt => dateTime().withDefault(currentDateAndTime)();
}
