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
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: followerModels.length,
                    itemBuilder: (context, index) {
                      final follower = followerModels.elementAt(index);
                      return PlatformListTile(
                        title: Text('${follower.login}'),
                        leading: CircleAvatar(
                          radius: 25,
                          foregroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(follower.avatarUrl!),
                        ),
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
