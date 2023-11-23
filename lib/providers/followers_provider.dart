import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/follower_model.dart';
import 'query_provider.dart';

final followersProvider = FutureProvider<List<FollowerModel>>(
  (ref) async {
    try {
      final String usernameQuery =
          ref.watch(usernameQueryProvider) ?? 'mikezamayias';
      final path = '/users/$usernameQuery/followers';
      final response = await http.get(
        Uri.https('api.github.com', path),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/vnd.github.v3+json',
        },
      );
      log('${response.statusCode}', name: 'followersProvider:statusCode');
      if (response.statusCode == 200) {
        log('${jsonDecode(response.body)}', name: 'followersProvider:body');
        return (jsonDecode(response.body) as List)
            .map((json) => FollowerModel.fromJson(json))
            .toList();
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
          uri: Uri.https('api.github.com', path),
        );
      }
    } on SocketException {
      throw Exception('No Internet connection.');
    }
  },
);
