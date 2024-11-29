import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl;  // Base URL of your backend

  ApiService({required this.baseUrl});

  Future<http.Response> getData(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
      return response;
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<http.Response> postData(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }
}
