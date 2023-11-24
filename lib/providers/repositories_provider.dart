import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/repository_model.dart';
import '../services/git_hub_api_service.dart';
import 'query_provider.dart';

final repositoriesProvider = FutureProvider<List<RepositoryModel>>((ref) async {
  final GitHubApiService gitHubApiService = GitHubApiService();
  final String usernameQuery = ref.watch(usernameQueryProvider)!;
  final path = '/users/$usernameQuery/repos';
  try {
    final responseData = await gitHubApiService.get(path);
    log(responseData.toString(), name: 'repositoriesProvider');
    return (responseData as List)
        .map((json) => RepositoryModel.fromJson(json))
        .toList();
  } on SocketException {
    throw Exception('No Internet connection.');
  }
});
