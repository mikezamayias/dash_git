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
      // Check for successful response
      if (response.statusCode == 200) {
        return UserProfileModel.fromJson(jsonDecode(response.body));
      } else {
        // Handle non-successful response
        throw Exception(
          'Request to GitHub API failed with status code: ${response.statusCode}. Response body: ${response.body}',
        );
      }
    } on SocketException {
      throw Exception('No Internet connection.');
    } on HttpException {
      throw Exception('Could not find the user. Check the username.');
    } on FormatException {
      throw Exception('Bad response format.');
    } catch (e) {
      // Handle any other type of error
      throw Exception('Failed to load user profile data. Error: $e');
    }
  }
}
