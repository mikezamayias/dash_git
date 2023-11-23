import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/repository_model.dart';
import 'query_provider.dart';

final repositoriesProvider = StateNotifierProvider<RepositoriesNotifier,
    AsyncValue<List<RepositoryModel>>>((ref) {
  return RepositoriesNotifier(ref);
});

class RepositoriesNotifier
    extends StateNotifier<AsyncValue<List<RepositoryModel>>> {
  final Ref ref;

  RepositoriesNotifier(this.ref) : super(const AsyncValue.loading()) {
    _fetchRepositories();
  }

  Future<void> _fetchRepositories() async {
    final usernameQuery = ref.watch(usernameQueryProvider);
    try {
      final response = await http.get(
        Uri.https('api.github.com', '/users/$usernameQuery/repos'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/vnd.github.v3+json',
        },
      );
      if (response.statusCode == 200) {
        final data = (jsonDecode(response.body) as List)
            .map((json) => RepositoryModel.fromJson(json))
            .toList();
        state = AsyncValue.data(data);
      } else if (response.statusCode == 404) {
        throw Exception('User not found.');
      }
    } on SocketException {
      state = AsyncValue.error('No Internet connection.', StackTrace.current);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  void sortByStars() {
    state = state.whenData((repositories) => [...repositories]..sort(
        (a, b) => (b.stargazersCount ?? 0).compareTo(a.stargazersCount ?? 0)));
  }

  void sortByName() {
    state = state.whenData((repositories) => [...repositories]
      ..sort((a, b) => (a.name ?? '').compareTo(b.name ?? '')));
  }
}
