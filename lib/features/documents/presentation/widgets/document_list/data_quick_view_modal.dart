// lib/features/documents/presentation/widgets/document_list/data_quick_view_modal.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../domain/entities/document.dart';
import '../../../domain/entities/metadata/document_metadata.dart';

class DataQuickViewModal extends StatelessWidget {
  final Document document;
  final VoidCallback? onEditData;
  final VoidCallback? onViewFile;

  const DataQuickViewModal({
    super.key,
    required this.document,
    this.onEditData,
    this.onViewFile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          _buildHeader(context),
          
          // Content
          Flexible(
            child: _buildContent(context),
          ),
          
          // Action Buttons
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 16, 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Document Details',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  document.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 24),
            onPressed: () => Navigator.of(context).pop(),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final metadata = document.metadata;
    
    if (metadata == null) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              Icons.info_outline,
              size: 48,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No structured data available',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This document doesn\'t have any structured data yet. You can add data to make it more useful.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    final dataEntries = _extractDataEntries(metadata);
    
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      itemCount: dataEntries.length,
      separatorBuilder: (context, index) => const Divider(height: 24),
      itemBuilder: (context, index) {
        final entry = dataEntries[index];
        return _buildDataEntry(context, entry);
      },
    );
  }

  Widget _buildDataEntry(BuildContext context, MapEntry<String, String> entry) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                entry.value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.copy,
            size: 18,
            color: Colors.grey.shade600,
          ),
          onPressed: () => _copyToClipboard(context, entry.value),
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(
            minWidth: 32,
            minHeight: 32,
          ),
          tooltip: 'Copy value',
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          if (onEditData != null)
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  onEditData?.call();
                },
                icon: const Icon(Icons.edit, size: 18),
                label: const Text('Edit Data'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          if (onEditData != null && onViewFile != null)
            const SizedBox(width: 12),
          if (onViewFile != null)
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  onViewFile?.call();
                },
                icon: const Icon(Icons.visibility, size: 18),
                label: const Text('View Document'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<MapEntry<String, String>> _extractDataEntries(DocumentMetadata metadata) {
    final Map<String, String> data = {};
    
    // Handle different metadata types
    if (metadata is KTPMetadata) {
      if (metadata.nik.isNotEmpty) data['NIK'] = metadata.nik;
      if (metadata.fullName.isNotEmpty) data['Full Name'] = metadata.fullName;
      if (metadata.birthPlace.isNotEmpty) data['Birth Place'] = metadata.birthPlace;
      data['Birth Date'] = _formatDate(metadata.birthDate);
      if (metadata.gender.isNotEmpty) data['Gender'] = metadata.gender;
      if (metadata.address.isNotEmpty) data['Address'] = metadata.address;
      if (metadata.maritalStatus?.isNotEmpty == true) data['Marital Status'] = metadata.maritalStatus!;
      if (metadata.occupation?.isNotEmpty == true) data['Occupation'] = metadata.occupation!;
      if (metadata.citizenship?.isNotEmpty == true) data['Citizenship'] = metadata.citizenship!;
      if (metadata.berlakuHingga.isNotEmpty) data['Valid Until'] = metadata.berlakuHingga;
    } else if (metadata is SIMMetadata) {
      if (metadata.simNumber.isNotEmpty) data['SIM Number'] = metadata.simNumber;
      if (metadata.holderName.isNotEmpty) data['Holder Name'] = metadata.holderName;
      if (metadata.simType.isNotEmpty) data['SIM Type'] = metadata.simType;
      data['Issued Date'] = _formatDate(metadata.issuedDate);
      data['Expiry Date'] = _formatDate(metadata.expiryDate);
      if (metadata.issuingOffice?.isNotEmpty == true) data['Issuing Office'] = metadata.issuingOffice!;
      if (metadata.address?.isNotEmpty == true) data['Address'] = metadata.address!;
      if (metadata.birthDate != null) {
        data['Birth Date'] = _formatDate(metadata.birthDate!);
      }
    }
    
    return data.entries.toList();
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  void _copyToClipboard(BuildContext context, String value) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Copied!'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  static void show(
    BuildContext context,
    Document document, {
    VoidCallback? onEditData,
    VoidCallback? onViewFile,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => DataQuickViewModal(
          document: document,
          onEditData: onEditData,
          onViewFile: onViewFile,
        ),
      ),
    );
  }
}
