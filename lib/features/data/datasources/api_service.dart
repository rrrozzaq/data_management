import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';



class ApiService {
  final String baseUrl = "https://glacial-castle-88939-9977ca20e3f7.herokuapp.com/api";  // Replace with your API base URL
  final logger = Logger();  // Initialize the logger
  
  // Fetching KK data from API
  Future<List> fetchKK() async {
    final response = await http.get(Uri.parse("$baseUrl/kk"));

    if (response.statusCode == 200) {
      // Parse the response body and extract the data field
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == 'success') {
        return jsonResponse['data'];  // Return the list of KK records
      } else {
        throw Exception('Failed to retrieve KK data');
      }
    } else {
      throw Exception('Failed to load KK');
    }
  }

  // Fetch KK detail by ID
  Future<Map<String, dynamic>> fetchKKDetail(int id) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/kk/$id"));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'success') {
          return jsonResponse['data'];  // Return the KK detail
        } else {
          logger.e("Error fetching KK detail: ${jsonResponse['message']}");
          throw Exception('Failed to retrieve KK detail');
        }
      } else {
        logger.e("Error fetching KK detail: Status code ${response.statusCode}");
        throw Exception('Failed to load KK detail');
      }
    } catch (e) {
      logger.e("Failed to fetch KK detail: $e");
      rethrow;
    }
  }

  // Creating KTP
  Future<Map<String, dynamic>> createKTP(Map<String, String> ktpData) async {
    final response = await http.post(
      Uri.parse("$baseUrl/ktp"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(ktpData),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);  // Return the response body decoded as a Map
    } else {
      throw Exception('Failed to create KTP');
    }
  }
}