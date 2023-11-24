import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/sort_order.dart';
import '../models/repository_model.dart';
import '../services/git_hub_api_service.dart';
import 'query_provider.dart';

final repositoriesFutureProvider = FutureProvider<List<RepositoryModel>>(
  (ref) async {
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
  },
);

final repositoryModelListProvider = StateProvider<List<RepositoryModel>>(
  (ref) {
    final List<RepositoryModel> repositoryModels =
        ref.watch(repositoriesFutureProvider).asData?.value ?? [];
    final sortType = ref.watch(sortOrderProvider);

    List<RepositoryModel> sortedRepositoryModels = List.from(repositoryModels);
    switch (sortType) {
      case SortOrder.ascending:
        sortedRepositoryModels
            .sort((a, b) => a.stargazersCount!.compareTo(b.stargazersCount!));
        break;
      case SortOrder.descending:
        sortedRepositoryModels
            .sort((a, b) => b.stargazersCount!.compareTo(a.stargazersCount!));
        break;
      case SortOrder.unsorted:
        // No sorting needed
        break;
    }
    return sortedRepositoryModels;
  },
);
