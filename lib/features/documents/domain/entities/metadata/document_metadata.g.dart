// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KTPMetadata _$KTPMetadataFromJson(Map<String, dynamic> json) => KTPMetadata(
  nik: json['nik'] as String,
  fullName: json['fullName'] as String,
  birthPlace: json['birthPlace'] as String,
  birthDate: DateTime.parse(json['birthDate'] as String),
  gender: json['gender'] as String,
  bloodType: json['bloodType'] as String,
  address: json['address'] as String,
  rt: json['rt'] as String,
  rw: json['rw'] as String,
  kelurahan: json['kelurahan'] as String,
  kecamatan: json['kecamatan'] as String,
  religion: json['religion'] as String,
  maritalStatus: json['maritalStatus'] as String,
  occupation: json['occupation'] as String,
  citizenship: json['citizenship'] as String,
  issuedDate: DateTime.parse(json['issuedDate'] as String),
  issuedBy: json['issuedBy'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$KTPMetadataToJson(KTPMetadata instance) =>
    <String, dynamic>{
      'nik': instance.nik,
      'fullName': instance.fullName,
      'birthPlace': instance.birthPlace,
      'birthDate': instance.birthDate.toIso8601String(),
      'gender': instance.gender,
      'bloodType': instance.bloodType,
      'address': instance.address,
      'rt': instance.rt,
      'rw': instance.rw,
      'kelurahan': instance.kelurahan,
      'kecamatan': instance.kecamatan,
      'religion': instance.religion,
      'maritalStatus': instance.maritalStatus,
      'occupation': instance.occupation,
      'citizenship': instance.citizenship,
      'issuedDate': instance.issuedDate.toIso8601String(),
      'issuedBy': instance.issuedBy,
      'runtimeType': instance.$type,
    };

IELTSMetadata _$IELTSMetadataFromJson(Map<String, dynamic> json) =>
    IELTSMetadata(
      candidateNumber: json['candidateNumber'] as String,
      testReportNumber: json['testReportNumber'] as String,
      testDate: DateTime.parse(json['testDate'] as String),
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      overallBand: (json['overallBand'] as num).toDouble(),
      listeningScore: (json['listeningScore'] as num).toDouble(),
      readingScore: (json['readingScore'] as num).toDouble(),
      writingScore: (json['writingScore'] as num).toDouble(),
      speakingScore: (json['speakingScore'] as num).toDouble(),
      testCenter: json['testCenter'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$IELTSMetadataToJson(IELTSMetadata instance) =>
    <String, dynamic>{
      'candidateNumber': instance.candidateNumber,
      'testReportNumber': instance.testReportNumber,
      'testDate': instance.testDate.toIso8601String(),
      'expiryDate': instance.expiryDate.toIso8601String(),
      'overallBand': instance.overallBand,
      'listeningScore': instance.listeningScore,
      'readingScore': instance.readingScore,
      'writingScore': instance.writingScore,
      'speakingScore': instance.speakingScore,
      'testCenter': instance.testCenter,
      'runtimeType': instance.$type,
    };

UnknownMetadata _$UnknownMetadataFromJson(Map<String, dynamic> json) =>
    UnknownMetadata(
      json['data'] as Map<String, dynamic>,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$UnknownMetadataToJson(UnknownMetadata instance) =>
    <String, dynamic>{'data': instance.data, 'runtimeType': instance.$type};
