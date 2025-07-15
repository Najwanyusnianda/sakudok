import 'package:flutter/material.dart';
import '../../../domain/entities/metadata/document_metadata.dart';

class SIMMetadataForm extends StatefulWidget {
  final DocumentMetadata? initialData;
  final Function(DocumentMetadata) onDataChanged;

  const SIMMetadataForm({
    super.key,
    this.initialData,
    required this.onDataChanged,
  });

  @override
  State<SIMMetadataForm> createState() => _SIMMetadataFormState();
}

class _SIMMetadataFormState extends State<SIMMetadataForm> {
  final _formKey = GlobalKey<FormState>();
  
  // Core SIM Fields - Enable intelligent features
  final _simNumberController = TextEditingController();
  final _holderNameController = TextEditingController();
  final _issuingOfficeController = TextEditingController();
  final _addressController = TextEditingController();
  
  String _selectedSimType = 'A';
  DateTime? _issuedDate;
  DateTime? _expiryDate;
  DateTime? _birthDate;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _loadInitialData();
    }
  }

  void _loadInitialData() {
    widget.initialData!.when(
      sim: (simNumber, holderName, simType, issuedDate, expiryDate, 
           issuingOffice, address, birthDate) {
        _simNumberController.text = simNumber;
        _holderNameController.text = holderName;
        _selectedSimType = simType;
        _issuedDate = issuedDate;
        _expiryDate = expiryDate;
        _issuingOfficeController.text = issuingOffice ?? '';
        _addressController.text = address ?? '';
        _birthDate = birthDate;
      },
      ktp: (_, __, ___, ____, _____, ______, _______, ________, _________, 
           __________, ___________, ____________, _____________, ______________, 
           _______________, ________________, _________________, __________________) {},
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
    if (_simNumberController.text.isNotEmpty && 
        _holderNameController.text.isNotEmpty && 
        _issuedDate != null &&
        _expiryDate != null) {
      
      final metadata = DocumentMetadata.sim(
        simNumber: _simNumberController.text,
        holderName: _holderNameController.text,
        simType: _selectedSimType,
        issuedDate: _issuedDate!,
        expiryDate: _expiryDate!,
        issuingOffice: _issuingOfficeController.text.isEmpty ? null : _issuingOfficeController.text,
        address: _addressController.text.isEmpty ? null : _addressController.text,
        birthDate: _birthDate,
      );
      
      widget.onDataChanged(metadata);
    }
  }

  @override
  void dispose() {
    _simNumberController.dispose();
    _holderNameController.dispose();
    _issuingOfficeController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Smart SIM Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.drive_eta, color: Colors.orange.shade700),
                    const SizedBox(width: 8),
                    Text(
                      'Smart SIM Management',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Expiry date enables 30-day renewal reminders. SIM type enables vehicle bundle auto-completion.',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // SIM Number - Critical for identification
          TextFormField(
            controller: _simNumberController,
            decoration: const InputDecoration(
              labelText: 'SIM Number (Required)*',
              border: OutlineInputBorder(),
              hintText: 'License number',
              prefixIcon: Icon(Icons.confirmation_number),
            ),
            onChanged: (_) => _updateMetadata(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'SIM number is required for smart identification';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Holder Name - For smart search
          TextFormField(
            controller: _holderNameController,
            decoration: const InputDecoration(
              labelText: 'License Holder Name (Required)*',
              border: OutlineInputBorder(),
              hintText: 'As written on SIM',
              prefixIcon: Icon(Icons.person),
            ),
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => _updateMetadata(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Holder name is required for smart search';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // SIM Type - Critical for vehicle bundle intelligence
          DropdownButtonFormField<String>(
            value: _selectedSimType,
            decoration: const InputDecoration(
              labelText: 'SIM Type (Required)*',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.category),
            ),
            items: const [
              DropdownMenuItem(value: 'A', child: Text('SIM A (Motorcycle)')),
              DropdownMenuItem(value: 'B1', child: Text('SIM B1 (Car < 3500kg)')),
              DropdownMenuItem(value: 'B2', child: Text('SIM B2 (Car > 3500kg)')),
              DropdownMenuItem(value: 'C', child: Text('SIM C (Truck)')),
              DropdownMenuItem(value: 'D', child: Text('SIM D (Bus)')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedSimType = value!;
              });
              _updateMetadata();
            },
          ),
          const SizedBox(height: 16),

          // Critical Dates - Enable Smart Reminders
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _selectDate(context, 'issued'),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Issue Date (Required)*',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.calendar_today),
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
                child: InkWell(
                  onTap: () => _selectDate(context, 'expiry'),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Expiry Date (Required)*',
                      border: const OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.warning,
                        color: _expiryDate != null && 
                               DateTime.now().difference(_expiryDate!).inDays > -30
                          ? Colors.red 
                          : null,
                      ),
                    ),
                    child: Text(
                      _expiryDate == null 
                        ? 'Select date' 
                        : '${_expiryDate!.day}/${_expiryDate!.month}/${_expiryDate!.year}',
                      style: TextStyle(
                        color: _expiryDate == null 
                          ? Colors.grey 
                          : _expiryDate != null && 
                            DateTime.now().difference(_expiryDate!).inDays > -30
                            ? Colors.red
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Additional Details
          TextFormField(
            controller: _issuingOfficeController,
            decoration: const InputDecoration(
              labelText: 'Issuing Office',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_on),
            ),
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => _updateMetadata(),
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: _addressController,
            decoration: const InputDecoration(
              labelText: 'Address',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.home),
            ),
            textCapitalization: TextCapitalization.words,
            maxLines: 2,
            onChanged: (_) => _updateMetadata(),
          ),
          const SizedBox(height: 16),

          // Birth Date
          InkWell(
            onTap: () => _selectDate(context, 'birth'),
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Birth Date',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.cake),
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
          const SizedBox(height: 24),

          // Smart Features for SIM
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
                    Icon(Icons.auto_awesome, color: Colors.green.shade700),
                    const SizedBox(width: 8),
                    Text(
                      'SIM Smart Features',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '• 30-day renewal reminder before expiry\n'
                  '• Auto-complete vehicle registration bundles\n'
                  '• Smart search by SIM number or name\n'
                  '• License type validation for vehicle compatibility',
                  style: const TextStyle(fontSize: 12),
                ),
                if (_expiryDate != null && 
                    DateTime.now().difference(_expiryDate!).inDays > -30) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning, color: Colors.red.shade700, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'SIM expires soon! Smart reminder will notify you.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, String dateType) async {
    DateTime initialDate;
    DateTime firstDate;
    DateTime lastDate;

    switch (dateType) {
      case 'birth':
        initialDate = _birthDate ?? DateTime(1990);
        firstDate = DateTime(1900);
        lastDate = DateTime.now();
        break;
      case 'issued':
        initialDate = _issuedDate ?? DateTime.now().subtract(const Duration(days: 365 * 5));
        firstDate = DateTime(1990);
        lastDate = DateTime.now();
        break;
      case 'expiry':
        initialDate = _expiryDate ?? DateTime.now().add(const Duration(days: 365 * 5));
        firstDate = DateTime.now();
        lastDate = DateTime.now().add(const Duration(days: 365 * 20));
        break;
      default:
        return;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    
    if (picked != null) {
      setState(() {
        switch (dateType) {
          case 'birth':
            _birthDate = picked;
            break;
          case 'issued':
            _issuedDate = picked;
            break;
          case 'expiry':
            _expiryDate = picked;
            break;
        }
      });
      _updateMetadata();
    }
  }
}
