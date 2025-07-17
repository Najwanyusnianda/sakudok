// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Document _$DocumentFromJson(Map<String, dynamic> json) => _Document(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  thumbnail: json['thumbnail'] as String?,
  type: $enumDecode(_$DocumentTypeEnumMap, json['type']),
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

Map<String, dynamic> _$DocumentToJson(_Document instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'thumbnail': instance.thumbnail,
  'type': _$DocumentTypeEnumMap[instance.type]!,
  'tags': instance.tags,
  'expiryDate': instance.expiryDate?.toIso8601String(),
  'isFavorite': instance.isFavorite,
  'bundleCount': instance.bundleCount,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'filePaths': instance.filePaths,
  'ocrText': instance.ocrText,
  'metadata': instance.metadata,
  'extractedData': instance.extractedData,
};

const _$DocumentTypeEnumMap = {
  DocumentType.ktp: 'ktp',
  DocumentType.sim: 'sim',
  DocumentType.passport: 'passport',
  DocumentType.ijazah: 'ijazah',
  DocumentType.sertifikat: 'sertifikat',
  DocumentType.lainnya: 'lainnya',
};
