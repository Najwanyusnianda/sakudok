///lib/core/database/tables/documents.dart
import 'package:drift/drift.dart';
import '../../../features/documents/domain/entities/document_type.dart';

class Documents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get mainType => text().map(const MainDocumentTypeConverter())();
  TextColumn get subType => text().map(const DocumentSubTypeConverter()).nullable()();
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

/// Type converter for MainDocumentType enum
class MainDocumentTypeConverter extends TypeConverter<MainDocumentType, String> {
  const MainDocumentTypeConverter();

  @override
  MainDocumentType fromSql(String fromDb) {
    return MainDocumentType.values.firstWhere(
      (type) => type.name == fromDb,
      orElse: () => MainDocumentType.OTHER,
    );
  }

  @override
  String toSql(MainDocumentType value) {
    return value.name;
  }
}

/// Type converter for DocumentSubType enum
class DocumentSubTypeConverter extends TypeConverter<DocumentSubType?, String?> {
  const DocumentSubTypeConverter();

  @override
  DocumentSubType? fromSql(String? fromDb) {
    if (fromDb == null) return null;
    return DocumentSubType.values.firstWhere(
      (type) => type.name == fromDb,
      orElse: () => DocumentSubType.lainnya,
    );
  }

  @override
  String? toSql(DocumentSubType? value) {
    return value?.name;
  }
}
