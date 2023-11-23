import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';
import 'query_provider.dart';

final userProvider = FutureProvider<UserModel>(
  (ref) async {
    try {
      final String usernameQuery = ref.watch(usernameQueryProvider)!;
      final path = '/users/$usernameQuery';
      final response = await http.get(
        Uri.https('api.github.com', path),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/vnd.github.v3+json',
        },
      );
      log('${response.statusCode}', name: 'userProvider:statusCode');
      if (response.statusCode == 200) {
        log('${jsonDecode(response.body)}', name: 'userProvider:body');
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
