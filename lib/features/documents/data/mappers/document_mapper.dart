import 'dart:convert';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart' as db;
import '../../domain/entities/document.dart' as domain;
import '../../domain/entities/document_type.dart';
import '../../domain/entities/metadata/document_metadata.dart';

class DocumentMapper {
  static domain.Document fromDb(db.Document dbDoc) {
    return domain.Document(
      id: dbDoc.id.toString(),
      title: dbDoc.title,
      description: dbDoc.description,
      thumbnail: null, // Not in database schema yet
      type: DocumentType.values.byName(dbDoc.type),
      tags: dbDoc.tags != null ? (json.decode(dbDoc.tags!) as List).cast<String>() : [],
      expiryDate: null, // Not in database schema yet
      isFavorite: false, // Not in database schema yet
      createdAt: dbDoc.createdAt,
      updatedAt: dbDoc.updatedAt,
      images: [], // Not in database schema yet
      ocrText: null, // Not in database schema yet
      metadata: DocumentMetadata.fromJson(json.decode(dbDoc.metadata)),
      bundleCount: 0, // Not in database schema yet
      extractedData: {}, // Not in database schema yet
    );
  }

  static db.DocumentsCompanion toDb(domain.Document domainDoc) {
    final id = int.tryParse(domainDoc.id);
    return db.DocumentsCompanion(
      id: id != null ? Value(id) : const Value.absent(),
      title: Value(domainDoc.title),
      description: Value(domainDoc.description),
      type: Value(domainDoc.type.name),
      filePath: const Value(''), // Default empty, will be updated when file is saved
      tags: Value(json.encode(domainDoc.tags)),
      createdAt: Value(domainDoc.createdAt),
      updatedAt: Value(domainDoc.updatedAt),
      metadata: Value(json.encode(domainDoc.metadata.toJson())),
      // Fields not yet in database schema:
      // thumbnail, expiryDate, isFavorite, bundleCount, images, ocrText, extractedData
    );
  }
} 