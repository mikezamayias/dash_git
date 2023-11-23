import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../controllers/token_controller.dart';
import '../models/user_model.dart';

final searchQueryProvider = StateProvider<String?>((ref) => null);

final userProvider = FutureProvider.autoDispose.family<UserModel, String?>(
  (ref, username) async {
    try {
      final tokenModel = TokenController().tokenModel!;
      final path = username == null ? '/user' : '/users/$username';
      final response = await http.get(
        Uri.https('api.github.com', path),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/vnd.github.v3+json',
          'Authorization': 'Bearer ${tokenModel.accessToken}',
        },
      );
      log('${response.statusCode}', name: 'fetchUser:statusCode');
      if (response.statusCode == 200) {
        log('${jsonDecode(response.body)}', name: 'fetchUser:body');
        return UserModel.fromJson(jsonDecode(response.body));
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
        throw HttpException('Failed to fetch user profile',
            uri: Uri.https('api.github.com', path));
      }
    } on SocketException {
      throw Exception('No Internet connection.');
    }
  },
);
