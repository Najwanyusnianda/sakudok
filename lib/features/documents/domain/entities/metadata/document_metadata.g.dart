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
  bloodType: json['bloodType'] as String?,
  address: json['address'] as String,
  rt: json['rt'] as String?,
  rw: json['rw'] as String?,
  kelurahan: json['kelurahan'] as String?,
  kecamatan: json['kecamatan'] as String?,
  religion: json['religion'] as String?,
  maritalStatus: json['maritalStatus'] as String?,
  occupation: json['occupation'] as String?,
  citizenship: json['citizenship'] as String?,
  issuedDate: json['issuedDate'] == null
      ? null
      : DateTime.parse(json['issuedDate'] as String),
  issuedBy: json['issuedBy'] as String?,
  expiryDate: json['expiryDate'] == null
      ? null
      : DateTime.parse(json['expiryDate'] as String),
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
      'issuedDate': instance.issuedDate?.toIso8601String(),
      'issuedBy': instance.issuedBy,
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'runtimeType': instance.$type,
    };

SIMMetadata _$SIMMetadataFromJson(Map<String, dynamic> json) => SIMMetadata(
  simNumber: json['simNumber'] as String,
  holderName: json['holderName'] as String,
  simType: json['simType'] as String,
  issuedDate: DateTime.parse(json['issuedDate'] as String),
  expiryDate: DateTime.parse(json['expiryDate'] as String),
  issuingOffice: json['issuingOffice'] as String?,
  address: json['address'] as String?,
  birthDate: json['birthDate'] == null
      ? null
      : DateTime.parse(json['birthDate'] as String),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$SIMMetadataToJson(SIMMetadata instance) =>
    <String, dynamic>{
      'simNumber': instance.simNumber,
      'holderName': instance.holderName,
      'simType': instance.simType,
      'issuedDate': instance.issuedDate.toIso8601String(),
      'expiryDate': instance.expiryDate.toIso8601String(),
      'issuingOffice': instance.issuingOffice,
      'address': instance.address,
      'birthDate': instance.birthDate?.toIso8601String(),
      'runtimeType': instance.$type,
    };

PassportMetadata _$PassportMetadataFromJson(Map<String, dynamic> json) =>
    PassportMetadata(
      passportNumber: json['passportNumber'] as String,
      holderName: json['holderName'] as String,
      nationality: json['nationality'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      birthPlace: json['birthPlace'] as String,
      gender: json['gender'] as String,
      issuedDate: DateTime.parse(json['issuedDate'] as String),
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      issuingAuthority: json['issuingAuthority'] as String?,
      placeOfIssue: json['placeOfIssue'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$PassportMetadataToJson(PassportMetadata instance) =>
    <String, dynamic>{
      'passportNumber': instance.passportNumber,
      'holderName': instance.holderName,
      'nationality': instance.nationality,
      'birthDate': instance.birthDate.toIso8601String(),
      'birthPlace': instance.birthPlace,
      'gender': instance.gender,
      'issuedDate': instance.issuedDate.toIso8601String(),
      'expiryDate': instance.expiryDate.toIso8601String(),
      'issuingAuthority': instance.issuingAuthority,
      'placeOfIssue': instance.placeOfIssue,
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
      candidateName: json['candidateName'] as String?,
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
      'candidateName': instance.candidateName,
      'runtimeType': instance.$type,
    };

TranscriptMetadata _$TranscriptMetadataFromJson(Map<String, dynamic> json) =>
    TranscriptMetadata(
      studentId: json['studentId'] as String,
      studentName: json['studentName'] as String,
      university: json['university'] as String,
      degree: json['degree'] as String,
      major: json['major'] as String,
      gpa: (json['gpa'] as num).toDouble(),
      graduationDate: DateTime.parse(json['graduationDate'] as String),
      issuedDate: json['issuedDate'] == null
          ? null
          : DateTime.parse(json['issuedDate'] as String),
      facultyDean: json['facultyDean'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$TranscriptMetadataToJson(TranscriptMetadata instance) =>
    <String, dynamic>{
      'studentId': instance.studentId,
      'studentName': instance.studentName,
      'university': instance.university,
      'degree': instance.degree,
      'major': instance.major,
      'gpa': instance.gpa,
      'graduationDate': instance.graduationDate.toIso8601String(),
      'issuedDate': instance.issuedDate?.toIso8601String(),
      'facultyDean': instance.facultyDean,
      'runtimeType': instance.$type,
    };

CVMetadata _$CVMetadataFromJson(Map<String, dynamic> json) => CVMetadata(
  fullName: json['fullName'] as String,
  profession: json['profession'] as String,
  email: json['email'] as String,
  phoneNumber: json['phoneNumber'] as String,
  lastUpdated: json['lastUpdated'] == null
      ? null
      : DateTime.parse(json['lastUpdated'] as String),
  summary: json['summary'] as String?,
  yearsOfExperience: (json['yearsOfExperience'] as num?)?.toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$CVMetadataToJson(CVMetadata instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'profession': instance.profession,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
      'summary': instance.summary,
      'yearsOfExperience': instance.yearsOfExperience,
      'runtimeType': instance.$type,
    };

CertificateMetadata _$CertificateMetadataFromJson(Map<String, dynamic> json) =>
    CertificateMetadata(
      certificateName: json['certificateName'] as String,
      holderName: json['holderName'] as String,
      issuingOrganization: json['issuingOrganization'] as String,
      issuedDate: DateTime.parse(json['issuedDate'] as String),
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      certificateNumber: json['certificateNumber'] as String?,
      level: json['level'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$CertificateMetadataToJson(
  CertificateMetadata instance,
) => <String, dynamic>{
  'certificateName': instance.certificateName,
  'holderName': instance.holderName,
  'issuingOrganization': instance.issuingOrganization,
  'issuedDate': instance.issuedDate.toIso8601String(),
  'expiryDate': instance.expiryDate?.toIso8601String(),
  'certificateNumber': instance.certificateNumber,
  'level': instance.level,
  'runtimeType': instance.$type,
};

DiplomaMetadata _$DiplomaMetadataFromJson(Map<String, dynamic> json) =>
    DiplomaMetadata(
      diplomaNumber: json['diplomaNumber'] as String,
      graduateName: json['graduateName'] as String,
      institution: json['institution'] as String,
      degree: json['degree'] as String,
      major: json['major'] as String,
      graduationDate: DateTime.parse(json['graduationDate'] as String),
      gpa: json['gpa'] as String?,
      honors: json['honors'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$DiplomaMetadataToJson(DiplomaMetadata instance) =>
    <String, dynamic>{
      'diplomaNumber': instance.diplomaNumber,
      'graduateName': instance.graduateName,
      'institution': instance.institution,
      'degree': instance.degree,
      'major': instance.major,
      'graduationDate': instance.graduationDate.toIso8601String(),
      'gpa': instance.gpa,
      'honors': instance.honors,
      'runtimeType': instance.$type,
    };

UnknownMetadata _$UnknownMetadataFromJson(Map<String, dynamic> json) =>
    UnknownMetadata(
      json['data'] as Map<String, dynamic>,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$UnknownMetadataToJson(UnknownMetadata instance) =>
    <String, dynamic>{'data': instance.data, 'runtimeType': instance.$type};
