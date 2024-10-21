import 'package:flutter/material.dart';
import 'package:data_management/features/data/datasources/api_service.dart';
import 'package:logger/logger.dart';

class KKProvider with ChangeNotifier {
  bool isLoading = true;
  List<dynamic> kkList = [];
  final logger = Logger();  // Initialize the logger

  KKProvider() {
    fetchKK();  // Fetch KK data on initialization
  }

  Future<void> fetchKK() async {
    try {
      // Fetch KK data from the API service
      kkList = await ApiService().fetchKK();
      logger.i('KK Data: $kkList');  // Log the retrieved KK data
    } catch (e) {
      logger.e('Error fetching KK: $e');  // Log errors
    } finally {
      isLoading = false;
      notifyListeners();  // Notify listeners to update UI
    }
  }
}