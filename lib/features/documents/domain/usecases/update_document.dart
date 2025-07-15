import 'package:fpdart/fpdart.dart';
import '../entities/document.dart';
import '../repositories/document_repository.dart';

class UpdateDocument {
  final DocumentRepository repository;

  const UpdateDocument(this.repository);

  Future<Either<String, Document>> call(Document document) async {
    // Validate document before updating
    final validationResult = _validateDocument(document);
    if (!validationResult.isValid) {
      return left(validationResult.errors.join(', '));
    }

    return await repository.updateDocument(document);
  }

  ValidationResult _validateDocument(Document document) {
    final errors = <String>[];
    final warnings = <String>[];

    // Basic validation
    if (document.id <= 0) {
      errors.add('ID dokumen tidak valid');
    }

    if (document.title.trim().isEmpty) {
      errors.add('Judul dokumen tidak boleh kosong');
    }

    if (document.type.trim().isEmpty) {
      errors.add('Tipe dokumen tidak boleh kosong');
    }

    if (document.filePath.trim().isEmpty) {
      errors.add('File dokumen tidak boleh kosong');
    }

    // Use document's built-in validation
    final documentValidation = document.validate();
    errors.addAll(documentValidation.errors);
    warnings.addAll(documentValidation.warnings);

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
      warnings: warnings,
    );
  }
} 