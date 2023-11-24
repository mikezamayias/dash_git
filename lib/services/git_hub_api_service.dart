import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class GitHubApiService {
  final String baseUrl = 'api.github.com';

  Future<dynamic> get(String path) async {
    final response = await http.get(
      Uri.https(baseUrl, path),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/vnd.github.v3+json',
      },
    );
    return _processResponse(response);
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 304:
        throw Exception('Data not modified since last request.');
      case 401:
        throw Exception('Authentication required. Please login.');
      case 403:
        throw Exception(
            'Access forbidden. You might not have the necessary permissions.');
      case 404:
        throw Exception('Resource not found.');
      default:
        throw HttpException('Failed to fetch data', uri: response.request?.url);
    }
  }
}
