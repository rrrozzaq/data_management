import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/kk_detail_provider.dart';

class DetailKKPage extends StatefulWidget {
  final int kkId; // KK ID passed as a parameter

  const DetailKKPage({super.key, required this.kkId});

  @override
  _DetailKKPageState createState() => _DetailKKPageState();
}

class _DetailKKPageState extends State<DetailKKPage> {
  @override
  void initState() {
    super.initState();

    // Fetch the KK detail after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Call the provider's fetch method here
      Provider.of<KKDetailProvider>(context, listen: false)
          .fetchKKDetail(widget.kkId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final kkDetailProvider = Provider.of<KKDetailProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail KK'),
        backgroundColor: Colors.grey,
      ),
      body: kkDetailProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            ) // Show loading spinner while data is loading
          : kkDetailProvider.kkDetail == null
              ? const Center(
                  child: Text("Data KK tidak ditemukan"),
                ) // Show error if data is null
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // KK Details Section
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Nomor KK: ${kkDetailProvider.kkDetail!['nomor_kk'] ?? 'Tidak tersedia'}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center, // Center the text
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Nama Kepala Keluarga: ${kkDetailProvider.kkDetail!['nama_kepala_keluarga'] ?? 'Tidak tersedia'}',
                                textAlign: TextAlign.center, // Center the text
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // KTP List Section (Scrollable)
                      Expanded(
                        child: ListView.builder(
                          itemCount: kkDetailProvider.kkDetail!['ktps'].length,
                          itemBuilder: (context, index) {
                            var ktp = kkDetailProvider.kkDetail!['ktps'][index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ktp['nama'] ?? 'Nama tidak tersedia',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                        'NIK: ${ktp['nik'] ?? 'Tidak tersedia'}'),
                                    Text(
                                        'Tempat Lahir: ${ktp['tempat_lahir'] ?? 'Tidak tersedia'}'),
                                    Text(
                                        'Tanggal Lahir: ${ktp['tanggal_lahir'] ?? 'Tidak tersedia'}'),
                                    Text(
                                        'Jenis Kelamin: ${ktp['jenis_kelamin'] ?? 'Tidak tersedia'}'),
                                    Text(
                                        'Alamat: ${ktp['alamat'] ?? 'Tidak tersedia'}'),
                                    Text(
                                        'Agama: ${ktp['agama'] ?? 'Tidak tersedia'}'),
                                    Text(
                                        'Status Perkawinan: ${ktp['status_perkawinan'] ?? 'Tidak tersedia'}'),
                                    Text(
                                        'Pekerjaan: ${ktp['pekerjaan'] ?? 'Tidak tersedia'}'),
                                    Text(
                                        'Kewarganegaraan: ${ktp['kewarganegaraan'] ?? 'Tidak tersedia'}'),
                                    Text(
                                        'No Paspor: ${ktp['no_paspor'] ?? 'Tidak tersedia'}'),
                                    Text(
                                        'No KITAP: ${ktp['no_kitap'] ?? 'Tidak tersedia'}'),
                                    Text(
                                        'Nama Ayah: ${ktp['nama_ayah'] ?? 'Tidak tersedia'}'),
                                    Text(
                                        'Nama Ibu: ${ktp['nama_ibu'] ?? 'Tidak tersedia'}'),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
