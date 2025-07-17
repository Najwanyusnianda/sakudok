import 'package:drift/drift.dart';

class Documents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get type => text()();
  TextColumn get filePaths => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  
  // Core fields
  TextColumn get description => text().nullable()();
  BoolColumn get hasReminder => boolean().withDefault(const Constant(false))();
  DateTimeColumn get reminderDate => dateTime().nullable()();
  TextColumn get reminderNote => text().nullable()();
  BoolColumn get isEncrypted => boolean().withDefault(const Constant(false))();
  TextColumn get tags => text().nullable()();
  IntColumn get bundleId => integer().nullable()();
  
  // Flexible metadata for all document types (JSON)
  TextColumn get metadata => text().withDefault(const Constant('{}'))();
}
