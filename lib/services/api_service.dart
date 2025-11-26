import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiService {
  final String baseUrl;
  final http.Client client;

  ApiService({
    this.baseUrl = ApiConstants.baseUrl,
    http.Client? client,
  }) : client = client ?? http.Client();

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    try {
      // Normalize URL - remove trailing slash from baseUrl and ensure endpoint starts with /
      final normalizedBaseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
      final normalizedEndpoint = endpoint.startsWith('/') ? endpoint : '/$endpoint';
      final url = Uri.parse('$normalizedBaseUrl$normalizedEndpoint');
      final requestHeaders = {
        'Content-Type': 'application/json',
        ...?headers,
      };
      final requestBody = jsonEncode(body);

      // Print request details
      print('═══════════════════════════════════════════════════════════');
      print('📤 API POST REQUEST');
      print('═══════════════════════════════════════════════════════════');
      print('URL: $url');
      print('Headers: $requestHeaders');
      print('Body: $requestBody');
      print('═══════════════════════════════════════════════════════════');

      final response = await client.post(
        url,
        headers: requestHeaders,
        body: requestBody,
      );

      // Print response details
      print('═══════════════════════════════════════════════════════════');
      print('📥 API POST RESPONSE');
      print('═══════════════════════════════════════════════════════════');
      print('Status Code: ${response.statusCode}');
      print('Headers: ${response.headers}');
      print('Body: ${response.body}');
      print('═══════════════════════════════════════════════════════════');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
        print('✅ Request successful');
        print('Decoded Response: $decodedResponse');
        print('═══════════════════════════════════════════════════════════');
        return decodedResponse;
      } else {
        print('❌ Request failed with status: ${response.statusCode}');
        print('Error Body: ${response.body}');
        print('═══════════════════════════════════════════════════════════');
        throw ApiException(
          'Request failed with status: ${response.statusCode}',
          response.statusCode,
        );
      }
    } catch (e) {
      print('═══════════════════════════════════════════════════════════');
      print('❌ API POST ERROR');
      print('═══════════════════════════════════════════════════════════');
      print('Error Type: ${e.runtimeType}');
      print('Error Message: ${e.toString()}');
      if (e is ApiException) {
        print('Status Code: ${e.statusCode}');
      }
      print('Stack Trace: ${StackTrace.current}');
      print('═══════════════════════════════════════════════════════════');
      
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException('Network error: ${e.toString()}', 0);
    }
  }

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    try {
      // Normalize URL - remove trailing slash from baseUrl and ensure endpoint starts with /
      final normalizedBaseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
      final normalizedEndpoint = endpoint.startsWith('/') ? endpoint : '/$endpoint';
      final url = Uri.parse('$normalizedBaseUrl$normalizedEndpoint');
      final requestHeaders = {
        'Content-Type': 'application/json',
        ...?headers,
      };

      // Print request details
      print('═══════════════════════════════════════════════════════════');
      print('📤 API GET REQUEST');
      print('═══════════════════════════════════════════════════════════');
      print('URL: $url');
      print('Headers: $requestHeaders');
      print('═══════════════════════════════════════════════════════════');

      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      // Print response details
      print('═══════════════════════════════════════════════════════════');
      print('📥 API GET RESPONSE');
      print('═══════════════════════════════════════════════════════════');
      print('Status Code: ${response.statusCode}');
      print('Headers: ${response.headers}');
      print('Body: ${response.body}');
      print('═══════════════════════════════════════════════════════════');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
        print('✅ Request successful');
        print('Decoded Response: $decodedResponse');
        print('═══════════════════════════════════════════════════════════');
        return decodedResponse;
      } else {
        print('❌ Request failed with status: ${response.statusCode}');
        print('Error Body: ${response.body}');
        print('═══════════════════════════════════════════════════════════');
        throw ApiException(
          'Request failed with status: ${response.statusCode}',
          response.statusCode,
        );
      }
    } catch (e) {
      print('═══════════════════════════════════════════════════════════');
      print('❌ API GET ERROR');
      print('═══════════════════════════════════════════════════════════');
      print('Error Type: ${e.runtimeType}');
      print('Error Message: ${e.toString()}');
      if (e is ApiException) {
        print('Status Code: ${e.statusCode}');
      }
      print('Stack Trace: ${StackTrace.current}');
      print('═══════════════════════════════════════════════════════════');
      
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException('Network error: ${e.toString()}', 0);
    }
  }
}

class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, this.statusCode);

  @override
  String toString() => message;
}


