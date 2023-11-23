import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/repository_model.dart';
import 'query_provider.dart';

final sortedRepositoriesProvider =
    StateNotifierProvider<SortedRepositoriesNotifier, List<RepositoryModel>>(
        (ref) {
  final repositories = ref.watch(repositoriesProvider).value ?? [];
  return SortedRepositoriesNotifier(repositories);
});

class SortedRepositoriesNotifier extends StateNotifier<List<RepositoryModel>> {
  SortedRepositoriesNotifier(super.initialRepositories);

  void sortByStars() {
    state = [...state]..sort(
        (a, b) => (b.stargazersCount ?? 0).compareTo(a.stargazersCount ?? 0));
  }

  void sortByName() {
    state = [...state]..sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));
  }
}

final repositoriesProvider = FutureProvider<List<RepositoryModel>>(
  (ref) async {
    try {
      final String usernameQuery =
          ref.watch(usernameQueryProvider) ?? 'mikezamayias';
      final path = '/users/$usernameQuery/repos';
      final response = await http.get(
        Uri.https('api.github.com', path),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/vnd.github.v3+json',
        },
      );
      log('${response.statusCode}', name: 'repositoriesProvider:statusCode');
      if (response.statusCode == 200) {
        log('${jsonDecode(response.body)}', name: 'repositoriesProvider:body');
        return (jsonDecode(response.body) as List)
            .map((json) => RepositoryModel.fromJson(json))
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
