import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/user_profile_model.dart';

class UserProfileController {
  //   singleton constructor
  UserProfileController._internal();

  static final UserProfileController _instance =
      UserProfileController._internal();

  factory UserProfileController() => _instance;

  // methods
  // get user profile data by calling https://api.github.com/users/mikezamayias
  Future<UserProfileModel> fetchUserProfile(String username) async {
    try {
      final response = await http.get(
        Uri.https('api.github.com', '/users/$username'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/vnd.github.v3+json',
        },
      );
      return switch (response.statusCode) {
        200 => // OK
          UserProfileModel.fromJson(jsonDecode(response.body)),
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
