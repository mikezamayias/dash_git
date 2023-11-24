import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../services/git_hub_api_service.dart';
import 'query_provider.dart';

final userProvider = FutureProvider<UserModel>((ref) async {
  final GitHubApiService gitHubApiService = GitHubApiService();
  final String usernameQuery = ref.watch(usernameQueryProvider)!;
  final path = '/users/$usernameQuery';
  try {
    final responseData = await gitHubApiService.get(path);
    return UserModel.fromJson(responseData);
  } on SocketException {
    throw Exception('No Internet connection.');
  }
});
