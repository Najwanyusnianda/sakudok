// lib/features/bundles/domain/entities/bundle_template.dart

class BundleTemplate {
  final String id;
  final String name;
  final String description;
  final List<String> requiredDocumentTypes;
  final List<String> optionalDocumentTypes;
  final String icon;
  final String category;
  final bool isPopular;
  final List<String> useCases;

  const BundleTemplate({
    required this.id,
    required this.name,
    required this.description,
    required this.requiredDocumentTypes,
    this.optionalDocumentTypes = const [],
    required this.icon,
    required this.category,
    this.isPopular = false,
    this.useCases = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'requiredDocumentTypes': requiredDocumentTypes,
      'optionalDocumentTypes': optionalDocumentTypes,
      'icon': icon,
      'category': category,
      'isPopular': isPopular,
      'useCases': useCases,
    };
  }

  factory BundleTemplate.fromJson(Map<String, dynamic> json) {
    return BundleTemplate(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      requiredDocumentTypes: List<String>.from(json['requiredDocumentTypes']),
      optionalDocumentTypes: List<String>.from(json['optionalDocumentTypes'] ?? []),
      icon: json['icon'],
      category: json['category'],
      isPopular: json['isPopular'] ?? false,
      useCases: List<String>.from(json['useCases'] ?? []),
    );
  }
}

// Pre-defined smart bundle templates
class BundleTemplates {
  static const List<BundleTemplate> defaultTemplates = [
    // Job Application Bundle
    BundleTemplate(
      id: 'job_application',
      name: 'Job Application',
      description: 'Complete documents for job applications',
      requiredDocumentTypes: ['ktp', 'ijazah'],
      optionalDocumentTypes: ['sertifikat', 'ielts'],
      icon: 'work',
      category: 'Career',
      isPopular: true,
      useCases: ['Apply for jobs', 'Submit to HR', 'Career portfolio'],
    ),
    
    // Travel Documents Bundle
    BundleTemplate(
      id: 'travel_documents',
      name: 'Travel Documents',
      description: 'Essential documents for international travel',
      requiredDocumentTypes: ['passport', 'ktp'],
      optionalDocumentTypes: ['sim', 'sertifikat'],
      icon: 'flight',
      category: 'Travel',
      isPopular: true,
      useCases: ['International travel', 'Visa applications', 'Border crossing'],
    ),
    
    // Education Bundle
    BundleTemplate(
      id: 'education_documents',
      name: 'Education Documents',
      description: 'Academic credentials and certificates',
      requiredDocumentTypes: ['ijazah'],
      optionalDocumentTypes: ['sertifikat', 'ielts'],
      icon: 'school',
      category: 'Education',
      useCases: ['University applications', 'Scholarship applications', 'Academic portfolio'],
    ),
    
    // Government Services Bundle
    BundleTemplate(
      id: 'government_services',
      name: 'Government Services',
      description: 'Documents for government applications',
      requiredDocumentTypes: ['ktp'],
      optionalDocumentTypes: ['sim', 'passport'],
      icon: 'account_balance',
      category: 'Government',
      useCases: ['Tax filing', 'Banking', 'Legal procedures'],
    ),
    
    // Professional Certification Bundle
    BundleTemplate(
      id: 'professional_certification',
      name: 'Professional Certification',
      description: 'Professional skills and certifications',
      requiredDocumentTypes: ['sertifikat'],
      optionalDocumentTypes: ['ielts', 'ijazah'],
      icon: 'workspace_premium',
      category: 'Professional',
      useCases: ['Skill validation', 'Career advancement', 'Professional networking'],
    ),
  ];
}
