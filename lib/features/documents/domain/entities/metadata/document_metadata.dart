// lib/features/documents/domain/entities/metadata/document_metadata.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_metadata.freezed.dart';
part 'document_metadata.g.dart';

@freezed
abstract class DocumentMetadata with _$DocumentMetadata {
  // KTP
  const factory DocumentMetadata.ktp({
    required String nik,
    required String fullName,
    required String birthPlace,
    required DateTime birthDate,
    required String gender,
    required String bloodType,
    required String address,
    required String rt,
    required String rw,
    required String kelurahan,
    required String kecamatan,
    required String religion,
    required String maritalStatus,
    required String occupation,
    required String citizenship,
    required DateTime issuedDate,
    required String issuedBy,
  }) = KTPMetadata;

  // IELTS
  const factory DocumentMetadata.ielts({
    required String candidateNumber,
    required String testReportNumber,
    required DateTime testDate,
    required DateTime expiryDate,
    required double overallBand,
    required double listeningScore,
    required double readingScore,
    required double writingScore,
    required double speakingScore,
    required String testCenter,
  }) = IELTSMetadata;

  // Tambah varian metadata lain di sini...

  // Fallback untuk dokumen yang tidak dikenal
  const factory DocumentMetadata.unknown(Map<String, dynamic> data) = UnknownMetadata;
  //const factory DocumentMetadata.none() = NoneMetadata;

  factory DocumentMetadata.fromJson(Map<String, dynamic> json) => _$DocumentMetadataFromJson(json);
} 