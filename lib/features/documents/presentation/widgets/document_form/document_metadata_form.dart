import 'package:flutter/material.dart';
import '../../../domain/entities/document_type.dart';
import 'ktp_metadata_form.dart';

class DocumentMetadataForm extends StatelessWidget {
  final DocumentType type;

  const DocumentMetadataForm({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case DocumentType.ktp:
        return const KTPMetadataForm();
      case DocumentType.sim:
      case DocumentType.passport:
      case DocumentType.ijazah:
      case DocumentType.sertifikat:
      case DocumentType.lainnya:
        return const SizedBox.shrink(); // Tambahkan form untuk tipe lain
    }
  }
} 