import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/repository_model.dart';
import '../providers/repositories_provider.dart';

class RepositoriesView extends ConsumerWidget {
  const RepositoriesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositoriesAsyncValue = ref.watch(repositoriesProvider);
    List<Widget> buildTrailingActions(List<RepositoryModel> repositories) {
      if (repositories.isEmpty) return [];

      return [
        PlatformPopupMenu(
          options: <PopupMenuOption>[
            PopupMenuOption(
              label: 'Stars',
              // onTap: (_) => ref
              //     .read(sortedRepositoriesProvider.notifier)
              //     .sortByStars(),
            ),
            PopupMenuOption(
              label: 'Name',
              // onTap: (_) => ref
              //     .read(sortedRepositoriesProvider.notifier)
              //     .sortByName(),
            ),
            // Add other sorting options here
          ],
          icon: Icon(
            context.platformIcon(
              material: Icons.more_vert_rounded,
              cupertino: CupertinoIcons.ellipsis,
            ),
          ),
        ),
      ];
    }

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Repositories'),
        trailingActions: repositoriesAsyncValue.when(
          data: (repositories) => buildTrailingActions(repositories),
          loading: () => [],
          error: (_, __) => [],
        ),
      ),
      body: SafeArea(
        child: repositoriesAsyncValue.when(
          data: (repositoryModels) {
            return repositoryModels.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: repositoryModels.length,
                    itemBuilder: (context, index) {
                      final repo = repositoryModels.elementAt(index);
                      return PlatformListTile(
                        title: Text(repo.name ?? ''),
                        subtitle: repo.description != null
                            ? Text(repo.description!)
                            : null,
                        trailing: Text(
                          repo.stargazersCount.toString(),
                          style: platformThemeData(
                            context,
                            material: (data) => data.textTheme.bodyLarge,
                            cupertino: (data) => data.textTheme.textStyle,
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text('No repositories found.'),
                  );
          },
          loading: () => Center(child: PlatformCircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('$error')),
        ),
      ),
    );
  }
}
