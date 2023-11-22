import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: followerModels.length,
                    itemBuilder: (context, index) {
                      final follower = followerModels[index];
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            foregroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(follower.avatarUrl!),
                          ),
                          const SizedBox(height: 4),
                          Text('${follower.login}'),
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
