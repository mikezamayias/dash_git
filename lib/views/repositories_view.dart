import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/repository_model.dart';
import '../providers/repositories_provider.dart';
import '../widgets/list_with_header.dart';

class RepositoriesView extends ConsumerWidget {
  const RepositoriesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositoriesAsyncValue = ref.watch(repositoriesProvider);

    return repositoriesAsyncValue.when(
      loading: () => Center(child: PlatformCircularProgressIndicator()),
      error: (error, _) => Center(child: Text('$error')),
      data: (List<RepositoryModel> repositoryModels) {
        // Check if repository list is empty
        if (repositoryModels.isEmpty) {
          return const Center(child: Text('No repositories found.'));
        }

        final widgets = <Widget>[
          for (final repositoryModel in repositoryModels)
            PlatformListTile(
              title: Text(
                '${repositoryModel.name}',
                style: platformThemeData(
                  context,
                  material: (data) => data.textTheme.bodyLarge,
                  cupertino: (data) => data.textTheme.textStyle,
                ),
              ),
              subtitle: Text(
                '${repositoryModel.description}',
                style: platformThemeData(
                  context,
                  material: (data) => data.textTheme.bodySmall,
                  cupertino: (data) => data.textTheme.textStyle,
                ),
              ),
              trailing: Text(
                '${repositoryModel.stargazersCount}',
                style: platformThemeData(
                  context,
                  material: (data) => data.textTheme.bodyLarge,
                  cupertino: (data) => data.textTheme.textStyle,
                ),
              ),
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
                  onTap: (_) {
                    ref.read(repositoriesProvider.notifier).sortByStars();
                  },
                ),
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
        return ListWithHeader(header: header, widgets: widgets);
      },
    );
  }
}
