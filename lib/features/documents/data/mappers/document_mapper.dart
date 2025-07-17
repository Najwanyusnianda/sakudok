import 'dart:convert';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart' as db;
import '../../domain/entities/document.dart' as domain;
import '../../domain/entities/document_type.dart';
import '../../domain/entities/metadata/document_metadata.dart';

class DocumentMapper {
  /// Maps a database row (`db.DriftDocument`) to a domain entity (`domain.Document`).
  static domain.Document fromDb(db.DriftDocument dbDoc) {
    return domain.Document(
      id: dbDoc.id.toString(),
      title: dbDoc.title,
      description: dbDoc.description,
      type: DocumentType.values.byName(dbDoc.type),
      tags: dbDoc.tags != null ? (json.decode(dbDoc.tags!) as List).cast<String>() : [],
      createdAt: dbDoc.createdAt,
      updatedAt: dbDoc.updatedAt,
      metadata: DocumentMetadata.fromJson(json.decode(dbDoc.metadata)),
      
      // --- FIX: Use the new 'filePaths' field name from the database object ---
      // This correctly populates the filePaths list when loading a document.
      filePaths: dbDoc.filePaths != null ? (json.decode(dbDoc.filePaths!) as List).cast<String>() : [],

      // These fields are not in the database schema yet, so they are set to default values.
      thumbnail: null,
      expiryDate: null,
      isFavorite: false,
      ocrText: null,
      bundleCount: 0,
      extractedData: {},
    );
  }

  /// Maps a domain entity (`domain.Document`) to a database companion (`db.DocumentsCompanion`) for writing.
  static db.DocumentsCompanion toDb(domain.Document domainDoc) {
    final id = int.tryParse(domainDoc.id);
    return db.DocumentsCompanion(
      id: id != null ? Value(id) : const Value.absent(),
      title: Value(domainDoc.title),
      description: Value(domainDoc.description),
      type: Value(domainDoc.type.name),
      tags: Value(json.encode(domainDoc.tags)),
      createdAt: Value(domainDoc.createdAt),
      updatedAt: Value(domainDoc.updatedAt),
      metadata: Value(json.encode(domainDoc.metadata.toJson())),

      // --- FIX: Use the new 'filePaths' field name from the domain entity ---
      // This ensures the list of file paths is saved correctly.
      filePaths: Value(json.encode(domainDoc.filePaths)),
    );
  }
}
