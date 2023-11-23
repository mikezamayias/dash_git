import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';

class UserProfileView extends ConsumerWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: platformThemeData(
        context,
        cupertino: (data) => CupertinoColors.systemGroupedBackground,
        material: (data) => data.colorScheme.surface,
      ),
      padding: const EdgeInsets.all(16),
      child: ref.watch(userProvider).when(
            data: (UserModel userProfile) {
              return Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    foregroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(userProfile.avatarUrl!),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${userProfile.name}',
                    style: platformThemeData(
                      context,
                      material: (data) => data.textTheme.titleMedium,
                      cupertino: (data) => data.textTheme.navTitleTextStyle,
                    ),
                  ),
                  Text(
                    '@${userProfile.login!}',
                    style: platformThemeData(
                      context,
                      material: (data) => data.textTheme.titleMedium,
                      cupertino: (data) => data.textTheme.navTitleTextStyle,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${userProfile.location}',
                    style: platformThemeData(
                      context,
                      material: (data) => data.textTheme.titleMedium,
                      cupertino: (data) => data.textTheme.textStyle,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${userProfile.bio}',
                    style: platformThemeData(
                      context,
                      material: (data) => data.textTheme.bodyMedium,
                      cupertino: (data) => data.textTheme.textStyle,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // location
                      Column(
                        children: [
                          Text(
                            'Followers',
                            style: platformThemeData(
                              context,
                              material: (data) => data.textTheme.titleMedium,
                              cupertino: (data) =>
                                  data.textTheme.navTitleTextStyle,
                            ),
                          ),
                          Text(
                            '${userProfile.followers}',
                            style: platformThemeData(
                              context,
                              material: (data) => data.textTheme.bodyMedium,
                              cupertino: (data) => data.textTheme.textStyle,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Public Repos',
                            style: platformThemeData(
                              context,
                              material: (data) => data.textTheme.titleMedium,
                              cupertino: (data) =>
                                  data.textTheme.navTitleTextStyle,
                            ),
                          ),
                          Text(
                            '${userProfile.publicRepos}',
                            style: platformThemeData(
                              context,
                              material: (data) => data.textTheme.bodyMedium,
                              cupertino: (data) => data.textTheme.textStyle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
            loading: () => Center(child: PlatformCircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('$error')),
          ),
    );
  }
}
