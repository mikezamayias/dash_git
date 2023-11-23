import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/repositories_provider.dart';

class RepositoriesView extends ConsumerWidget {
  const RepositoriesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositoriesAsyncValue = ref.watch(repositoriesProvider);
    final repositoryModels = ref.watch(sortedRepositoriesProvider);

    return repositoriesAsyncValue.when(
      loading: () => Center(child: PlatformCircularProgressIndicator()),
      error: (error, _) => Center(child: PlatformText('Error: $error')),
      data: (data) {
        // Check if repository list is empty
        if (repositoryModels.isEmpty) {
          return Center(child: PlatformText('No repositories found.'));
        }

        final widgets = <Widget>[
          for (final repositoryModel in repositoryModels)
            PlatformListTile(
              title: PlatformText(repositoryModel.name ?? ''),
              subtitle: repositoryModel.description != null
                  ? PlatformText(repositoryModel.description!)
                  : null,
              trailing:
                  PlatformText(repositoryModel.stargazersCount.toString()),
            ),
        ];
        final header = PlatformListTile(
          title: Text('Number of repositories: ${repositoryModels.length}'),
          trailing: AnimatedOpacity(
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
        );
        // Display list of repositories
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: PlatformWidget(
            cupertino: (context, _) => CupertinoListSection.insetGrouped(
              topMargin: 0,
              hasLeading: false,
              header: header,
              children: widgets,
            ),
            material: (context, _) => Column(
              children: [
                header,
                Expanded(
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: widgets.length,
                    itemBuilder: (context, index) => widgets.elementAt(index),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
