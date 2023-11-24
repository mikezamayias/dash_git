import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../wrappers/future_provider_wrapper.dart';

class UserProfileView extends ConsumerWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FutureProviderWrapper(
        provider: userProvider,
        builder: (UserModel userModel) {
          return Column(
            children: [
              CircleAvatar(
                radius: 50,
                foregroundColor: Colors.transparent,
                backgroundImage: NetworkImage(userModel.avatarUrl!),
              ),
              const SizedBox(height: 16),
              Text(
                '${userModel.name}',
                style: platformThemeData(
                  context,
                  material: (data) => data.textTheme.titleMedium,
                  cupertino: (data) => data.textTheme.navTitleTextStyle,
                ),
              ),
              Text(
                '@${userModel.login!}',
                style: platformThemeData(
                  context,
                  material: (data) => data.textTheme.titleMedium,
                  cupertino: (data) => data.textTheme.navTitleTextStyle,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '${userModel.location}',
                style: platformThemeData(
                  context,
                  material: (data) => data.textTheme.titleMedium,
                  cupertino: (data) => data.textTheme.textStyle,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '${userModel.bio}',
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
                          cupertino: (data) => data.textTheme.navTitleTextStyle,
                        ),
                      ),
                      Text(
                        '${userModel.followers}',
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
                          cupertino: (data) => data.textTheme.navTitleTextStyle,
                        ),
                      ),
                      Text(
                        '${userModel.publicRepos}',
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
      ),
    );
  }
}
