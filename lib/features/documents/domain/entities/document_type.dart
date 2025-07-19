//lib/features/documents/domain/entities/document_type.dart
import 'package:flutter/material.dart';

enum DocumentType {
  ktp,
  sim,
  passport,
  ijazah,
  sertifikat,
  lainnya; // Note the semicolon here to allow for methods

  /// Returns a user-friendly, display-ready name for the document type.
  String get displayName {
    switch (this) {
      case DocumentType.ktp:
        return 'KTP';
      case DocumentType.sim:
        return 'SIM';
      case DocumentType.passport:
        return 'Passport';
      case DocumentType.ijazah:
        return 'Ijazah';
      case DocumentType.sertifikat:
        return 'Sertifikat';
      case DocumentType.lainnya:
        return 'Lainnya';
      default:
        return 'Document';
    }
  }

  /// Returns a corresponding icon for the document type.
  IconData get icon {
    switch (this) {
      case DocumentType.ktp:
        return Icons.badge_outlined;
      case DocumentType.sim:
        return Icons.credit_card_outlined;
      case DocumentType.passport:
        return Icons.book_outlined;
      case DocumentType.ijazah:
        return Icons.school_outlined;
      case DocumentType.sertifikat:
        return Icons.workspace_premium_outlined;
      case DocumentType.lainnya:
      default:
        return Icons.insert_drive_file_outlined;
    }
  }
}
