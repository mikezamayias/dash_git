import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/user_profile_provider.dart';
import '../models/user_profile_model.dart';

class UserProfileView extends ConsumerWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsyncValue = ref.watch(userProfileProvider);
    return userProfileAsyncValue.when(
      data: (UserProfileModel userProfile) {
        return PlatformScaffold(
          appBar: PlatformAppBar(
            title: const Text('User Profile'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    foregroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(userProfile.avatarUrl!),
                  ),
                  const SizedBox(height: 16),
                  Text(userProfile.name!),
                  Text('@${userProfile.login!}'),
                  const SizedBox(height: 16),
                  Text(userProfile.location!),
                  const SizedBox(height: 16),
                  Text(userProfile.bio!),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // location
                      Column(
                        children: [
                          const Text('Followers'),
                          Text(userProfile.followers.toString()),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Public Repos'),
                          Text(userProfile.publicRepos.toString()),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => Center(child: PlatformCircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
