import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/follower_model.dart';
import '../providers/followers_provider.dart';

class FollowersView extends ConsumerWidget {
  const FollowersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final followersAsyncValue = ref.watch(followersProvider);

    return Container(
      color: platformThemeData(
        context,
        cupertino: (data) => CupertinoColors.systemGroupedBackground,
        material: (data) => data.colorScheme.surface,
      ),
      child: followersAsyncValue.when(
        loading: () => Center(child: PlatformCircularProgressIndicator()),
        error: (error, _) => Center(child: PlatformText('Error: $error')),
        data: (List<FollowerModel> followerModels) {
          if (followerModels.isEmpty) {
            return Center(child: PlatformText('No followers found.'));
          }

          final header = PlatformListTile(
            title: Text('Number of followers: ${followerModels.length}'),
          );

          final widgets = <Widget>[
            for (final followerModel in followerModels)
              PlatformListTile(
                leading: CircleAvatar(
                  radius: 20,
                  foregroundColor: Colors.transparent,
                  backgroundImage: NetworkImage('${followerModel.avatarUrl}'),
                ),
                title: PlatformText('${followerModel.login}'),
              ),
          ];

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
      ),
    );
  }
}
