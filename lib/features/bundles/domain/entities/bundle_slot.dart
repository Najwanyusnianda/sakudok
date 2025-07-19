// lib/features/bundles/domain/entities/bundle_slot.dart
import 'package:equatable/equatable.dart';

class BundleSlot extends Equatable {
  final String id;
  final String bundleId;
  final String requirementName;
  final String requiredDocType;
  final String? attachedDocId;
  final bool isRequired;
  final int displayOrder;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BundleSlot({
    required this.id,
    required this.bundleId,
    required this.requirementName,
    required this.requiredDocType,
    this.attachedDocId,
    this.isRequired = true,
    this.displayOrder = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isEmpty => attachedDocId == null;
  bool get isFilled => attachedDocId != null;

  BundleSlot copyWith({
    String? id,
    String? bundleId,
    String? requirementName,
    String? requiredDocType,
    String? attachedDocId,
    bool? isRequired,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BundleSlot(
      id: id ?? this.id,
      bundleId: bundleId ?? this.bundleId,
      requirementName: requirementName ?? this.requirementName,
      requiredDocType: requiredDocType ?? this.requiredDocType,
      attachedDocId: attachedDocId ?? this.attachedDocId,
      isRequired: isRequired ?? this.isRequired,
      displayOrder: displayOrder ?? this.displayOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        bundleId,
        requirementName,
        requiredDocType,
        attachedDocId,
        isRequired,
        displayOrder,
        createdAt,
        updatedAt,
      ];
}
