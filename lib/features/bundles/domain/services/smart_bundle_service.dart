// lib/features/bundles/domain/services/smart_bundle_service.dart
import '../entities/bundle.dart';
import '../entities/bundle_template.dart';
import '../../../documents/domain/entities/document.dart';
import '../../../documents/domain/entities/document_type.dart';
import '../../../documents/domain/entities/metadata/document_metadata.dart';

class SmartBundleService {
  // Analyze documents and suggest smart bundles
  static List<Bundle> suggestBundles(List<Document> documents) {
    final suggestions = <Bundle>[];
    final documentsByType = _groupDocumentsByType(documents);
    
    // Check each template for potential matches
    for (final template in BundleTemplates.defaultTemplates) {
      final matchedDocs = _findMatchingDocuments(documentsByType, template);
      
      if (matchedDocs.isNotEmpty) {
        final hasAllRequired = _hasAllRequiredDocuments(documentsByType, template);
        
        suggestions.add(Bundle(
          id: 'suggested_${template.id}_${DateTime.now().millisecondsSinceEpoch}',
          name: template.name,
          description: template.description,
          template: template.id,
          documents: matchedDocs,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          type: BundleType.smart,
          isComplete: hasAllRequired,
          requiredDocumentTypes: template.requiredDocumentTypes,
          suggestedDocumentTypes: template.optionalDocumentTypes,
        ));
      }
    }
    
    return suggestions;
  }
  
  // Find documents that could be bundled together based on metadata patterns
  static List<Bundle> detectDocumentPatterns(List<Document> documents) {
    final suggestions = <Bundle>[];
    
    // Pattern 1: Documents with same person name (from metadata)
    final personGroups = _groupByPersonName(documents);
    for (final entry in personGroups.entries) {
      if (entry.value.length > 1) {
        suggestions.add(Bundle(
          id: 'pattern_person_${entry.key.hashCode}',
          name: '${entry.key} Documents',
          description: 'Documents belonging to ${entry.key}',
          documents: entry.value,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          type: BundleType.smart,
        ));
      }
    }
    
    // Pattern 2: Documents with similar expiry dates (within 30 days)
    final expiryGroups = _groupByExpiryPeriod(documents);
    for (final entry in expiryGroups.entries) {
      if (entry.value.length > 1) {
        suggestions.add(Bundle(
          id: 'pattern_expiry_${entry.key}',
          name: 'Documents Expiring in ${entry.key}',
          description: 'Documents that need renewal around the same time',
          documents: entry.value,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          type: BundleType.smart,
        ));
      }
    }
    
    return suggestions;
  }
  
  // Check bundle completeness and suggest missing documents
  static List<String> suggestMissingDocuments(Bundle bundle) {
    final missing = <String>[];
    final presentTypes = bundle.documents.map((doc) => doc.type.name).toSet();
    
    for (final requiredType in bundle.requiredDocumentTypes) {
      if (!presentTypes.contains(requiredType)) {
        missing.add(requiredType);
      }
    }
    
    return missing;
  }
  
  // Calculate bundle completion percentage
  static double calculateCompletionPercentage(Bundle bundle) {
    if (bundle.requiredDocumentTypes.isEmpty) return 1.0;
    
    final presentTypes = bundle.documents.map((doc) => doc.type.name).toSet();
    final requiredCount = bundle.requiredDocumentTypes.length;
    final presentRequiredCount = bundle.requiredDocumentTypes
        .where((type) => presentTypes.contains(type))
        .length;
    
    return presentRequiredCount / requiredCount;
  }
  
  // Helper methods
  static Map<DocumentType, List<Document>> _groupDocumentsByType(List<Document> documents) {
    final grouped = <DocumentType, List<Document>>{};
    for (final doc in documents) {
      grouped.putIfAbsent(doc.type, () => []).add(doc);
    }
    return grouped;
  }
  
  static List<Document> _findMatchingDocuments(
    Map<DocumentType, List<Document>> documentsByType,
    BundleTemplate template,
  ) {
    final matched = <Document>[];
    
    // Add required documents
    for (final typeString in template.requiredDocumentTypes) {
      final type = DocumentType.values.firstWhere(
        (t) => t.name == typeString,
        orElse: () => DocumentType.lainnya,
      );
      if (documentsByType.containsKey(type)) {
        matched.addAll(documentsByType[type]!);
      }
    }
    
    // Add optional documents
    for (final typeString in template.optionalDocumentTypes) {
      final type = DocumentType.values.firstWhere(
        (t) => t.name == typeString,
        orElse: () => DocumentType.lainnya,
      );
      if (documentsByType.containsKey(type)) {
        matched.addAll(documentsByType[type]!);
      }
    }
    
    return matched;
  }
  
  static bool _hasAllRequiredDocuments(
    Map<DocumentType, List<Document>> documentsByType,
    BundleTemplate template,
  ) {
    for (final typeString in template.requiredDocumentTypes) {
      final type = DocumentType.values.firstWhere(
        (t) => t.name == typeString,
        orElse: () => DocumentType.lainnya,
      );
      if (!documentsByType.containsKey(type) || documentsByType[type]!.isEmpty) {
        return false;
      }
    }
    return true;
  }
  
  static Map<String, List<Document>> _groupByPersonName(List<Document> documents) {
    final groups = <String, List<Document>>{};
    
    for (final doc in documents) {
      String? personName;
      final metadata = doc.metadata;
      
      // Extract person name from metadata based on document type
      if (metadata is KTPMetadata) {
        personName = metadata.fullName;
      } else if (metadata is SIMMetadata) {
        personName = metadata.holderName;
      } else if (metadata is PassportMetadata) {
        personName = metadata.holderName;
      } else if (metadata is IELTSMetadata) {
        personName = metadata.candidateName;
      } else if (metadata is TranscriptMetadata) {
        personName = metadata.studentName;
      } else if (metadata is CVMetadata) {
        personName = metadata.fullName;
      } else if (metadata is CertificateMetadata) {
        personName = metadata.holderName;
      } else if (metadata is DiplomaMetadata) {
        personName = metadata.graduateName;
      } else if (metadata is UnknownMetadata) {
        // Try to extract name from unknown data
        if (metadata.data['name'] != null) personName = metadata.data['name'].toString();
        if (metadata.data['fullName'] != null) personName = metadata.data['fullName'].toString();
      }
      
      if (personName != null && personName.isNotEmpty) {
        groups.putIfAbsent(personName, () => []).add(doc);
      }
    }
    
    return groups;
  }
  
  static Map<String, List<Document>> _groupByExpiryPeriod(List<Document> documents) {
    final groups = <String, List<Document>>{};
    final now = DateTime.now();
    
    for (final doc in documents) {
      DateTime? expiryDate;
      final metadata = doc.metadata;
      
      // Extract expiry date from metadata
      if (metadata is KTPMetadata) {
        // KTP now uses berlakuHingga string instead of expiryDate
        // For "SEUMUR HIDUP" we set expiryDate to null (no expiry)
        if (metadata.berlakuHingga != "SEUMUR HIDUP") {
          // Try to parse date from berlakuHingga if it's not "SEUMUR HIDUP"
          try {
            // This is a simplified implementation - in real app you'd need proper date parsing
            expiryDate = null; // For now, treat all KTP as non-expiring
          } catch (e) {
            expiryDate = null;
          }
        }
      } else if (metadata is SIMMetadata) {
        expiryDate = metadata.expiryDate;
      } else if (metadata is PassportMetadata) {
        expiryDate = metadata.expiryDate;
      } else if (metadata is IELTSMetadata) {
        expiryDate = metadata.expiryDate;
      } else if (metadata is CertificateMetadata) {
        expiryDate = metadata.expiryDate;
      } else if (metadata is UnknownMetadata) {
        // Try to extract expiry from unknown data
        if (metadata.data['expiryDate'] != null) {
          try {
            expiryDate = DateTime.parse(metadata.data['expiryDate'].toString());
          } catch (e) {
            // Ignore parse errors
          }
        }
      }
      
      if (expiryDate != null) {
        final daysUntilExpiry = expiryDate.difference(now).inDays;
        String period;
        
        if (daysUntilExpiry < 0) {
          period = 'Expired';
        } else if (daysUntilExpiry <= 30) {
          period = 'Next 30 days';
        } else if (daysUntilExpiry <= 90) {
          period = 'Next 3 months';
        } else if (daysUntilExpiry <= 180) {
          period = 'Next 6 months';
        } else {
          period = 'More than 6 months';
        }
        
        groups.putIfAbsent(period, () => []).add(doc);
      }
    }
    
    return groups;
  }
}
