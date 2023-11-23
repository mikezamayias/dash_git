import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/repositories_provider.dart';

class RepositoriesView extends ConsumerWidget {
  const RepositoriesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositoriesAsyncValue = ref.watch(repositoriesProvider(null));
    final repositoryModels = ref.watch(sortedRepositoriesProvider);

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText('Repositories'),
        trailingActions: [
          AnimatedOpacity(
            opacity: repositoryModels.isEmpty ? 0 : 1,
            duration: const Duration(milliseconds: 300),
            child: PlatformPopupMenu(
              options: <PopupMenuOption>[
                PopupMenuOption(
                  label: 'Stars',
                  onTap: (_) => ref
                      .read(sortedRepositoriesProvider.notifier)
                      .sortByStars(),
                ),
                PopupMenuOption(
                  label: 'Names',
                  onTap: (_) => ref
                      .read(sortedRepositoriesProvider.notifier)
                      .sortByName(),
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
          ),
        ],
      ),
      body: SafeArea(
        child: repositoriesAsyncValue.when(
          loading: () => Center(child: PlatformCircularProgressIndicator()),
          error: (error, _) => Center(child: PlatformText('Error: $error')),
          data: (data) {
            // Check if repository list is empty
            if (repositoryModels.isEmpty) {
              return Center(child: PlatformText('No repositories found.'));
            }

            // Display list of repositories
            return ListView.builder(
              itemCount: repositoryModels.length,
              itemBuilder: (context, index) {
                final repo = repositoryModels[index];
                return PlatformListTile(
                  title: PlatformText(repo.name ?? ''),
                  subtitle: repo.description != null
                      ? PlatformText(repo.description!)
                      : null,
                  trailing: PlatformText(repo.stargazersCount.toString()),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
