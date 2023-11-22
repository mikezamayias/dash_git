import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/user_profile_model.dart';
import '../controllers/token_controller.dart';

final userProfileProvider = FutureProvider<UserProfileModel>(
  (ref) async {
    try {
      final tokenModel = TokenController().tokenModel!;
      final response = await http.get(
        Uri.https('api.github.com', '/user'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/vnd.github.v3+json',
          'Authorization': 'Bearer ${tokenModel.accessToken}',
        },
      );
      if (response.statusCode == 200) {
        return UserProfileModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 304) {
        throw Exception('Data not modified since last request.');
      } else if (response.statusCode == 401) {
        throw Exception('Authentication required. Please login.');
      } else if (response.statusCode == 403) {
        throw Exception(
            'Access forbidden. You might not have the necessary permissions.');
      } else if (response.statusCode == 404) {
        throw Exception('User not found.');
      } else {
        throw HttpException(
          'Failed to fetch user profile',
          uri: Uri.https('api.github.com', '/user'),
        );
      }
    } on SocketException {
      throw Exception('No Internet connection.');
    }
  },
);
