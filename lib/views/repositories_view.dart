import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/sort_order.dart';
import '../providers/repositories_provider.dart';
import '../widgets/list_with_title_and_subtitle.dart';
import '../wrappers/future_provider_wrapper.dart';

class RepositoriesView extends ConsumerWidget {
  const RepositoriesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureProviderWrapper(
      provider: repositoriesFutureProvider,
      builder: (_) {
        final repositoryModels = ref.watch(repositoryModelListProvider);
        // Check if repository list is empty
        if (repositoryModels.isEmpty) {
          return const Center(child: Text('No repositories found.'));
        }

        return ListWithTitleAndSubtitle(
          title: PlatformListTile(
            title: Text('Number of repositories: ${repositoryModels.length}'),
          ),
          header: AnimatedOpacity(
            opacity: repositoryModels.isEmpty ? 0 : 1,
            duration: const Duration(milliseconds: 300),
            child: PlatformWidget(
              material: (_, __) => SegmentedButton<SortOrder>(
                selected: {ref.watch(sortOrderProvider)},
                segments: const [
                  ButtonSegment<SortOrder>(
                    value: SortOrder.ascending,
                    label: Text('Ascending'),
                  ),
                  ButtonSegment<SortOrder>(
                    value: SortOrder.descending,
                    label: Text('Descending'),
                  ),
                  ButtonSegment<SortOrder>(
                    value: SortOrder.unsorted,
                    label: Text('Unsorted'),
                  ),
                ],
                onSelectionChanged: (Set<SortOrder> value) {
                  ref.read(sortOrderProvider.notifier).state = value.first;
                },
                showSelectedIcon: false,
              ),
              cupertino: (_, __) => CupertinoSlidingSegmentedControl<SortOrder>(
                groupValue: ref.watch(sortOrderProvider),
                children: const {
                  SortOrder.ascending: Text('Ascending'),
                  SortOrder.descending: Text('Descending'),
                  SortOrder.unsorted: Text('Unsorted'),
                },
                onValueChanged: (SortOrder? value) {
                  ref.read(sortOrderProvider.notifier).state = value!;
                },
              ),
            ),
          ),
          widgets: <Widget>[
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
          ],
        );
      },
    );
  }
}
