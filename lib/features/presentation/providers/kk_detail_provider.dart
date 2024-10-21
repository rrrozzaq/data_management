import 'package:flutter/material.dart';
import 'package:data_management/features/data/datasources/api_service.dart';
import 'package:logger/logger.dart';

class KKDetailProvider with ChangeNotifier {
  bool isLoading = false;  // Loading state to manage UI
  Map<String, dynamic>? kkDetail;  // To store KK detail
  final logger = Logger();  // Initialize the logger

  // Method to fetch KK Detail by ID
  Future<void> fetchKKDetail(int id) async {
    try {
      isLoading = true;  // Set loading to true
      notifyListeners();  // Notify listeners about state change

      // Fetching KK details from API service
      final fetchedKKDetail = await ApiService().fetchKKDetail(id);

      if (fetchedKKDetail.isNotEmpty) {
        kkDetail = fetchedKKDetail;  // Store fetched KK detail
        logger.i('Successfully fetched KK Detail: $kkDetail');
      } else {
        // If the response is empty, log a warning and set detail to null
        logger.w('No KK detail found for ID: $id');
        kkDetail = null;
      }

    } catch (error) {
      // Handle errors and log them
      logger.e('Error occurred while fetching KK detail: $error');
      kkDetail = null;
    } finally {
      // Ensure the loading state is set to false after data fetch
      isLoading = false;
      notifyListeners();  // Notify listeners to update the UI
    }
  }
}