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
      thumbnail: dbDoc.thumbnail,
      type: DocumentType.values.byName(dbDoc.type),
      tags: dbDoc.tags != null ? (json.decode(dbDoc.tags!) as List).cast<String>() : [],
      expiryDate: dbDoc.expiryDate,
      isFavorite: dbDoc.isFavorite,
      createdAt: dbDoc.createdAt,
      updatedAt: dbDoc.updatedAt,
      images: dbDoc.images != null ? (json.decode(dbDoc.images!) as List).cast<String>() : [],
      ocrText: dbDoc.ocrText,
      metadata: DocumentMetadata.fromJson(json.decode(dbDoc.metadata)),
      bundleCount: dbDoc.bundleCount,
      extractedData: dbDoc.extractedData != null ? json.decode(dbDoc.extractedData!) as Map<String, dynamic> : {},
    );
  }

  static db.DocumentsCompanion toDb(domain.Document domainDoc) {
    final id = int.tryParse(domainDoc.id);
    return db.DocumentsCompanion(
      id: id != null ? Value(id) : const Value.absent(),
      title: Value(domainDoc.title),
      description: Value(domainDoc.description),
      thumbnail: Value(domainDoc.thumbnail),
      type: Value(domainDoc.type.name),
      tags: Value(json.encode(domainDoc.tags)),
      expiryDate: Value(domainDoc.expiryDate),
      isFavorite: Value(domainDoc.isFavorite),
      bundleCount: Value(domainDoc.bundleCount),
      createdAt: Value(domainDoc.createdAt),
      updatedAt: Value(domainDoc.updatedAt),
      images: Value(json.encode(domainDoc.images)),
      ocrText: Value(domainDoc.ocrText),
      metadata: Value(json.encode(domainDoc.metadata.toJson())),
      extractedData: Value(json.encode(domainDoc.extractedData)),
    );
  }
} 