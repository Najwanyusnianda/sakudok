// lib/features/bundles/data/mappers/bundle_mapper.dart
import 'dart:convert';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart' as db;
import '../../domain/entities/bundle.dart';
import '../../../documents/data/mappers/document_mapper.dart';

class BundleMapper {
  static Bundle fromDb(db.Bundle dbBundle, {List<db.Document> documents = const []}) {
    return Bundle(
      id: dbBundle.id.toString(),
      name: dbBundle.name,
      description: dbBundle.description,
      template: dbBundle.template,
      isDefault: dbBundle.isDefault,
      documents: documents.map(DocumentMapper.fromDb).toList(),
      createdAt: dbBundle.createdAt,
      updatedAt: dbBundle.updatedAt,
      type: BundleType.manual, // Default for now, can be enhanced later
      isComplete: false, // Calculate based on template requirements
      requiredDocumentTypes: [], // Extract from template if needed
      suggestedDocumentTypes: [], // Extract from template if needed
    );
  }

  static db.BundlesCompanion toDb(Bundle domainBundle) {
    final id = int.tryParse(domainBundle.id);
    return db.BundlesCompanion(
      id: id != null ? Value(id) : const Value.absent(),
      name: Value(domainBundle.name),
      description: Value(domainBundle.description),
      template: Value(domainBundle.template),
      isDefault: Value(domainBundle.isDefault),
      createdAt: Value(domainBundle.createdAt),
      updatedAt: Value(domainBundle.updatedAt),
    );
  }
}
