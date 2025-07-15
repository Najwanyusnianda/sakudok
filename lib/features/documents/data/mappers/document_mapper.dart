import 'dart:convert';
import 'package:drift/drift.dart';
import '../../domain/entities/document.dart' as domain;
import '../../../../core/database/app_database.dart' as db;

class DocumentMapper {
  /// Convert database row to domain entity
  static domain.Document fromDb(db.Document driftDoc) {
    Map<String, dynamic> metadata = {};
    try {
      metadata = driftDoc.metadata.isNotEmpty 
          ? Map<String, dynamic>.from(jsonDecode(driftDoc.metadata)) 
          : {};
    } catch (e) {
      metadata = {};
    }
    
    return domain.Document(
      id: driftDoc.id,
      title: driftDoc.title,
      type: driftDoc.type,
      filePath: driftDoc.filePath,
      createdAt: driftDoc.createdAt,
      updatedAt: driftDoc.updatedAt,
      description: driftDoc.description,
      hasReminder: driftDoc.hasReminder,
      reminderDate: driftDoc.reminderDate,
      reminderNote: driftDoc.reminderNote,
      isEncrypted: driftDoc.isEncrypted,
      tags: driftDoc.tags,
      bundleId: driftDoc.bundleId,
      metadata: metadata,
    );
  }

  /// Convert domain entity to database companion for insert
  static db.DocumentsCompanion toDbInsert(domain.Document document) {
    return db.DocumentsCompanion.insert(
      title: document.title,
      type: document.type,
      filePath: document.filePath,
      description: Value(document.description),
      hasReminder: Value(document.hasReminder),
      reminderDate: Value(document.reminderDate),
      reminderNote: Value(document.reminderNote),
      isEncrypted: Value(document.isEncrypted),
      tags: Value(document.tags),
      bundleId: Value(document.bundleId),
      metadata: Value(document.metadata.isNotEmpty ? jsonEncode(document.metadata) : '{}'),
    );
  }

  /// Convert domain entity to database companion for update
  static db.DocumentsCompanion toDbUpdate(domain.Document document) {
    return db.DocumentsCompanion(
      id: Value(document.id),
      title: Value(document.title),
      type: Value(document.type),
      filePath: Value(document.filePath),
      description: Value(document.description),
      hasReminder: Value(document.hasReminder),
      reminderDate: Value(document.reminderDate),
      reminderNote: Value(document.reminderNote),
      isEncrypted: Value(document.isEncrypted),
      tags: Value(document.tags),
      bundleId: Value(document.bundleId),
      metadata: Value(document.metadata.isNotEmpty ? jsonEncode(document.metadata) : '{}'),
      updatedAt: Value(DateTime.now()),
    );
  }

  /// Convert list of database rows to list of domain entities
  static List<domain.Document> fromDbList(List<db.Document> driftDocs) {
    return driftDocs.map((driftDoc) => fromDb(driftDoc)).toList();
  }
} 