// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bundle_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BundleGroup _$BundleGroupFromJson(Map<String, dynamic> json) => _BundleGroup(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  iconName: json['iconName'] as String?,
  colorHex: json['colorHex'] as String?,
  displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$BundleGroupToJson(_BundleGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'iconName': instance.iconName,
      'colorHex': instance.colorHex,
      'displayOrder': instance.displayOrder,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
