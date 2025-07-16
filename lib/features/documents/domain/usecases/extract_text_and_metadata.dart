import 'package:fpdart/fpdart.dart';
import 'dart:io';
import '../../../../core/exceptions/app_exception.dart';
import '../entities/document_type.dart';
import '../entities/metadata/document_metadata.dart';

class ExtractTextAndMetadataUseCase {
  // This would integrate with OCR services like Google ML Kit, Tesseract, etc.
  // For now, this is a mock implementation
  
  Future<Either<AppException, ExtractedDocumentData>> call(
    String filePath, 
    DocumentType documentType,
  ) async {
    try {
      // Simulate OCR processing delay
      await Future.delayed(const Duration(seconds: 2));
      
      final file = File(filePath);
      if (!file.existsSync()) {
        return Left(AppException('File not found'));
      }
      
      // Mock extraction based on document type
      final extractedData = await _extractDataByType(filePath, documentType);
      
      return Right(extractedData);
    } catch (e) {
      return Left(AppException('Failed to extract data: $e'));
    }
  }
  
  Future<ExtractedDocumentData> _extractDataByType(String filePath, DocumentType type) async {
    switch (type) {
      case DocumentType.ktp:
        return _extractKTPData(filePath);
      case DocumentType.sim:
        return _extractSIMData(filePath);
      case DocumentType.passport:
        return _extractPassportData(filePath);
      default:
        return ExtractedDocumentData(
          extractedText: 'General document text extracted from OCR',
          metadata: const DocumentMetadata.unknown({}),
          confidence: 0.0,
        );
    }
  }
  
  ExtractedDocumentData _extractKTPData(String filePath) {
    // Mock KTP data extraction
    // In real implementation, this would use OCR + AI to parse KTP fields
    return ExtractedDocumentData(
      extractedText: 'NIK: 1234567890123456\nNama: JOHN DOE\nTempat Lahir: JAKARTA\nTanggal Lahir: 01-01-1990\nAlamat: JL. CONTOH NO. 123',
      metadata: DocumentMetadata.ktp(
        nik: '1234567890123456',
        fullName: 'JOHN DOE',
        birthPlace: 'JAKARTA',
        birthDate: DateTime(1990, 1, 1),
        address: 'JL. CONTOH NO. 123',
        gender: 'L',
        berlakuHingga: 'SEUMUR HIDUP',
        maritalStatus: 'BELUM KAWIN',
        occupation: 'KARYAWAN SWASTA',
        citizenship: 'WNI',
      ),
      confidence: 0.85, // 85% confidence in extraction
    );
  }
  
  ExtractedDocumentData _extractSIMData(String filePath) {
    // Mock SIM data extraction
    return ExtractedDocumentData(
      extractedText: 'SIM Number: ABC123456789\nHolder: JOHN DOE\nType: A\nExpiry: 01-01-2025',
      metadata: DocumentMetadata.sim(
        simNumber: 'ABC123456789',
        holderName: 'JOHN DOE',
        simType: 'A',
        issuedDate: DateTime(2020, 1, 1),
        expiryDate: DateTime(2025, 1, 1),
        issuingOffice: 'POLDA METRO JAYA',
        address: 'JL. CONTOH NO. 123',
        birthDate: DateTime(1990, 1, 1),
      ),
      confidence: 0.90,
    );
  }
  
  ExtractedDocumentData _extractPassportData(String filePath) {
    // Mock Passport data extraction
    return ExtractedDocumentData(
      extractedText: 'Passport Number: A1234567\nName: JOHN DOE\nNationality: INDONESIA',
      metadata: DocumentMetadata.passport(
        passportNumber: 'A1234567',
        holderName: 'JOHN DOE',
        nationality: 'INDONESIA',
        birthDate: DateTime(1990, 1, 1),
        birthPlace: 'JAKARTA',
        gender: 'M',
        issuedDate: DateTime(2020, 1, 1),
        expiryDate: DateTime(2030, 1, 1),
        issuingAuthority: 'REPUBLIC OF INDONESIA',
        placeOfIssue: 'JAKARTA',
      ),
      confidence: 0.88,
    );
  }
}

class ExtractedDocumentData {
  final String extractedText;
  final DocumentMetadata metadata;
  final double confidence; // 0.0 to 1.0
  
  ExtractedDocumentData({
    required this.extractedText,
    required this.metadata,
    required this.confidence,
  });
  
  bool get hasHighConfidence => confidence >= 0.8;
  bool get hasLowConfidence => confidence < 0.5;
}
