import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../widgets/list_with_title_and_subtitle.dart';
import '../widgets/user_profile_view/profile_field_tile.dart';
import '../wrappers/future_provider_wrapper.dart';

class UserProfileView extends ConsumerWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.topCenter,
      child: FutureProviderWrapper(
        provider: userFutureProvider,
        builder: (UserModel userModel) {
          final profileFieldTiles = <Widget>[
            ProfileFieldTile(
              fieldName: 'Name',
              fieldValue: '${userModel.name}',
            ),
            ProfileFieldTile(
              fieldName: 'Username',
              fieldValue: '@${userModel.login}',
            ),
            ProfileFieldTile(
              fieldName: 'Location',
              fieldValue: '${userModel.location}',
            ),
            ProfileFieldTile(
              fieldName: 'Bio',
              fieldValue: '${userModel.bio}',
            ),
            ProfileFieldTile(
              fieldName: 'Followers',
              fieldValue: '${userModel.followers}',
            ),
            ProfileFieldTile(
              fieldName: 'Public Repos',
              fieldValue: '${userModel.publicRepos}',
            ),
          ];
          // return Column(
          //   children: [
          //     CircleAvatar(
          //       radius: 50,
          //       foregroundColor: Colors.transparent,
          //       backgroundImage: NetworkImage(userModel.avatarUrl!),
          //     ),
          //     const SizedBox(height: 16),
          //     ListWithTitleAndSubtitle(
          //       title: const Text('Information'),
          //       widgets: profileFieldTiles,
          //     ),
          //   ],
          // );
          return ListWithTitleAndSubtitle(
            header: CircleAvatar(
              radius: 50,
              foregroundColor: Colors.transparent,
              backgroundImage: NetworkImage(userModel.avatarUrl!),
            ),
            title: const Text('Information'),
            widgets: profileFieldTiles,
          );
        },
      ),
    );
  }
}
