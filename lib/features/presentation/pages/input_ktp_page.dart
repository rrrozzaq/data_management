import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '../providers/ktp_provider.dart';
import '../providers/kk_provider.dart';

class InputKTPPage extends StatefulWidget {
  const InputKTPPage({super.key});

  @override
  _InputKTPPageState createState() => _InputKTPPageState();
}

class _InputKTPPageState extends State<InputKTPPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  String? selectedKKId; // To store the selected KK ID
  bool isLoadingKKs = true; // Loading state for KK dropdown

  @override
  void initState() {
    super.initState();
    fetchKKList();
  }

  Future<void> fetchKKList() async {
    final kkProvider = Provider.of<KKProvider>(context, listen: false);
    await kkProvider.fetchKK(); // Fetch KK list from API
    setState(() {
      isLoadingKKs = false; // Stop showing the loading spinner
    });
  }

  @override
  Widget build(BuildContext context) {
    final ktpProvider = Provider.of<KTPProvider>(context);
    final kkProvider = Provider.of<KKProvider>(context); // Fetch the KKProvider

    // Define dropdown options from dropdowns.php
    const List<String> agamaOptions = [
      'Islam',
      'Kristen Protestan',
      'Katolik',
      'Hindu',
      'Buddha',
      'Konghucu',
    ];

    const List<String> pendidikanOptions = [
      'Tidak/Belum Sekolah',
      'Belum Tamat SD/Sederajat',
      'Tamat SD/Sederajat',
      'SLTP/Sederajat',
      'SLTA/Sederajat',
      'Diploma I/II',
      'Akademi/Diploma III',
      'Diploma IV/Strata I (S1)',
      'Strata II (S2)',
      'Strata III (S3)',
      'Paket A (setara SD)',
      'Paket B (setara SMP)',
      'Paket C (setara SMA)',
    ];

    const List<String> pekerjaanOptions = [
      'Belum/Tidak Bekerja',
      'Mengurus Rumah Tangga',
      'Pelajar/Mahasiswa',
      'Pensiunan',
      'PNS (Pegawai Negeri Sipil)',
      'TNI (Tentara Nasional Indonesia)',
      'POLRI (Kepolisian Republik Indonesia)',
      'Karyawan Swasta',
      'Wiraswasta',
      'Buruh Harian Lepas',
      'Petani',
      'Nelayan',
      'Pedagang',
      'Supir',
      'Guru/Dosen',
      'Dokter/Perawat/Bidan',
      'Pengacara/Notaris',
      'Pegawai BUMN/BUMD',
      'Tentara Veteran',
      'Artis/Pekerja Seni',
      'Sopir Angkutan Umum',
      'Peternak',
      'Penambang',
      'Karyawan Honorer',
    ];

    const List<String> statusPerkawinanOptions = [
      'Belum Kawin',
      'Kawin',
      'Cerai Hidup',
      'Cerai Mati',
    ];

    const List<String> statusHubunganKeluargaOptions = [
      'Kepala Keluarga',
      'Suami',
      'Istri',
      'Anak',
      'Menantu',
      'Cucu',
      'Orang Tua',
      'Mertua',
      'Famili Lain',
      'Pembantu',
    ];

    const List<String> kewarganegaraanOptions = [
      'WNI (Warga Negara Indonesia)',
      'WNA (Warga Negara Asing)',
      'Dwi Kewarganegaraan (untuk anak dari perkawinan campuran)',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Input Data KTP")),
      body: isLoadingKKs
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show loading while fetching KK list
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Dropdown to select KK
                      FormBuilderDropdown<String>(
                        name: 'kk_id',
                        decoration:
                            const InputDecoration(labelText: 'Kartu Keluarga'),
                        items: kkProvider.kkList
                            .map((kk) => DropdownMenuItem(
                                  value: kk['id'].toString(),
                                  child: Text(
                                      '${kk['nomor_kk']} - ${kk['nama_kepala_keluarga']}'),
                                ))
                            .toList(),
                        validator: FormBuilderValidators.required(),
                        onChanged: (value) {
                          setState(() {
                            selectedKKId = value;
                          });
                        },
                      ),
                      // Form fields for KTP input (e.g., NIK, Nama, Tempat Lahir, etc.)
                      FormBuilderTextField(
                        name: 'nik',
                        decoration: const InputDecoration(
                            labelText: 'Nomor Induk Kependudukan (NIK)'),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(
                              errorText: 'Isi dengan format yang benar'),
                        ]),
                        keyboardType: TextInputType.number, // Numbers only
                      ),
                      FormBuilderTextField(
                        name: 'nama',
                        decoration: const InputDecoration(labelText: 'Nama'),
                        validator: FormBuilderValidators.required(),
                      ),
                      FormBuilderTextField(
                        name: 'tempat_lahir',
                        decoration:
                            const InputDecoration(labelText: 'Tempat Lahir'),
                        validator: FormBuilderValidators.required(),
                      ),
                      // Tanggal Lahir
                      FormBuilderDateTimePicker(
                        name: 'tanggal_lahir',
                        inputType: InputType.date,
                        decoration:
                            const InputDecoration(labelText: 'Tanggal Lahir'),
                        validator: FormBuilderValidators.required(),
                      ),
                      // Jenis Kelamin
                      FormBuilderDropdown(
                        name: 'jenis_kelamin',
                        decoration:
                            const InputDecoration(labelText: 'Jenis Kelamin'),
                        items: const [
                          DropdownMenuItem(
                              value: 'Laki-Laki', child: Text('Laki-Laki')),
                          DropdownMenuItem(
                              value: 'Perempuan', child: Text('Perempuan')),
                        ],
                        validator: FormBuilderValidators.required(),
                      ),
                      // Alamat
                      FormBuilderTextField(
                        name: 'alamat',
                        decoration: const InputDecoration(labelText: 'Alamat'),
                        validator: FormBuilderValidators.required(),
                      ),
                      // Agama
                      FormBuilderDropdown(
                        name: 'agama',
                        decoration: const InputDecoration(labelText: 'Agama'),
                        items: agamaOptions
                            .map((agama) => DropdownMenuItem(
                                  value: agama,
                                  child: Text(agama),
                                ))
                            .toList(),
                        validator: FormBuilderValidators.required(),
                      ),
                      // Pendidikan (Opsional)
                      FormBuilderDropdown(
                        name: 'pendidikan',
                        decoration:
                            const InputDecoration(labelText: 'Pendidikan'),
                        items: pendidikanOptions
                            .map((pendidikan) => DropdownMenuItem(
                                  value: pendidikan,
                                  child: Text(pendidikan),
                                ))
                            .toList(),
                      ),
                      // Pekerjaan
                      FormBuilderDropdown(
                        name: 'pekerjaan',
                        decoration:
                            const InputDecoration(labelText: 'Pekerjaan'),
                        items: pekerjaanOptions
                            .map((pekerjaan) => DropdownMenuItem(
                                  value: pekerjaan,
                                  child: Text(pekerjaan),
                                ))
                            .toList(),
                        validator: FormBuilderValidators.required(),
                      ),
                      // Status Perkawinan
                      FormBuilderDropdown(
                        name: 'status_perkawinan',
                        decoration: const InputDecoration(
                            labelText: 'Status Perkawinan'),
                        items: statusPerkawinanOptions
                            .map((status) => DropdownMenuItem(
                                  value: status,
                                  child: Text(status),
                                ))
                            .toList(),
                        validator: FormBuilderValidators.required(),
                      ),
                      // Kewarganegaraan
                      FormBuilderDropdown(
                        name: 'kewarganegaraan',
                        decoration:
                            const InputDecoration(labelText: 'Kewarganegaraan'),
                        items: kewarganegaraanOptions
                            .map((kewarganegaraan) => DropdownMenuItem(
                                  value: kewarganegaraan,
                                  child: Text(kewarganegaraan),
                                ))
                            .toList(),
                        validator: FormBuilderValidators.required(),
                      ),
                      // Status Hubungan Dalam Keluarga
                      FormBuilderDropdown(
                        name: 'status_hubungan_keluarga',
                        decoration: const InputDecoration(
                            labelText: 'Status Hubungan Dalam Keluarga'),
                        items: statusHubunganKeluargaOptions
                            .map((status) => DropdownMenuItem(
                                  value: status,
                                  child: Text(status),
                                ))
                            .toList(),
                        validator: FormBuilderValidators.required(),
                      ),
                      // Masa Berlaku
                      FormBuilderDateTimePicker(
                        name: 'masa_berlaku',
                        inputType: InputType.date,
                        decoration:
                            const InputDecoration(labelText: 'Masa Berlaku'),
                        validator: FormBuilderValidators.required(),
                      ),
                      // Dokumen Imigrasi (Opsional)
                      FormBuilderTextField(
                        name: 'dokumen_imigrasi',
                        decoration: const InputDecoration(
                            labelText: 'Dokumen Imigrasi (Opsional)'),
                      ),
                      // No. Paspor (Opsional)
                      FormBuilderTextField(
                        name: 'no_paspor',
                        decoration: const InputDecoration(
                            labelText: 'No. Paspor (Opsional)'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            return FormBuilderValidators.numeric(
                                errorText:
                                    'Isi dengan format yang benar')(value);
                          }
                          return null; // Allow empty for optional fields
                        },
                      ),
                      // No. KITAP (Opsional)
                      FormBuilderTextField(
                        name: 'no_kitap',
                        decoration: const InputDecoration(
                            labelText: 'No. KITAP (Opsional)'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            return FormBuilderValidators.numeric(
                                errorText:
                                    'Isi dengan format yang benar')(value);
                          }
                          return null; // Allow empty for optional fields
                        },
                      ),
                      // Nama Ayah
                      FormBuilderTextField(
                        name: 'nama_ayah',
                        decoration:
                            const InputDecoration(labelText: 'Nama Ayah'),
                        validator: FormBuilderValidators.required(),
                      ),
                      // Nama Ibu
                      FormBuilderTextField(
                        name: 'nama_ibu',
                        decoration:
                            const InputDecoration(labelText: 'Nama Ibu'),
                        validator: FormBuilderValidators.required(),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.saveAndValidate()) {
                            // Copy the form data to a new modifiable map
                            var formValues = Map<String, dynamic>.from(
                                _formKey.currentState!.value);
                            formValues['kk_id'] =
                                selectedKKId; // Use selected KK ID

                            // Convert Map<String, dynamic> to Map<String, String>
                            Map<String, String> stringKtpData = formValues.map(
                                (key, value) =>
                                    MapEntry(key, value.toString()));

                            try {
                              final response =
                                  await ktpProvider.createKTP(stringKtpData);
                              final message = response['message'];
                              final createdKTP = response['data'];

                              // Show success message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(message)),
                              );
                              // Navigate back after success
                              Navigator.pop(context, createdKTP);
                            } catch (e) {
                              // Show error message if creation fails
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Failed to create KTP')),
                              );
                            }
                          }
                        },
                        child: const Text('Simpan'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
