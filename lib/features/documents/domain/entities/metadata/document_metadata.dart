// lib/features/documents/domain/entities/metadata/document_metadata.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_metadata.freezed.dart';
part 'document_metadata.g.dart';

@freezed
abstract class DocumentMetadata with _$DocumentMetadata {
  // KTP - Indonesian Identity Card (Smart metadata for intelligent features)
  const factory DocumentMetadata.ktp({
    required String nik,
    required String fullName,
    required String birthPlace,
    required DateTime birthDate,
    required String gender,
    String? bloodType,
    required String address,
    String? rt,
    String? rw,
    String? kelurahan,
    String? kecamatan,
    String? religion,
    String? maritalStatus,
    String? occupation,
    String? citizenship,
    DateTime? issuedDate,
    String? issuedBy,
    DateTime? expiryDate, // For smart reminders - KTP doesn't expire but useful for tracking
  }) = KTPMetadata;

  // SIM - Driving License (Smart metadata for renewal reminders)
  const factory DocumentMetadata.sim({
    required String simNumber,
    required String holderName,
    required String simType, // A, B1, B2, C
    required DateTime issuedDate,
    required DateTime expiryDate, // Critical for 30-day renewal reminders
    String? issuingOffice,
    String? address,
    DateTime? birthDate,
  }) = SIMMetadata;

  // Passport (Smart metadata for travel and renewal planning)
  const factory DocumentMetadata.passport({
    required String passportNumber,
    required String holderName,
    required String nationality,
    required DateTime birthDate,
    required String birthPlace,
    required String gender,
    required DateTime issuedDate,
    required DateTime expiryDate, // Critical for 6-month travel reminders
    String? issuingAuthority,
    String? placeOfIssue,
  }) = PassportMetadata;

  // IELTS Certificate (Smart metadata for score tracking and validity)
  const factory DocumentMetadata.ielts({
    required String candidateNumber,
    required String testReportNumber,
    required DateTime testDate,
    required DateTime expiryDate, // IELTS valid for 2 years
    required double overallBand,
    required double listeningScore,
    required double readingScore,
    required double writingScore,
    required double speakingScore,
    required String testCenter,
    String? candidateName,
  }) = IELTSMetadata;

  // University Transcript (For education bundles)
  const factory DocumentMetadata.transcript({
    required String studentId,
    required String studentName,
    required String university,
    required String degree,
    required String major,
    required double gpa,
    required DateTime graduationDate,
    DateTime? issuedDate,
    String? facultyDean,
  }) = TranscriptMetadata;

  // CV/Resume (For job application bundles)
  const factory DocumentMetadata.cv({
    required String fullName,
    required String profession,
    required String email,
    required String phoneNumber,
    DateTime? lastUpdated,
    String? summary,
    int? yearsOfExperience,
  }) = CVMetadata;

  // Certificate (Generic for various certifications)
  const factory DocumentMetadata.certificate({
    required String certificateName,
    required String holderName,
    required String issuingOrganization,
    required DateTime issuedDate,
    DateTime? expiryDate, // Some certificates expire
    String? certificateNumber,
    String? level, // Basic, Intermediate, Advanced
  }) = CertificateMetadata;

  // Ijazah/Diploma (Education credentials)
  const factory DocumentMetadata.diploma({
    required String diplomaNumber,
    required String graduateName,
    required String institution,
    required String degree,
    required String major,
    required DateTime graduationDate,
    String? gpa,
    String? honors, // Cum Laude, Magna Cum Laude, etc.
  }) = DiplomaMetadata;

  // Fallback for unknown documents
  const factory DocumentMetadata.unknown(Map<String, dynamic> data) = UnknownMetadata;

  factory DocumentMetadata.fromJson(Map<String, dynamic> json) => _$DocumentMetadataFromJson(json);
} 