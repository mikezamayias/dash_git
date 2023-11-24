import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/follower_model.dart';
import '../services/git_hub_api_service.dart';
import 'query_provider.dart';

final followersProvider = FutureProvider<List<FollowerModel>>((ref) async {
  final GitHubApiService gitHubApiService = GitHubApiService();
  final String usernameQuery = ref.watch(usernameQueryProvider)!;
  final path = '/users/$usernameQuery/followers';
  try {
    final responseData = await gitHubApiService.get(path);
    return (responseData as List)
        .map((json) => FollowerModel.fromJson(json))
        .toList();
  } on SocketException {
    throw Exception('No Internet connection.');
  }
});
