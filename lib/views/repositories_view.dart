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
    return repositoriesAsyncValue.when(
      data: (List<RepositoryModel> repositories) {
        return PlatformScaffold(
          appBar: PlatformAppBar(
            title: PlatformText('Repositories'),
            trailingActions: [
              // sort button
              PlatformPopupMenu(
                options: <PopupMenuOption>[
                  PopupMenuOption(
                    label: 'Stars',
                  ),
                  PopupMenuOption(
                    label: 'Names',
                  ),
                  PopupMenuOption(
                    label: 'Description',
                  ),
                ],
                icon: Icon(
                  context.platformIcon(
                    material: Icons.more_vert_rounded,
                    cupertino: CupertinoIcons.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: repositories.length,
            itemBuilder: (context, index) {
              return PlatformListTile(
                title: PlatformText(repositories[index].name!),
                subtitle: repositories[index].description != null
                    ? PlatformText(repositories[index].description!)
                    : null,
                trailing: PlatformText(
                  repositories[index].stargazersCount.toString(),
                ),
              );
            },
          ),
        );
      },
      loading: () => Center(child: PlatformCircularProgressIndicator()),
      error: (err, stack) => Center(child: PlatformText('Error: $err')),
    );
  }
}
