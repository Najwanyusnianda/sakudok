// lib/features/documents/domain/entities/document.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'metadata/document_metadata.dart';
import 'document_type.dart';

part 'document.freezed.dart';
part 'document.g.dart';

@freezed
abstract class Document with _$Document {
  const factory Document({
    required String id,
    required String title,
    String? description,
    String? thumbnail,
    required MainDocumentType mainType,
    DocumentSubType? subType,
    @Default([]) List<String> tags,
    DateTime? expiryDate,
    @Default(false) bool isFavorite,
    @Default(0) int bundleCount,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<String> filePaths,
    String? ocrText,
    required DocumentMetadata metadata,
    @Default({}) Map<String, dynamic> extractedData,
  }) = _Document;

  factory Document.fromJson(Map<String, dynamic> json) => _$DocumentFromJson(json);
}
