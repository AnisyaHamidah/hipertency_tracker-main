// lib/screens/therapy_form_screen.dart
import 'package:flutter/material.dart';
import 'material_screen.dart';

class TherapyFormScreen extends StatefulWidget {
  final String therapyTitle;
  final String therapyDescription;
  final String sectionTitle;

  const TherapyFormScreen({
    super.key,
    required this.therapyTitle,
    required this.therapyDescription,
    required this.sectionTitle,
  });

  @override
  State<TherapyFormScreen> createState() => _TherapyFormScreenState();
}

class _TherapyFormScreenState extends State<TherapyFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _birthPlaceController; // ✅ baru (Tempat Lahir)
  late TextEditingController _birthDateController;
  late TextEditingController _bpSystolicController;
  late TextEditingController _bpDiastolicController;
  late TextEditingController _healthHistoryController;

  String? _selectedSmokingHistory;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _birthPlaceController = TextEditingController(); // ✅ init
    _birthDateController = TextEditingController();
    _bpSystolicController = TextEditingController();
    _bpDiastolicController = TextEditingController();
    _healthHistoryController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthPlaceController.dispose(); // ✅ dispose
    _birthDateController.dispose();
    _bpSystolicController.dispose();
    _bpDiastolicController.dispose();
    _healthHistoryController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MaterialScreen(
            therapyTitle: widget.therapyTitle,
            therapyDescription: widget.therapyDescription,
            patientName: _nameController.text,
            patientBirthDate: _birthDateController.text,
            bpSystolic: _bpSystolicController.text,
            bpDiastolic: _bpDiastolicController.text,
            notes: _healthHistoryController.text,
            // Kalau mau tempat lahir ikut ditampilkan di screen berikutnya,
            // kamu perlu tambah parameter di MaterialScreen juga.
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        // ✅ "nama atasnya" dibenerin: Title + Subtitle (sectionTitle)
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.therapyTitle,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              widget.sectionTitle,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Data Diri',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                // ✅ Nama + Tempat Lahir jadi kolom rapi (responsive)
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 600;

                    if (isWide) {
                      return Row(
                        children: [
                          Expanded(
                            child: _buildModernTextField(
                              controller: _nameController,
                              label: 'Nama Lengkap',
                              icon: Icons.person_outline,
                              textCapitalization: TextCapitalization.words,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nama tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: _buildModernTextField(
                              controller: _birthPlaceController,
                              label: 'Tempat Lahir',
                              icon: Icons.location_on_outlined,
                              textCapitalization: TextCapitalization.words,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tempat lahir wajib diisi';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    // mobile / sempit: jadi stack (1 kolom)
                    return Column(
                      children: [
                        _buildModernTextField(
                          controller: _nameController,
                          label: 'Nama Lengkap',
                          icon: Icons.person_outline,
                          textCapitalization: TextCapitalization.words,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        _buildModernTextField(
                          controller: _birthPlaceController,
                          label: 'Tempat Lahir',
                          icon: Icons.location_on_outlined,
                          textCapitalization: TextCapitalization.words,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tempat lahir wajib diisi';
                            }
                            return null;
                          },
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 15),

                // ✅ Tanggal lahir tetap datepicker (full width)
                _buildDateField(
                  controller: _birthDateController,
                  label: 'Tanggal Lahir',
                  icon: Icons.date_range,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tanggal lahir wajib diisi';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 25),
                const Text(
                  'Tekanan Darah',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildBPTextField(
                          controller: _bpSystolicController,
                          label: 'Sistol',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Wajib diisi';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Harus angka';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          '/',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _buildBPTextField(
                          controller: _bpDiastolicController,
                          label: 'Diastol',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Wajib diisi';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Harus angka';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),
                const Text(
                  'Informasi Tambahan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 15),
                _buildModernTextField(
                  controller: _healthHistoryController,
                  label: 'Riwayat Kesehatan (Opsional)',
                  icon: Icons.medical_services_outlined,
                  maxLines: 3,
                  validator: null,
                ),
                const SizedBox(height: 15),
                _buildDropdown(
                  value: _selectedSmokingHistory,
                  label: 'Riwayat Merokok',
                  icon: Icons.smoking_rooms_outlined,
                  items: const [
                    'Tidak Pernah',
                    'Mantan Perokok',
                    'Perokok Aktif',
                  ],
                  onChanged: (value) {
                    setState(() => _selectedSmokingHistory = value);
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Pilih riwayat merokok';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade600, Colors.blue.shade400],
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade300.withOpacity(0.5),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Lanjutkan ke Materi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none, // ✅ baru
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue.shade600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          isDense: true, // ✅ tinggi field lebih konsisten
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14, // ✅ lebih pas untuk 1 baris
          ),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue.shade600),
          suffixIcon: const Icon(Icons.calendar_today),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        validator: validator,
        onTap: () async {
          final now = DateTime.now();
          final initial = now.subtract(const Duration(days: 365 * 20));
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: initial,
            firstDate: DateTime(1900),
            lastDate: now,
          );
          if (picked != null) {
            final dd = picked.day.toString().padLeft(2, '0');
            final mm = picked.month.toString().padLeft(2, '0');
            final yyyy = picked.year.toString();
            controller.text = '$dd/$mm/$yyyy';
          }
        },
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String label,
    required IconData icon,
    required List<String> items,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue.shade600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  Widget _buildBPTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
      ),
      validator: validator,
    );
  }
}
