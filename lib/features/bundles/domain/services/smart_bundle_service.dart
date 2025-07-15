// lib/features/bundles/domain/services/smart_bundle_service.dart
import '../entities/bundle.dart';
import '../entities/bundle_template.dart';
import '../../../documents/domain/entities/document.dart';
import '../../../documents/domain/entities/document_type.dart';
import 'package:fpdart/fpdart.dart';

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
      
      // Extract person name from metadata based on document type
      doc.metadata.when(
        ktp: (nik, fullName, birthPlace, birthDate, gender, bloodType, address, 
              rt, rw, kelurahan, kecamatan, religion, maritalStatus, occupation,
              citizenship, issuedDate, issuedBy, expiryDate) {
          personName = fullName;
        },
        sim: (simNumber, holderName, simType, issuedDate, expiryDate, 
              issuingOffice, address, birthDate) {
          personName = holderName;
        },
        passport: (passportNumber, holderName, nationality, birthDate, birthPlace, 
                   gender, issuedDate, expiryDate, issuingAuthority, placeOfIssue) {
          personName = holderName;
        },
        ielts: (candidateNumber, testReportNumber, testDate, expiryDate,
                overallBand, listeningScore, readingScore, writingScore, 
                speakingScore, testCenter, candidateName) {
          personName = candidateName;
        },
        transcript: (studentId, studentName, university, degree, major, gpa, 
                     graduationDate, issuedDate, facultyDean) {
          personName = studentName;
        },
        cv: (fullName, profession, email, phoneNumber, lastUpdated, summary, yearsOfExperience) {
          personName = fullName;
        },
        certificate: (certificateName, holderName, issuingOrganization, issuedDate, 
                      expiryDate, certificateNumber, level) {
          personName = holderName;
        },
        diploma: (diplomaNumber, graduateName, institution, degree, major, 
                  graduationDate, gpa, honors) {
          personName = graduateName;
        },
        unknown: (data) {
          // Try to extract name from unknown data
          if (data['name'] != null) personName = data['name'].toString();
          if (data['fullName'] != null) personName = data['fullName'].toString();
        },
      );
      
      if (personName != null && personName!.isNotEmpty) {
        groups.putIfAbsent(personName!, () => []).add(doc);
      }
    }
    
    return groups;
  }
  
  static Map<String, List<Document>> _groupByExpiryPeriod(List<Document> documents) {
    final groups = <String, List<Document>>{};
    final now = DateTime.now();
    
    for (final doc in documents) {
      DateTime? expiryDate;
      
      // Extract expiry date from metadata
      doc.metadata.when(
        ktp: (nik, fullName, birthPlace, birthDate, gender, bloodType, address, 
              rt, rw, kelurahan, kecamatan, religion, maritalStatus, occupation,
              citizenship, issuedDate, issuedBy, expiry) {
          expiryDate = expiry;
        },
        sim: (simNumber, holderName, simType, issuedDate, expiry, 
              issuingOffice, address, birthDate) {
          expiryDate = expiry;
        },
        passport: (passportNumber, holderName, nationality, birthDate, birthPlace, 
                   gender, issuedDate, expiry, issuingAuthority, placeOfIssue) {
          expiryDate = expiry;
        },
        ielts: (candidateNumber, testReportNumber, testDate, expiry,
                overallBand, listeningScore, readingScore, writingScore, 
                speakingScore, testCenter, candidateName) {
          expiryDate = expiry;
        },
        certificate: (certificateName, holderName, issuingOrganization, issuedDate, 
                      expiry, certificateNumber, level) {
          expiryDate = expiry;
        },
        transcript: (studentId, studentName, university, degree, major, gpa, 
                     graduationDate, issuedDate, facultyDean) {
          // Transcripts don't typically expire
        },
        cv: (fullName, profession, email, phoneNumber, lastUpdated, summary, yearsOfExperience) {
          // CVs don't expire
        },
        diploma: (diplomaNumber, graduateName, institution, degree, major, 
                  graduationDate, gpa, honors) {
          // Diplomas don't expire
        },
        unknown: (data) {
          // Try to extract expiry from unknown data
          if (data['expiryDate'] != null) {
            try {
              expiryDate = DateTime.parse(data['expiryDate'].toString());
            } catch (e) {
              // Ignore parse errors
            }
          }
        },
      );
      
      if (expiryDate != null) {
        final daysUntilExpiry = expiryDate!.difference(now).inDays;
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
