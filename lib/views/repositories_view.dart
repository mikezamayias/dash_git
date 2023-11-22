import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/repositories_provider.dart';

class RepositoriesView extends ConsumerWidget {
  const RepositoriesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  label: 'Name',
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
        child: repositoryModels.isEmpty
            ? Center(child: PlatformCircularProgressIndicator())
            : ListView.builder(
                itemCount: repositoryModels.length,
                itemBuilder: (context, index) {
                  final repo = repositoryModels.elementAt(index);
                  return PlatformListTile(
                    title: PlatformText(repo.name ?? ''),
                    subtitle: repo.description != null
                        ? PlatformText(repo.description!)
                        : null,
                    trailing: PlatformText(repo.stargazersCount.toString()),
                  );
                },
              ),
      ),
    );
  }
}
