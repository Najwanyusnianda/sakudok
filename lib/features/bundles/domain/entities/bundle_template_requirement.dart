import 'package:equatable/equatable.dart';
import '../../../documents/domain/entities/document_type.dart';

class BundleTemplateRequirement extends Equatable {
  final String id;
  final String bundleUserTemplateId;
  final DocumentType documentType;
  final String name; // e.g., "CV in English"

  const BundleTemplateRequirement({
    required this.id,
    required this.bundleUserTemplateId,
    required this.documentType,
    required this.name,
  });

  BundleTemplateRequirement copyWith({
    String? id,
    String? bundleUserTemplateId,
    DocumentType? documentType,
    String? name,
  }) {
    return BundleTemplateRequirement(
      id: id ?? this.id,
      bundleUserTemplateId: bundleUserTemplateId ?? this.bundleUserTemplateId,
      documentType: documentType ?? this.documentType,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, bundleUserTemplateId, documentType, name];
}
