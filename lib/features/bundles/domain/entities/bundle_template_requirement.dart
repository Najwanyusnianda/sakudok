import 'package:equatable/equatable.dart';
import '../../../documents/domain/entities/document_type.dart';

class BundleTemplateRequirement extends Equatable {
  final String id;
  final String bundleUserTemplateId;
  final MainDocumentType mainDocumentType;
  final String name; // e.g., "CV in English"

  const BundleTemplateRequirement({
    required this.id,
    required this.bundleUserTemplateId,
    required this.mainDocumentType,
    required this.name,
  });

  BundleTemplateRequirement copyWith({
    String? id,
    String? bundleUserTemplateId,
    MainDocumentType? mainDocumentType,
    String? name,
  }) {
    return BundleTemplateRequirement(
      id: id ?? this.id,
      bundleUserTemplateId: bundleUserTemplateId ?? this.bundleUserTemplateId,
      mainDocumentType: mainDocumentType ?? this.mainDocumentType,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, bundleUserTemplateId, mainDocumentType, name];
}
