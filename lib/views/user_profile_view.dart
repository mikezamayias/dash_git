import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../controllers/user_profile_controller.dart';
import '../models/user_profile_model.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserProfileModel>(
      future: UserProfileController().fetchUserProfile('mikezamayias'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  foregroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(snapshot.data!.avatarUrl!),
                ),
                const SizedBox(height: 16),
                PlatformText(snapshot.data!.name!),
                const SizedBox(height: 16),
                PlatformText('@${snapshot.data!.login!}'),
                const SizedBox(height: 16),
                PlatformText(snapshot.data!.location!),
                const SizedBox(height: 16),
                PlatformText(snapshot.data!.bio!),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // location
                    Column(
                      children: [
                        PlatformText('Followers'),
                        PlatformText(snapshot.data!.followers.toString()),
                      ],
                    ),
                    Column(
                      children: [
                        PlatformText('Public Repos'),
                        PlatformText(snapshot.data!.publicRepos.toString()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: PlatformText('${snapshot.error}'));
        }
        return Center(child: PlatformCircularProgressIndicator());
      },
    );
  }
}
