// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Document _$DocumentFromJson(Map<String, dynamic> json) => _Document(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  type: json['type'] as String,
  filePath: json['filePath'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  description: json['description'] as String?,
  hasReminder: json['hasReminder'] as bool? ?? false,
  reminderDate: json['reminderDate'] == null
      ? null
      : DateTime.parse(json['reminderDate'] as String),
  reminderNote: json['reminderNote'] as String?,
  isEncrypted: json['isEncrypted'] as bool? ?? false,
  tags: json['tags'] as String?,
  bundleId: (json['bundleId'] as num?)?.toInt(),
  metadata:
      json['metadata'] as Map<String, dynamic>? ?? const <String, dynamic>{},
);

Map<String, dynamic> _$DocumentToJson(_Document instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'type': instance.type,
  'filePath': instance.filePath,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'description': instance.description,
  'hasReminder': instance.hasReminder,
  'reminderDate': instance.reminderDate?.toIso8601String(),
  'reminderNote': instance.reminderNote,
  'isEncrypted': instance.isEncrypted,
  'tags': instance.tags,
  'bundleId': instance.bundleId,
  'metadata': instance.metadata,
};
