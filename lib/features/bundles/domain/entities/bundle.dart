// lib/features/bundles/domain/entities/bundle.dart
import '../../../documents/domain/entities/document.dart';

class Bundle {
  final String id;
  final String name;
  final String? description;
  final String? template;
  final int? groupId; // New field for bundle group association
  final bool isDefault;
  final List<Document> documents;
  final DateTime createdAt;
  final DateTime updatedAt;
  final BundleType type;
  final bool isComplete;
  final List<String> requiredDocumentTypes;
  final List<String> suggestedDocumentTypes;

  const Bundle({
    required this.id,
    required this.name,
    this.description,
    this.template,
    this.groupId, // New optional parameter
    this.isDefault = false,
    this.documents = const [],
    required this.createdAt,
    required this.updatedAt,
    this.type = BundleType.manual,
    this.isComplete = false,
    this.requiredDocumentTypes = const [],
    this.suggestedDocumentTypes = const [],
  });

  Bundle copyWith({
    String? id,
    String? name,
    String? description,
    String? template,
    int? groupId, // New parameter
    bool? isDefault,
    List<Document>? documents,
    DateTime? createdAt,
    DateTime? updatedAt,
    BundleType? type,
    bool? isComplete,
    List<String>? requiredDocumentTypes,
    List<String>? suggestedDocumentTypes,
  }) {
    return Bundle(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      template: template ?? this.template,
      groupId: groupId ?? this.groupId, // New field
      isDefault: isDefault ?? this.isDefault,
      documents: documents ?? this.documents,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      type: type ?? this.type,
      isComplete: isComplete ?? this.isComplete,
      requiredDocumentTypes: requiredDocumentTypes ?? this.requiredDocumentTypes,
      suggestedDocumentTypes: suggestedDocumentTypes ?? this.suggestedDocumentTypes,
    );
  }
  // --- FIX: Removed the duplicated block of code that was here ---

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'template': template,
      'groupId': groupId, // New field
      'isDefault': isDefault,
      'documents': documents.map((doc) => doc.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'type': type.name,
      'isComplete': isComplete,
      'requiredDocumentTypes': requiredDocumentTypes,
      'suggestedDocumentTypes': suggestedDocumentTypes,
    };
  }

  factory Bundle.fromJson(Map<String, dynamic> json) {
    return Bundle(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      template: json['template'],
      groupId: json['groupId'], // New field
      isDefault: json['isDefault'] ?? false,
      documents: (json['documents'] as List?)
          ?.map((doc) => Document.fromJson(doc))
          .toList() ?? [],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      type: BundleType.values.byName(json['type'] ?? 'manual'),
      isComplete: json['isComplete'] ?? false,
      requiredDocumentTypes: List<String>.from(json['requiredDocumentTypes'] ?? []),
      suggestedDocumentTypes: List<String>.from(json['suggestedDocumentTypes'] ?? []),
    );
  }
}

enum BundleType {
  manual, // User-created bundle
  smart, // AI-suggested bundle based on document patterns
  template, // Pre-defined bundle template
}