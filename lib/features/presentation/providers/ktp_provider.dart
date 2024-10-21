import 'package:flutter/material.dart';
import 'package:data_management/features/data/datasources/api_service.dart';
import 'package:logger/logger.dart';

class KTPProvider extends ChangeNotifier {
  final logger = Logger();  // Initialize the logger

  Future<Map<String, dynamic>> createKTP(Map<String, String> ktpData) async {
    try {
      logger.i("Creating KTP with data: $ktpData");  // Log before sending the request
      final response = await ApiService().createKTP(ktpData);
      logger.i("KTP created successfully with response: $response");  // Log the response
      return response;  // Return the API response
    } catch (e) {
      logger.e("Failed to create KTP: $e");  // Log the error
      throw Exception('Failed to create KTP');
    }
  }
}
