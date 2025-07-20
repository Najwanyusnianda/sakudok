// lib/features/documents/data/mappers/document_mapper.dart
import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart'; // Import for debugPrint
import '../../../../core/database/app_database.dart' as db;
import '../../domain/entities/document.dart' as domain;
import '../../domain/entities/metadata/document_metadata.dart';

class DocumentMapper {
  /// Maps a database row (`db.DriftDocument`) to a domain entity (`domain.Document`).
  static domain.Document fromDb(db.DriftDocument dbDoc) {
    // --- START DEBUGGING ---
    // Add a try-catch block to isolate errors to a specific document record.
    try {
      // Print the raw values from the database before any processing.
      debugPrint("--- Mapping Document ID: ${dbDoc.id} ---");
      debugPrint("Raw 'tags' from DB: ${dbDoc.tags}");
      debugPrint("Raw 'filePaths' from DB: ${dbDoc.filePaths}");
      debugPrint("Raw 'metadata' from DB: ${dbDoc.metadata}");

      // Directly decode the JSON strings from the database.
      // The error is likely happening in one of these three lines if a field
      // contains an invalid JSON string (e.g., an empty string "" or "null").
      final tags = (json.decode(dbDoc.tags ?? '[]') as List).cast<String>();
      final filePaths = (json.decode(dbDoc.filePaths) as List).cast<String>();
      final metadata = DocumentMetadata.fromJson(json.decode(dbDoc.metadata));
      
      debugPrint("--- Successfully mapped Document ID: ${dbDoc.id} ---");

      return domain.Document(
        id: dbDoc.id.toString(),
        title: dbDoc.title,
        description: dbDoc.description,
        mainType: dbDoc.mainType,
        subType: dbDoc.subType,
        createdAt: dbDoc.createdAt,
        updatedAt: dbDoc.updatedAt,
        
        // Use the directly decoded values.
        tags: tags,
        filePaths: filePaths,
        metadata: metadata,

        // These fields are not in the database schema yet, so they are set to default values.
        thumbnail: null,
        expiryDate: null,
        isFavorite: false,
        ocrText: null,
        bundleCount: 0,
        extractedData: {},
      );
    } catch (e, stackTrace) {
        // This will catch the error and tell you exactly which document failed.
        debugPrint("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        debugPrint("CRITICAL ERROR: FAILED TO MAP DOCUMENT WITH ID: ${dbDoc.id}.");
        debugPrint("The record with this ID in your database has corrupt or unexpected data.");
        debugPrint("Error: $e");
        debugPrint("StackTrace: $stackTrace");
        debugPrint("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        // Re-throw the error to ensure the application's error handling still works.
        rethrow;
    }
    // --- END DEBUGGING ---
  }

  /// Maps a domain entity (`domain.Document`) to a database companion (`db.DocumentsCompanion`) for writing.
  static db.DocumentsCompanion toDb(domain.Document domainDoc) {
    final id = int.tryParse(domainDoc.id);
    return db.DocumentsCompanion(
      id: id != null ? Value(id) : const Value.absent(),
      title: Value(domainDoc.title),
      description: Value(domainDoc.description),
      mainType: Value(domainDoc.mainType),
      subType: Value(domainDoc.subType),
      tags: Value(json.encode(domainDoc.tags)),
      createdAt: Value(domainDoc.createdAt),
      updatedAt: Value(domainDoc.updatedAt),
      metadata: Value(json.encode(domainDoc.metadata.toJson())),
      filePaths: Value(json.encode(domainDoc.filePaths)),
    );
  }
}
