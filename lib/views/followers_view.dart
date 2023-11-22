import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/follower_model.dart';
import '../providers/followers_provider.dart';

class FollowersView extends ConsumerWidget {
  const FollowersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final followerModels = ref.watch(followersProvider);
    return followerModels.when(
      data: (List<FollowerModel> followerModels) {
        return PlatformScaffold(
          appBar: PlatformAppBar(
            title: const Text('Followers'),
            trailingActions: [
              Icon(PlatformIcons(context).person),
              Center(
                child: Text(
                  '${followerModels.length}',
                  style: platformThemeData(
                    context,
                    material: (data) => data.textTheme.bodyLarge,
                    cupertino: (data) =>
                        data.textTheme.navTitleTextStyle.copyWith(
                      color: data.primaryColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: followerModels.isEmpty
                ? Center(child: PlatformCircularProgressIndicator())
                : AlignedGridView.count(
                    itemCount: followerModels.length,
                    padding: const EdgeInsets.all(16),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    itemBuilder: (context, index) {
                      final followerModel = followerModels.elementAt(index);
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            foregroundColor: Colors.transparent,
                            backgroundImage:
                                NetworkImage(followerModel.avatarUrl!),
                          ),
                          const SizedBox(height: 8),
                          Text('@${followerModel.login}'),
                        ],
                      );
                    },
                  ),
          ),
        );
      },
      loading: () => Center(child: PlatformCircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
