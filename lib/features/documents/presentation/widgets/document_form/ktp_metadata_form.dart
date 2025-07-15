import 'package:flutter/material.dart';

class KTPMetadataForm extends StatelessWidget {
  final TextEditingController nikController;
  final TextEditingController fullNameController;
  final TextEditingController birthPlaceController;
  final DateTime? birthDate;
  final String selectedGender;
  final String selectedBloodType;
  final TextEditingController addressController;
  final TextEditingController rtController;
  final TextEditingController rwController;
  final TextEditingController kelurahanController;
  final TextEditingController kecamatanController;
  final TextEditingController religionController;
  final TextEditingController maritalStatusController;
  final TextEditingController occupationController;
  final TextEditingController citizenshipController;
  final DateTime? issuedDate;
  final TextEditingController issuedByController;
  final ValueChanged<DateTime?> onBirthDateChanged;
  final ValueChanged<String> onGenderChanged;
  final ValueChanged<String> onBloodTypeChanged;
  final ValueChanged<DateTime?> onIssuedDateChanged;

  const KTPMetadataForm({
    super.key,
    required this.nikController,
    required this.fullNameController,
    required this.birthPlaceController,
    required this.birthDate,
    required this.selectedGender,
    required this.selectedBloodType,
    required this.addressController,
    required this.rtController,
    required this.rwController,
    required this.kelurahanController,
    required this.kecamatanController,
    required this.religionController,
    required this.maritalStatusController,
    required this.occupationController,
    required this.citizenshipController,
    required this.issuedDate,
    required this.issuedByController,
    required this.onBirthDateChanged,
    required this.onGenderChanged,
    required this.onBloodTypeChanged,
    required this.onIssuedDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Data KTP',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: nikController,
          decoration: const InputDecoration(
            labelText: 'NIK',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'NIK tidak boleh kosong';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: fullNameController,
          decoration: const InputDecoration(
            labelText: 'Nama Lengkap',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Nama tidak boleh kosong';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: birthPlaceController,
                decoration: const InputDecoration(
                  labelText: 'Tempat Lahir',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tempat lahir tidak boleh kosong';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: birthDate ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  onBirthDateChanged(date);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Lahir',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    birthDate != null
                        ? '${birthDate!.day}/${birthDate!.month}/${birthDate!.year}'
                        : 'Pilih Tanggal',
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: const InputDecoration(
                  labelText: 'Jenis Kelamin',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'L', child: Text('Laki-laki')),
                  DropdownMenuItem(value: 'P', child: Text('Perempuan')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    onGenderChanged(value);
                  }
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: selectedBloodType,
                decoration: const InputDecoration(
                  labelText: 'Golongan Darah',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'A', child: Text('A')),
                  DropdownMenuItem(value: 'B', child: Text('B')),
                  DropdownMenuItem(value: 'AB', child: Text('AB')),
                  DropdownMenuItem(value: 'O', child: Text('O')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    onBloodTypeChanged(value);
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: addressController,
          decoration: const InputDecoration(
            labelText: 'Alamat',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Alamat tidak boleh kosong';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: rtController,
                decoration: const InputDecoration(
                  labelText: 'RT',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: rwController,
                decoration: const InputDecoration(
                  labelText: 'RW',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: kelurahanController,
                decoration: const InputDecoration(
                  labelText: 'Kelurahan',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: kecamatanController,
                decoration: const InputDecoration(
                  labelText: 'Kecamatan',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: religionController,
          decoration: const InputDecoration(
            labelText: 'Agama',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: maritalStatusController,
          decoration: const InputDecoration(
            labelText: 'Status Perkawinan',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: occupationController,
          decoration: const InputDecoration(
            labelText: 'Pekerjaan',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: citizenshipController,
          decoration: const InputDecoration(
            labelText: 'Kewarganegaraan',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: issuedDate ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  onIssuedDateChanged(date);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Penerbitan',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    issuedDate != null
                        ? '${issuedDate!.day}/${issuedDate!.month}/${issuedDate!.year}'
                        : 'Pilih Tanggal',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: issuedByController,
                decoration: const InputDecoration(
                  labelText: 'Diterbitkan oleh',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
} 