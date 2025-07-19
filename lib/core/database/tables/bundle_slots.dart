//lib/core/database/tables/bundle_slots.dart
import 'package:drift/drift.dart';
import 'bundles.dart';
import 'documents.dart';

class BundleSlots extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bundleId => integer().references(Bundles, #id)();
  TextColumn get requirementName => text().withLength(min: 1, max: 255)();
  TextColumn get requiredDocType => text().withLength(min: 1, max: 100)();
  IntColumn get attachedDocId => integer().references(Documents, #id).nullable()();
  BoolColumn get isRequired => boolean().withDefault(const Constant(true))();
  IntColumn get displayOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
