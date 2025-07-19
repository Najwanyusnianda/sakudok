// lib/features/bundles/data/mappers/bundle_slot_mapper.dart
import 'package:drift/drift.dart';
import '../../domain/entities/bundle_slot.dart' as domain;
import '../../../../core/database/app_database.dart';

class BundleSlotMapper {
  static domain.BundleSlot fromDb(BundleSlot dbSlot) {
    return domain.BundleSlot(
      id: dbSlot.id.toString(),
      bundleId: dbSlot.bundleId.toString(),
      requirementName: dbSlot.requirementName,
      requiredDocType: dbSlot.requiredDocType,
      attachedDocId: dbSlot.attachedDocId?.toString(),
      isRequired: dbSlot.isRequired,
      displayOrder: dbSlot.displayOrder,
      createdAt: dbSlot.createdAt,
      updatedAt: dbSlot.updatedAt,
    );
  }

  static BundleSlotsCompanion toDb(domain.BundleSlot domainSlot, {bool isInserting = false}) {
    return BundleSlotsCompanion.insert(
      id: isInserting ? const Value.absent() : Value(int.parse(domainSlot.id)),
      bundleId: int.parse(domainSlot.bundleId),
      requirementName: domainSlot.requirementName,
      requiredDocType: domainSlot.requiredDocType,
      attachedDocId: domainSlot.attachedDocId != null 
          ? Value(int.parse(domainSlot.attachedDocId!)) 
          : const Value(null),
      isRequired: Value(domainSlot.isRequired),
      displayOrder: Value(domainSlot.displayOrder),
      createdAt: Value(domainSlot.createdAt),
      updatedAt: Value(domainSlot.updatedAt),
    );
  }
}
