import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/document.dart';
import '../../domain/entities/document_type.dart';
import '../../domain/entities/metadata/document_metadata.dart';
import '../providers/document_providers.dart';
import '../widgets/document_form/document_form.dart';
import '../widgets/document_form/ktp_metadata_form.dart';

class AddEditDocumentPage extends ConsumerStatefulWidget {
  final String? documentId;

  const AddEditDocumentPage({
    super.key,
    this.documentId,
  });

  @override
  ConsumerState<AddEditDocumentPage> createState() => _AddEditDocumentPageState();
}

class _AddEditDocumentPageState extends ConsumerState<AddEditDocumentPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _tagsController;
  DocumentType _selectedType = DocumentType.lainnya;
  bool _isFavorite = false;
  bool _isLoading = false;
  DateTime? _expiryDate;
  List<String> _tags = [];

  // KTP Metadata Controllers
  final _nikController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _birthPlaceController = TextEditingController();
  DateTime? _birthDate;
  String _selectedGender = 'L';
  String _selectedBloodType = 'A';
  final _addressController = TextEditingController();
  final _rtController = TextEditingController();
  final _rwController = TextEditingController();
  final _kelurahanController = TextEditingController();
  final _kecamatanController = TextEditingController();
  final _religionController = TextEditingController();
  final _maritalStatusController = TextEditingController();
  final _occupationController = TextEditingController();
  final _citizenshipController = TextEditingController();
  DateTime? _issuedDate;
  final _issuedByController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _tagsController = TextEditingController();
    _loadDocument();
  }

  Future<void> _loadDocument() async {
    if (widget.documentId != null) {
      try {
        final document = await ref
            .read(getDocumentByIdProvider(widget.documentId!))
            .value;
        if (document != null) {
          setState(() {
            _titleController.text = document.title;
            _descriptionController.text = document.description ?? '';
            _selectedType = document.type;
            _isFavorite = document.isFavorite;
            _expiryDate = document.expiryDate;
            _tags = document.tags;
            _tagsController.text = document.tags.join(', ');

            // Load metadata based on type
            document.metadata.when(
              ktp: (nik, fullName, birthPlace, birthDate, gender, bloodType,
                  address, rt, rw, kelurahan, kecamatan, religion, maritalStatus,
                  occupation, citizenship, issuedDate, issuedBy) {
                _nikController.text = nik;
                _fullNameController.text = fullName;
                _birthPlaceController.text = birthPlace;
                _birthDate = birthDate;
                _selectedGender = gender;
                _selectedBloodType = bloodType;
                _addressController.text = address;
                _rtController.text = rt;
                _rwController.text = rw;
                _kelurahanController.text = kelurahan;
                _kecamatanController.text = kecamatan;
                _religionController.text = religion;
                _maritalStatusController.text = maritalStatus;
                _occupationController.text = occupation;
                _citizenshipController.text = citizenship;
                _issuedDate = issuedDate;
                _issuedByController.text = issuedBy;
              },
              ielts: (_, __, ___, ____, _____, ______, _______, ________,
                  _________, __________) {
                // Handle IELTS metadata
              },
              unknown: (_) {},
            );
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
    _nikController.dispose();
    _fullNameController.dispose();
    _birthPlaceController.dispose();
    _addressController.dispose();
    _rtController.dispose();
    _rwController.dispose();
    _kelurahanController.dispose();
    _kecamatanController.dispose();
    _religionController.dispose();
    _maritalStatusController.dispose();
    _occupationController.dispose();
    _citizenshipController.dispose();
    _issuedByController.dispose();
    super.dispose();
  }

  Future<void> _saveDocument() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Parse tags
      _tags = _tagsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      // Create metadata based on document type
      late final DocumentMetadata metadata;
      switch (_selectedType) {
        case DocumentType.ktp:
          metadata = DocumentMetadata.ktp(
            nik: _nikController.text,
            fullName: _fullNameController.text,
            birthPlace: _birthPlaceController.text,
            birthDate: _birthDate!,
            gender: _selectedGender,
            bloodType: _selectedBloodType,
            address: _addressController.text,
            rt: _rtController.text,
            rw: _rwController.text,
            kelurahan: _kelurahanController.text,
            kecamatan: _kecamatanController.text,
            religion: _religionController.text,
            maritalStatus: _maritalStatusController.text,
            occupation: _occupationController.text,
            citizenship: _citizenshipController.text,
            issuedDate: _issuedDate!,
            issuedBy: _issuedByController.text,
          );
          break;
        case DocumentType.sim:
        case DocumentType.passport:
        case DocumentType.ijazah:
        case DocumentType.sertifikat:
        case DocumentType.lainnya:
          metadata = DocumentMetadata.unknown({});
          break;
      }

      final document = Document(
        id: widget.documentId ?? '',
        title: _titleController.text,
        description: _descriptionController.text,
        type: _selectedType,
        tags: _tags,
        expiryDate: _expiryDate,
        isFavorite: _isFavorite,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        metadata: metadata,
      );

      if (widget.documentId != null) {
        await ref
            .read(documentsNotifierProvider.notifier)
            .updateDocument(document);
      } else {
        await ref
            .read(documentsNotifierProvider.notifier)
            .addDocument(document);
      }

      if (mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.documentId != null
                  ? 'Dokumen berhasil diperbarui'
                  : 'Dokumen berhasil ditambahkan',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.documentId != null ? 'Edit Dokumen' : 'Tambah Dokumen',
        ),
      ),
      body: DocumentForm(
        formKey: _formKey,
        titleController: _titleController,
        descriptionController: _descriptionController,
        tagsController: _tagsController,
        selectedType: _selectedType,
        isFavorite: _isFavorite,
        expiryDate: _expiryDate,
        onTypeChanged: (type) => setState(() => _selectedType = type),
        onFavoriteChanged: (value) => setState(() => _isFavorite = value),
        onExpiryDateChanged: (date) => setState(() => _expiryDate = date),
        isLoading: _isLoading,
        onSave: _saveDocument,
        submitLabel: widget.documentId != null ? 'Perbarui' : 'Simpan',
      ),
    );
  }
}
