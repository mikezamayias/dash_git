import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/repository_model.dart';

class RepositoryController {
  //   singleton constructor
  RepositoryController._internal();

  static final RepositoryController _instance =
      RepositoryController._internal();

  factory RepositoryController() => _instance;

  // methods
  // get user's repos by calling https://api.github.com/users/mikezamayias/repos
  Future<List<RepositoryModel>> fetchRepositories(String username) async {
    try {
      final response = await http.get(
        Uri.https('api.github.com', '/users/$username/repos'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/vnd.github.v3+json',
        },
      );
      return switch (response.statusCode) {
        200 => // OK
          (jsonDecode(response.body) as List<dynamic>)
              .map<RepositoryModel>((json) => RepositoryModel.fromJson(json))
              .toList(),
        304 => // Not modified
          throw Exception('Data not modified since last request.'),
        401 => // Requires authentication
          throw Exception('Authentication required. Please login.'),
        403 => // Forbidden
          throw Exception(
              'Access forbidden. You might not have the necessary permissions.'),
        404 => throw Exception('User @$username not found.'),
        _ => throw Exception(
            'Failed with status code: ${response.statusCode}. Response body: ${response.body}',
          )
      };
    } on SocketException {
      throw Exception('No Internet connection.');
    }
  }
}
