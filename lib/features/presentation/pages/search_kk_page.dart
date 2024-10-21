import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/kk_provider.dart';
import 'package:logger/logger.dart';


class SearchKKPage extends StatefulWidget {
  final logger = Logger(); // Initialize the logger

  SearchKKPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchKKPageState createState() => _SearchKKPageState();
}

class _SearchKKPageState extends State<SearchKKPage> {
  final TextEditingController _searchController = TextEditingController();
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    final kkProvider = Provider.of<KKProvider>(context);

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        // Navigate back to the home page explicitly
        Navigator.pop(context);
        return false; // Prevent default back button behavior, we handle it manually
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Data KK"),
          backgroundColor: Colors.grey,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Manually navigate back to the home page
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Field
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cari Data KK',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        searchTerm = _searchController.text;
                        widget.logger.i('Searching for: $searchTerm');
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // KK Data List
              Expanded(
                child: kkProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : kkProvider.kkList.isEmpty
                        ? const Center(child: Text("Tidak ada data KK"))
                        : ListView.builder(
                            itemCount: kkProvider.kkList.length,
                            itemBuilder: (context, index) {
                              var kk = kkProvider.kkList[index];

                              // Search filter logic
                              if (searchTerm.isNotEmpty &&
                                  !(kk['nomor_kk']
                                          ?.toString()
                                          .contains(searchTerm) ??
                                      false)) {
                                return Container(); // Don't show items that don't match search term
                              }

                              // Logging instead of print
                              widget.logger.i("KK ID: ${kk['id']}");

                              return Card(
                                elevation: 2.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: ListTile(
                                    title: Text(kk['nomor_kk'] ??
                                        'Nomor KK tidak tersedia'),
                                    subtitle: Text(kk['nama_kepala_keluarga'] ??
                                        'Nama kepala keluarga tidak tersedia'),
                                    onTap: () {
                                      final kkId =
                                          kk['id']; // Extract the KK ID
                                      if (kkId != null) {
                                        Navigator.pushNamed(
                                          context,
                                          '/detail-kk',
                                          arguments:
                                              kkId, // Pass the KK ID to the detail page
                                        );
                                      } else {
                                        widget.logger.w("KK ID is null");
                                      }
                                    }),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
