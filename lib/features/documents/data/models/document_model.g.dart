// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentModel _$DocumentModelFromJson(
  Map<String, dynamic> json,
) => DocumentModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  thumbnail: json['thumbnail'] as String?,
  mainType: $enumDecode(_$MainDocumentTypeEnumMap, json['mainType']),
  subType: $enumDecodeNullable(_$DocumentSubTypeEnumMap, json['subType']),
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  expiryDate: json['expiryDate'] == null
      ? null
      : DateTime.parse(json['expiryDate'] as String),
  isFavorite: json['isFavorite'] as bool? ?? false,
  bundleCount: (json['bundleCount'] as num?)?.toInt() ?? 0,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  filePaths:
      (json['filePaths'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  ocrText: json['ocrText'] as String?,
  metadata: DocumentMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
  extractedData: json['extractedData'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$DocumentModelToJson(DocumentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
      'mainType': _$MainDocumentTypeEnumMap[instance.mainType]!,
      'subType': _$DocumentSubTypeEnumMap[instance.subType],
      'tags': instance.tags,
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'isFavorite': instance.isFavorite,
      'bundleCount': instance.bundleCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'filePaths': instance.filePaths,
      'ocrText': instance.ocrText,
      'metadata': instance.metadata.toJson(),
      'extractedData': instance.extractedData,
    };

const _$MainDocumentTypeEnumMap = {
  MainDocumentType.CARD: 'CARD',
  MainDocumentType.DOCUMENT: 'DOCUMENT',
  MainDocumentType.OTHER: 'OTHER',
};

const _$DocumentSubTypeEnumMap = {
  DocumentSubType.ktp: 'ktp',
  DocumentSubType.sim: 'sim',
  DocumentSubType.passport: 'passport',
  DocumentSubType.ijazah: 'ijazah',
  DocumentSubType.sertifikat: 'sertifikat',
  DocumentSubType.lainnya: 'lainnya',
};
