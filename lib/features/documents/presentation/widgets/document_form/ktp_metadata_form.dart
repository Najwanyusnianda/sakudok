import 'package:flutter/material.dart';
import '../../../domain/entities/metadata/document_metadata.dart';

class KTPMetadataForm extends StatefulWidget {
  final DocumentMetadata? initialData;
  final Function(DocumentMetadata) onDataChanged;

  const KTPMetadataForm({
    super.key,
    this.initialData,
    required this.onDataChanged,
  });

  @override
  State<KTPMetadataForm> createState() => _KTPMetadataFormState();
}

class _KTPMetadataFormState extends State<KTPMetadataForm> {
  final _formKey = GlobalKey<FormState>();
  
  // Core Required Fields - Enable intelligent document recognition
  final _nikController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _birthPlaceController = TextEditingController();
  final _addressController = TextEditingController();
  
  // Additional Smart Fields - Enable context-aware features
  final _bloodTypeController = TextEditingController();
  final _rtController = TextEditingController();
  final _rwController = TextEditingController();
  final _kelurahanController = TextEditingController();
  final _kecamatanController = TextEditingController();
  final _religionController = TextEditingController();
  final _maritalStatusController = TextEditingController();
  final _occupationController = TextEditingController();
  final _citizenshipController = TextEditingController();
  final _issuedByController = TextEditingController();
  
  DateTime? _birthDate;
  DateTime? _issuedDate;
  String _selectedGender = 'L';

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _loadInitialData();
    }
    _updateMetadata();
  }

  void _loadInitialData() {
    widget.initialData!.when(
      ktp: (nik, fullName, birthPlace, birthDate, gender, bloodType, address,
          rt, rw, kelurahan, kecamatan, religion, maritalStatus, occupation,
          citizenship, issuedDate, issuedBy, expiryDate) {
        _nikController.text = nik;
        _fullNameController.text = fullName;
        _birthPlaceController.text = birthPlace;
        _birthDate = birthDate;
        _selectedGender = gender;
        _bloodTypeController.text = bloodType ?? '';
        _addressController.text = address;
        _rtController.text = rt ?? '';
        _rwController.text = rw ?? '';
        _kelurahanController.text = kelurahan ?? '';
        _kecamatanController.text = kecamatan ?? '';
        _religionController.text = religion ?? '';
        _maritalStatusController.text = maritalStatus ?? '';
        _occupationController.text = occupation ?? '';
        _citizenshipController.text = citizenship ?? '';
        _issuedDate = issuedDate;
        _issuedByController.text = issuedBy ?? '';
      },
      sim: (_, __, ___, ____, _____, ______, _______, ________) {},
      passport: (_, __, ___, ____, _____, ______, _______, ________, _________, __________) {},
      ielts: (_, __, ___, ____, _____, ______, _______, ________, _________, __________, ___________) {},
      transcript: (_, __, ___, ____, _____, ______, _______, ________, _________) {},
      cv: (_, __, ___, ____, _____, ______, _______) {},
      certificate: (_, __, ___, ____, _____, ______, _______) {},
      diploma: (_, __, ___, ____, _____, ______, _______, ________) {},
      unknown: (_) {},
    );
  }

  void _updateMetadata() {
    if (_nikController.text.isNotEmpty && 
        _fullNameController.text.isNotEmpty && 
        _birthPlaceController.text.isNotEmpty &&
        _addressController.text.isNotEmpty &&
        _birthDate != null) {
      
      final metadata = DocumentMetadata.ktp(
        nik: _nikController.text,
        fullName: _fullNameController.text,
        birthPlace: _birthPlaceController.text,
        birthDate: _birthDate!,
        gender: _selectedGender,
        bloodType: _bloodTypeController.text.isEmpty ? null : _bloodTypeController.text,
        address: _addressController.text,
        rt: _rtController.text.isEmpty ? null : _rtController.text,
        rw: _rwController.text.isEmpty ? null : _rwController.text,
        kelurahan: _kelurahanController.text.isEmpty ? null : _kelurahanController.text,
        kecamatan: _kecamatanController.text.isEmpty ? null : _kecamatanController.text,
        religion: _religionController.text.isEmpty ? null : _religionController.text,
        maritalStatus: _maritalStatusController.text.isEmpty ? null : _maritalStatusController.text,
        occupation: _occupationController.text.isEmpty ? null : _occupationController.text,
        citizenship: _citizenshipController.text.isEmpty ? null : _citizenshipController.text,
        issuedDate: _issuedDate,
        issuedBy: _issuedByController.text.isEmpty ? null : _issuedByController.text,
      );
      
      widget.onDataChanged(metadata);
    }
  }

  @override
  void dispose() {
    _nikController.dispose();
    _fullNameController.dispose();
    _birthPlaceController.dispose();
    _addressController.dispose();
    _bloodTypeController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header explaining the intelligent approach
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.smart_toy, color: Colors.blue.shade700),
                    const SizedBox(width: 8),
                    Text(
                      'Smart KTP Recognition',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'These fields enable intelligent search, bundle organization, and smart reminders.',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Core Required Fields Section
          _buildSectionHeader('Essential Information', Icons.assignment_ind),
          const SizedBox(height: 16),
          
          // NIK - Critical for unique identification
          TextFormField(
            controller: _nikController,
            decoration: const InputDecoration(
              labelText: 'NIK (Required)*',
              border: OutlineInputBorder(),
              hintText: '16-digit unique identifier',
              prefixIcon: Icon(Icons.fingerprint),
            ),
            keyboardType: TextInputType.number,
            maxLength: 16,
            onChanged: (_) => _updateMetadata(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'NIK is required for smart document recognition';
              }
              if (value.length != 16) {
                return 'NIK must be exactly 16 digits';
              }
              if (!RegExp(r'^\d+$').hasMatch(value)) {
                return 'NIK must contain only numbers';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Full Name - Critical for smart search
          TextFormField(
            controller: _fullNameController,
            decoration: const InputDecoration(
              labelText: 'Full Name (Required)*',
              border: OutlineInputBorder(),
              hintText: 'As written on KTP',
              prefixIcon: Icon(Icons.person),
            ),
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => _updateMetadata(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Full name is required for smart search';
              }
              if (value.length < 2) {
                return 'Name is too short';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Birth Place & Date - Enable age-based smart features
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: _birthPlaceController,
                  decoration: const InputDecoration(
                    labelText: 'Birth Place (Required)*',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_city),
                  ),
                  textCapitalization: TextCapitalization.words,
                  onChanged: (_) => _updateMetadata(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Birth place required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: InkWell(
                  onTap: () => _selectDate(context, true),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Birth Date*',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    child: Text(
                      _birthDate == null 
                        ? 'Select date' 
                        : '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}',
                      style: TextStyle(
                        color: _birthDate == null ? Colors.grey : null,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Gender - Essential for smart categorization
          DropdownButtonFormField<String>(
            value: _selectedGender,
            decoration: const InputDecoration(
              labelText: 'Gender (Required)*',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.wc),
            ),
            items: const [
              DropdownMenuItem(value: 'L', child: Text('Laki-laki')),
              DropdownMenuItem(value: 'P', child: Text('Perempuan')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedGender = value!;
              });
              _updateMetadata();
            },
          ),
          const SizedBox(height: 16),

          // Address - Required for smart location features
          TextFormField(
            controller: _addressController,
            decoration: const InputDecoration(
              labelText: 'Address (Required)*',
              border: OutlineInputBorder(),
              hintText: 'Complete address as on KTP',
              prefixIcon: Icon(Icons.home),
            ),
            textCapitalization: TextCapitalization.words,
            maxLines: 2,
            onChanged: (_) => _updateMetadata(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Address is required for location-based features';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          // Additional Smart Fields Section
          _buildSectionHeader('Additional Smart Data', Icons.extension),
          const SizedBox(height: 8),
          const Text(
            'Optional fields that enable advanced intelligent features like bundle auto-completion.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 16),

          // Location Details - Enable smart regional grouping
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _rtController,
                  decoration: const InputDecoration(
                    labelText: 'RT',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => _updateMetadata(),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: _rwController,
                  decoration: const InputDecoration(
                    labelText: 'RW',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => _updateMetadata(),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: _kelurahanController,
                  decoration: const InputDecoration(
                    labelText: 'Kelurahan',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                  onChanged: (_) => _updateMetadata(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _kecamatanController,
                  decoration: const InputDecoration(
                    labelText: 'Kecamatan',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                  onChanged: (_) => _updateMetadata(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _bloodTypeController,
                  decoration: const InputDecoration(
                    labelText: 'Blood Type',
                    border: OutlineInputBorder(),
                    hintText: 'A, B, AB, O',
                  ),
                  onChanged: (_) => _updateMetadata(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Personal Details - Enable smart demographic features
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _religionController,
                  decoration: const InputDecoration(
                    labelText: 'Religion',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                  onChanged: (_) => _updateMetadata(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _maritalStatusController,
                  decoration: const InputDecoration(
                    labelText: 'Marital Status',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                  onChanged: (_) => _updateMetadata(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _occupationController,
                  decoration: const InputDecoration(
                    labelText: 'Occupation',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                  onChanged: (_) => _updateMetadata(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _citizenshipController,
                  decoration: const InputDecoration(
                    labelText: 'Citizenship',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                  onChanged: (_) => _updateMetadata(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Issue Details - Enable smart document validity tracking
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _selectDate(context, false),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Issue Date',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.date_range),
                    ),
                    child: Text(
                      _issuedDate == null 
                        ? 'Select date' 
                        : '${_issuedDate!.day}/${_issuedDate!.month}/${_issuedDate!.year}',
                      style: TextStyle(
                        color: _issuedDate == null ? Colors.grey : null,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _issuedByController,
                  decoration: const InputDecoration(
                    labelText: 'Issued By',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                  onChanged: (_) => _updateMetadata(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Smart Features Preview
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.green.shade700),
                    const SizedBox(width: 8),
                    Text(
                      'Smart Features Unlocked',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  '• Search by NIK instantly\n'
                  '• Auto-complete job application bundles\n'
                  '• Smart document organization by location\n'
                  '• Contextual reminders based on document type',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue.shade700),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade700,
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context, bool isBirthDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isBirthDate 
        ? (_birthDate ?? DateTime(1990)) 
        : (_issuedDate ?? DateTime.now()),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      setState(() {
        if (isBirthDate) {
          _birthDate = picked;
        } else {
          _issuedDate = picked;
        }
      });
      _updateMetadata();
    }
  }
}