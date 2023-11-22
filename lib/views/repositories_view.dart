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
                    onTap: (PopupMenuOption option) {
                      repositories.sort(
                        (a, b) => (b.stargazersCount ?? 0)
                            .compareTo(a.stargazersCount ?? 0),
                      );
                    },
                  ),
                  PopupMenuOption(
                    label: 'Names',
                    onTap: (PopupMenuOption option) {
                      repositories.sort(
                        (a, b) => (a.name ?? '').compareTo(b.name ?? ''),
                      );
                    },
                  ),
                  PopupMenuOption(
                    label: 'Description',
                    onTap: (PopupMenuOption option) {
                      repositories.sort(
                        (a, b) => (a.description ?? '')
                            .compareTo(b.description ?? ''),
                      );
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
            ],
          ),
          body: SafeArea(
            child: ListView.builder(
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
          ),
        );
      },
      loading: () => Center(child: PlatformCircularProgressIndicator()),
      error: (err, stack) => Center(child: PlatformText('Error: $err')),
    );
  }
}
