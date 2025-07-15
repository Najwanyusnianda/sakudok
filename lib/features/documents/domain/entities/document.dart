import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'document.freezed.dart';
part 'document.g.dart';

@freezed
abstract class Document with _$Document {
  const factory Document({
    required int id,
    required String title,
    required String type,
    required String filePath,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? description,
    
    // Core fields
    @Default(false) bool hasReminder,
    DateTime? reminderDate,
    String? reminderNote,
    @Default(false) bool isEncrypted,
    String? tags,
    int? bundleId,
    
    // Flexible metadata for all document types
    @Default(<String, dynamic>{}) Map<String, dynamic> metadata,
  }) = _Document;

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);
}

// Document Type Schema System
class DocumentTypeSchema {
  final String type;
  final String displayName;
  final String category;
  final List<DocumentField> fields;
  final bool hasExpiry;
  final String? iconPath;
  final Color? color;
  final List<String>? validationRules;

  const DocumentTypeSchema({
    required this.type,
    required this.displayName,
    required this.category,
    required this.fields,
    this.hasExpiry = false,
    this.iconPath,
    this.color,
    this.validationRules,
  });

  bool hasField(String fieldName) {
    return fields.any((field) => field.name == fieldName);
  }

  DocumentField? getField(String fieldName) {
    try {
      return fields.firstWhere((field) => field.name == fieldName);
    } catch (e) {
      return null;
    }
  }

  ValidationResult validate(Map<String, dynamic> metadata) {
    final errors = <String>[];
    final warnings = <String>[];

    // Validate required fields
    for (final field in fields) {
      if (field.required && (metadata[field.name] == null || metadata[field.name].toString().isEmpty)) {
        errors.add('${field.displayName} wajib diisi');
      }
    }

    // Validate field types
    for (final field in fields) {
      final value = metadata[field.name];
      if (value != null && value.toString().isNotEmpty) {
        final fieldValidation = field.validate(value);
        errors.addAll(fieldValidation.errors);
        warnings.addAll(fieldValidation.warnings);
      }
    }

    // Validate expiry date if applicable
    if (hasExpiry) {
      final expiryDate = metadata['berlakuHingga'];
      if (expiryDate != null) {
        try {
          final date = DateTime.parse(expiryDate.toString());
          final daysUntilExpiry = date.difference(DateTime.now()).inDays;
          
          if (daysUntilExpiry < 0) {
            errors.add('Dokumen sudah kadaluarsa');
          } else if (daysUntilExpiry <= 30) {
            warnings.add('Dokumen akan kadaluarsa dalam $daysUntilExpiry hari');
          }
        } catch (e) {
          errors.add('Format tanggal tidak valid');
        }
      }
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
      warnings: warnings,
    );
  }
}

// Document Field Definition
class DocumentField {
  final String name;
  final String displayName;
  final FieldType type;
  final bool required;
  final String? placeholder;
  final List<String>? options;
  final String? validationPattern;
  final String? validationMessage;
  final int? maxLength;
  final int? minLength;

  const DocumentField({
    required this.name,
    required this.displayName,
    required this.type,
    this.required = false,
    this.placeholder,
    this.options,
    this.validationPattern,
    this.validationMessage,
    this.maxLength,
    this.minLength,
  });

  ValidationResult validate(dynamic value) {
    final errors = <String>[];
    final warnings = <String>[];

    if (value == null || value.toString().isEmpty) {
      if (required) {
        errors.add('$displayName wajib diisi');
      }
      return ValidationResult(isValid: errors.isEmpty, errors: errors, warnings: warnings);
    }

    final stringValue = value.toString();

    // Length validation
    if (minLength != null && stringValue.length < minLength!) {
      errors.add('$displayName minimal $minLength karakter');
    }
    if (maxLength != null && stringValue.length > maxLength!) {
      errors.add('$displayName maksimal $maxLength karakter');
    }

    // Pattern validation
    if (validationPattern != null) {
      final regex = RegExp(validationPattern!);
      if (!regex.hasMatch(stringValue)) {
        errors.add(validationMessage ?? 'Format $displayName tidak valid');
      }
    }

    // Type-specific validation
    switch (type) {
      case FieldType.email:
        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
        if (!emailRegex.hasMatch(stringValue)) {
          errors.add('Format email tidak valid');
        }
        break;
      case FieldType.phone:
        final phoneRegex = RegExp(r'^[\d\s\-\+\(\)]+$');
        if (!phoneRegex.hasMatch(stringValue)) {
          errors.add('Format nomor telepon tidak valid');
        }
        break;
      case FieldType.url:
        try {
          Uri.parse(stringValue);
        } catch (e) {
          errors.add('Format URL tidak valid');
        }
        break;
      case FieldType.date:
        try {
          DateTime.parse(stringValue);
        } catch (e) {
          errors.add('Format tanggal tidak valid');
        }
        break;
      case FieldType.number:
        if (double.tryParse(stringValue) == null) {
          errors.add('$displayName harus berupa angka');
        }
        break;
      default:
        break;
    }

    return ValidationResult(isValid: errors.isEmpty, errors: errors, warnings: warnings);
  }
}

// Field Types
enum FieldType {
  text('Text'),
  number('Number'),
  date('Date'),
  email('Email'),
  phone('Phone'),
  url('URL'),
  multiline('Multiline'),
  select('Select'),
  checkbox('Checkbox'),
  radio('Radio');

  const FieldType(this.label);
  final String label;
}

// Validation Result
class ValidationResult {
  final bool isValid;
  final List<String> errors;
  final List<String> warnings;

  const ValidationResult({
    required this.isValid,
    this.errors = const [],
    this.warnings = const [],
  });

  bool get hasErrors => errors.isNotEmpty;
  bool get hasWarnings => warnings.isNotEmpty;
}

// Document Field Value (for UI)
class DocumentFieldValue {
  final DocumentField field;
  final dynamic value;

  const DocumentFieldValue({
    required this.field,
    this.value,
  });
}

// Document Type Registry
class DocumentTypeRegistry {
  static final Map<String, DocumentTypeSchema> _types = {};

  static void register(DocumentTypeSchema schema) {
    _types[schema.type] = schema;
  }

  static DocumentTypeSchema? getType(String type) {
    return _types[type];
  }

  static List<DocumentTypeSchema> getAllTypes() {
    return _types.values.toList();
  }

  static List<DocumentTypeSchema> getTypesByCategory(String category) {
    return _types.values.where((type) => type.category == category).toList();
  }

  // Initialize default document types
  static void initializeDefaultTypes() {
    // KTP
    register(DocumentTypeSchema(
      type: 'KTP',
      displayName: 'KTP',
      category: 'identity',
      hasExpiry: false,
      color: const Color(0xFF3B82F6),
      fields: [
        const DocumentField(name: 'nik', displayName: 'NIK', type: FieldType.text, required: true, validationPattern: r'^\d{16}$', validationMessage: 'NIK harus 16 digit'),
        const DocumentField(name: 'nama', displayName: 'Nama Lengkap', type: FieldType.text, required: true),
        const DocumentField(name: 'tempatLahir', displayName: 'Tempat Lahir', type: FieldType.text),
        const DocumentField(name: 'tanggalLahir', displayName: 'Tanggal Lahir', type: FieldType.date),
        const DocumentField(name: 'jenisKelamin', displayName: 'Jenis Kelamin', type: FieldType.select, options: ['Laki-laki', 'Perempuan']),
        const DocumentField(name: 'alamat', displayName: 'Alamat', type: FieldType.multiline),
        const DocumentField(name: 'agama', displayName: 'Agama', type: FieldType.text),
        const DocumentField(name: 'statusPerkawinan', displayName: 'Status Perkawinan', type: FieldType.text),
        const DocumentField(name: 'pekerjaan', displayName: 'Pekerjaan', type: FieldType.text),
        const DocumentField(name: 'kewarganegaraan', displayName: 'Kewarganegaraan', type: FieldType.text),
      ],
    ));

    // SIM
    register(DocumentTypeSchema(
      type: 'SIM',
      displayName: 'SIM',
      category: 'driving',
      hasExpiry: true,
      color: const Color(0xFF10B981),
      fields: [
        const DocumentField(name: 'nomorSim', displayName: 'Nomor SIM', type: FieldType.text, required: true, validationPattern: r'^[A-Z]\d{12}$', validationMessage: 'Format nomor SIM tidak valid'),
        const DocumentField(name: 'jenisSim', displayName: 'Jenis SIM', type: FieldType.select, required: true, options: ['A', 'B1', 'B2', 'C', 'D']),
        const DocumentField(name: 'nama', displayName: 'Nama', type: FieldType.text, required: true),
        const DocumentField(name: 'berlakuHingga', displayName: 'Berlaku Hingga', type: FieldType.date, required: true),
      ],
    ));

    // Ijazah
    register(DocumentTypeSchema(
      type: 'Ijazah',
      displayName: 'Ijazah',
      category: 'education',
      hasExpiry: false,
      color: const Color(0xFFF59E0B),
      fields: [
        const DocumentField(name: 'namaSekolah', displayName: 'Nama Sekolah/Universitas', type: FieldType.text, required: true),
        const DocumentField(name: 'jurusan', displayName: 'Jurusan', type: FieldType.text),
        const DocumentField(name: 'ipk', displayName: 'IPK', type: FieldType.number),
        const DocumentField(name: 'tahunLulus', displayName: 'Tahun Lulus', type: FieldType.number),
        const DocumentField(name: 'nama', displayName: 'Nama Lengkap', type: FieldType.text, required: true),
      ],
    ));

    // Paspor
    register(DocumentTypeSchema(
      type: 'Paspor',
      displayName: 'Paspor',
      category: 'travel',
      hasExpiry: true,
      color: const Color(0xFF8B5CF6),
      fields: [
        const DocumentField(name: 'nomorPaspor', displayName: 'Nomor Paspor', type: FieldType.text, required: true),
        const DocumentField(name: 'nama', displayName: 'Nama Lengkap', type: FieldType.text, required: true),
        const DocumentField(name: 'tempatDikeluarkan', displayName: 'Tempat Dikeluarkan', type: FieldType.text),
        const DocumentField(name: 'berlakuHingga', displayName: 'Berlaku Hingga', type: FieldType.date, required: true),
      ],
    ));

    // STNK
    register(DocumentTypeSchema(
      type: 'STNK',
      displayName: 'STNK',
      category: 'vehicle',
      hasExpiry: true,
      color: const Color(0xFFEF4444),
      fields: [
        const DocumentField(name: 'platNomor', displayName: 'Plat Nomor', type: FieldType.text, required: true),
        const DocumentField(name: 'merkKendaraan', displayName: 'Merk Kendaraan', type: FieldType.text),
        const DocumentField(name: 'berlakuHingga', displayName: 'Berlaku Hingga', type: FieldType.date, required: true),
      ],
    ));

    // BPJS
    register(DocumentTypeSchema(
      type: 'BPJS',
      displayName: 'BPJS',
      category: 'health',
      hasExpiry: false,
      color: const Color(0xFF06B6D4),
      fields: [
        const DocumentField(name: 'nomorBpjs', displayName: 'Nomor BPJS', type: FieldType.text, required: true),
        const DocumentField(name: 'jenisBpjs', displayName: 'Jenis BPJS', type: FieldType.select, required: true, options: ['Kesehatan', 'Ketenagakerjaan']),
        const DocumentField(name: 'nama', displayName: 'Nama Peserta', type: FieldType.text, required: true),
      ],
    ));

    // NPWP
    register(DocumentTypeSchema(
      type: 'NPWP',
      displayName: 'NPWP',
      category: 'tax',
      hasExpiry: false,
      color: const Color(0xFF84CC16),
      fields: [
        const DocumentField(name: 'nomorNpwp', displayName: 'Nomor NPWP', type: FieldType.text, required: true, validationPattern: r'^\d{2}\.\d{3}\.\d{3}\.\d{1}-\d{3}\.\d{3}$', validationMessage: 'Format NPWP tidak valid'),
        const DocumentField(name: 'namaWajibPajak', displayName: 'Nama Wajib Pajak', type: FieldType.text, required: true),
      ],
    ));

    // IELTS/TOEFL
    register(DocumentTypeSchema(
      type: 'IELTS/TOEFL',
      displayName: 'IELTS/TOEFL',
      category: 'education',
      hasExpiry: true,
      color: const Color(0xFFEC4899),
      fields: [
        const DocumentField(name: 'jenisTest', displayName: 'Jenis Test', type: FieldType.select, required: true, options: ['IELTS', 'TOEFL']),
        const DocumentField(name: 'scoreIelts', displayName: 'Score IELTS', type: FieldType.number),
        const DocumentField(name: 'scoreToefl', displayName: 'Score TOEFL', type: FieldType.number),
        const DocumentField(name: 'tanggalTest', displayName: 'Tanggal Test', type: FieldType.date),
        const DocumentField(name: 'berlakuHingga', displayName: 'Berlaku Hingga', type: FieldType.date),
      ],
    ));
  }
}

// Extension methods for Document
extension DocumentExtensions on Document {
  DocumentTypeSchema? get schema => DocumentTypeRegistry.getType(type);
  
  T? getField<T>(String fieldName) => metadata[fieldName] as T?;
  
  Document copyWithField(String fieldName, dynamic value) {
    final newMetadata = Map<String, dynamic>.from(metadata);
    newMetadata[fieldName] = value;
    return copyWith(metadata: newMetadata);
  }
  
  ValidationResult validate() {
    final schema = this.schema;
    if (schema == null) {
      return const ValidationResult(isValid: false, errors: ['Tipe dokumen tidak dikenal']);
    }
    return schema.validate(metadata);
  }
  
  List<DocumentFieldValue> getAllFields() {
    final schema = this.schema;
    if (schema == null) return [];
    
    return schema.fields.map((field) => DocumentFieldValue(
      field: field,
      value: metadata[field.name],
    )).toList();
  }
  
  bool get isExpired {
    if (!schema!.hasExpiry) return false;
    final expiryDate = getField<DateTime>('berlakuHingga');
    return expiryDate != null && expiryDate.isBefore(DateTime.now());
  }
  
  int? get daysUntilExpiry {
    if (!schema!.hasExpiry) return null;
    final expiryDate = getField<DateTime>('berlakuHingga');
    if (expiryDate == null) return null;
    return expiryDate.difference(DateTime.now()).inDays;
  }
}
