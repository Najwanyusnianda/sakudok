//lib/features/documents/data/models/document_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/document.dart';
import '../../domain/entities/document_type.dart';
import '../../domain/entities/metadata/document_metadata.dart';

part 'document_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DocumentModel {
  final String id;
  final String title;
  final String? description;
  final String? thumbnail;
  final DocumentType type;
  final List<String> tags;
  final DateTime? expiryDate;
  final bool isFavorite;
  final int bundleCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  // --- RENAMED THIS FIELD ---
  final List<String> filePaths;
  final String? ocrText;
  final DocumentMetadata metadata;
  final Map<String, dynamic> extractedData;

  DocumentModel({
    required this.id,
    required this.title,
    this.description,
    this.thumbnail,
    required this.type,
    this.tags = const [],
    this.expiryDate,
    this.isFavorite = false,
    this.bundleCount = 0,
    required this.createdAt,
    required this.updatedAt,
    // --- AND RENAMED THIS PARAMETER ---
    this.filePaths = const [],
    this.ocrText,
    required this.metadata,
    this.extractedData = const {},
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) => _$DocumentModelFromJson(json);
  Map<String, dynamic> toJson() => _$DocumentModelToJson(this);

  factory DocumentModel.fromEntity(Document doc) => DocumentModel(
        id: doc.id,
        title: doc.title,
        description: doc.description,
        thumbnail: doc.thumbnail,
        type: doc.type,
        tags: doc.tags,
        expiryDate: doc.expiryDate,
        isFavorite: doc.isFavorite,
        bundleCount: doc.bundleCount,
        createdAt: doc.createdAt,
        updatedAt: doc.updatedAt,
        // This line is now correct because the constructor parameter was renamed.
        filePaths: doc.filePaths,
        ocrText: doc.ocrText,
        metadata: doc.metadata,
        extractedData: doc.extractedData,
      );

  Document toEntity() => Document(
        id: id,
        title: title,
        description: description,
        thumbnail: thumbnail,
        type: type,
        tags: tags,
        expiryDate: expiryDate,
        isFavorite: isFavorite,
        bundleCount: bundleCount,
        createdAt: createdAt,
        updatedAt: updatedAt,
        // This line is now correct because the class field was renamed.
        filePaths: filePaths,
        ocrText: ocrText,
        metadata: metadata,
        extractedData: extractedData,
      );
}
