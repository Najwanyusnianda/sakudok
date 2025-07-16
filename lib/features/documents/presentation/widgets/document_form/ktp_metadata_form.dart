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
  
  // --- Kategori 1: Wajib Ada ---
  final _nikController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _birthPlaceController = TextEditingController();
  final _addressController = TextEditingController();
  final _berlakuHinggaController = TextEditingController();
  
  // --- Kategori 2: Sangat Berguna (bisa nullable) ---
  final _maritalStatusController = TextEditingController();
  final _occupationController = TextEditingController();
  final _citizenshipController = TextEditingController();
  
  DateTime? _birthDate;
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
      ktp: (nik, fullName, birthPlace, birthDate, address, gender, berlakuHingga,
          maritalStatus, occupation, citizenship) {
        _nikController.text = nik;
        _fullNameController.text = fullName;
        _birthPlaceController.text = birthPlace;
        _birthDate = birthDate;
        _addressController.text = address;
        _selectedGender = gender;
        _berlakuHinggaController.text = berlakuHingga;
        _maritalStatusController.text = maritalStatus ?? '';
        _occupationController.text = occupation ?? '';
        _citizenshipController.text = citizenship ?? '';
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
        _berlakuHinggaController.text.isNotEmpty &&
        _birthDate != null) {
      
      final metadata = DocumentMetadata.ktp(
        nik: _nikController.text,
        fullName: _fullNameController.text,
        birthPlace: _birthPlaceController.text,
        birthDate: _birthDate!,
        address: _addressController.text,
        gender: _selectedGender,
        berlakuHingga: _berlakuHinggaController.text,
        maritalStatus: _maritalStatusController.text.isEmpty ? null : _maritalStatusController.text,
        occupation: _occupationController.text.isEmpty ? null : _occupationController.text,
        citizenship: _citizenshipController.text.isEmpty ? null : _citizenshipController.text,
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
    _berlakuHinggaController.dispose();
    _maritalStatusController.dispose();
    _occupationController.dispose();
    _citizenshipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header explaining the streamlined approach
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
                  'Streamlined fields for better performance and usability while maintaining smart features.',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // --- Kategori 1: Wajib Ada ---
          _buildSectionHeader('Essential Information (Required)', Icons.assignment_ind),
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

          // Full Name - Critical for bundle organization
          TextFormField(
            controller: _fullNameController,
            decoration: const InputDecoration(
              labelText: 'Full Name (Required)*',
              border: OutlineInputBorder(),
              hintText: 'Name as on KTP',
              prefixIcon: Icon(Icons.person),
            ),
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => _updateMetadata(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Full name is required for bundle organization';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Birth Place & Date
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
                  onTap: () => _selectDate(context),
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

          // Berlaku Hingga - Handle "SEUMUR HIDUP" or date
          TextFormField(
            controller: _berlakuHinggaController,
            decoration: const InputDecoration(
              labelText: 'Berlaku Hingga (Required)*',
              border: OutlineInputBorder(),
              hintText: 'SEUMUR HIDUP or specific date',
              prefixIcon: Icon(Icons.schedule),
            ),
            onChanged: (_) => _updateMetadata(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Berlaku hingga is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          // --- Kategori 2: Sangat Berguna (Optional) ---
          _buildSectionHeader('Additional Information (Optional)', Icons.extension),
          const SizedBox(height: 8),
          const Text(
            'These fields enable enhanced smart features like advanced bundle organization.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 16),

          // Marital Status
          TextFormField(
            controller: _maritalStatusController,
            decoration: const InputDecoration(
              labelText: 'Marital Status',
              border: OutlineInputBorder(),
              hintText: 'e.g., Belum Kawin, Kawin, Cerai',
              prefixIcon: Icon(Icons.favorite),
            ),
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => _updateMetadata(),
          ),
          const SizedBox(height: 16),

          // Occupation
          TextFormField(
            controller: _occupationController,
            decoration: const InputDecoration(
              labelText: 'Occupation',
              border: OutlineInputBorder(),
              hintText: 'Professional occupation',
              prefixIcon: Icon(Icons.work),
            ),
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => _updateMetadata(),
          ),
          const SizedBox(height: 16),

          // Citizenship
          TextFormField(
            controller: _citizenshipController,
            decoration: const InputDecoration(
              labelText: 'Citizenship',
              border: OutlineInputBorder(),
              hintText: 'e.g., WNI, WNA',
              prefixIcon: Icon(Icons.flag),
            ),
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => _updateMetadata(),
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
                      'Smart Features Enabled',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  '• Instant search by NIK or name\n'
                  '• Smart bundle organization by person\n'
                  '• Enhanced document categorization\n'
                  '• Better performance with focused metadata',
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      setState(() {
        _birthDate = picked;
      });
      _updateMetadata();
    }
  }
}
