//lib/features/documents/domain/entities/document_type.dart
import 'package:flutter/material.dart';

/// Main document categories for v1.0 quick classification
enum MainDocumentType {
  CARD,
  DOCUMENT,
  OTHER;

  /// Returns a user-friendly, display-ready name for the main document type.
  String get displayName {
    switch (this) {
      case MainDocumentType.CARD:
        return 'Kartu';
      case MainDocumentType.DOCUMENT:
        return 'Dokumen';
      case MainDocumentType.OTHER:
        return 'Lainnya';
    }
  }

  /// Returns a corresponding icon for the main document type.
  IconData get icon {
    switch (this) {
      case MainDocumentType.CARD:
        return Icons.credit_card_outlined;
      case MainDocumentType.DOCUMENT:
        return Icons.description_outlined;
      case MainDocumentType.OTHER:
        return Icons.insert_drive_file_outlined;
    }
  }
}

/// Specific document subtypes (optional in v1.0, detailed classification for v2.0)
enum DocumentSubType {
  ktp,
  sim,
  passport,
  ijazah,
  sertifikat,
  lainnya; // Note the semicolon here to allow for methods

  /// Returns a user-friendly, display-ready name for the document subtype.
  String get displayName {
    switch (this) {
      case DocumentSubType.ktp:
        return 'KTP';
      case DocumentSubType.sim:
        return 'SIM';
      case DocumentSubType.passport:
        return 'Passport';
      case DocumentSubType.ijazah:
        return 'Ijazah';
      case DocumentSubType.sertifikat:
        return 'Sertifikat';
      case DocumentSubType.lainnya:
        return 'Lainnya';
    }
  }

  /// Returns a corresponding icon for the document subtype.
  IconData get icon {
    switch (this) {
      case DocumentSubType.ktp:
        return Icons.badge_outlined;
      case DocumentSubType.sim:
        return Icons.credit_card_outlined;
      case DocumentSubType.passport:
        return Icons.book_outlined;
      case DocumentSubType.ijazah:
        return Icons.school_outlined;
      case DocumentSubType.sertifikat:
        return Icons.workspace_premium_outlined;
      case DocumentSubType.lainnya:
        return Icons.insert_drive_file_outlined;
    }
  }

  /// Maps subtype to its corresponding main type
  MainDocumentType get mainType {
    switch (this) {
      case DocumentSubType.ktp:
      case DocumentSubType.sim:
      case DocumentSubType.passport:
        return MainDocumentType.CARD;
      case DocumentSubType.ijazah:
      case DocumentSubType.sertifikat:
        return MainDocumentType.DOCUMENT;
      case DocumentSubType.lainnya:
        return MainDocumentType.OTHER;
    }
  }
}
