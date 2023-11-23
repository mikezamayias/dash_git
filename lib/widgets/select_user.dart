import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/query_provider.dart';

class SelectUser extends ConsumerWidget {
  const SelectUser({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profiles = [
      'visionmedia',
      'c9s',
      'fabpot',
      'dcramer',
    ];
    return PlatformWidget(
      cupertino: (context, _) => Column(
        children: [
          CupertinoListTile(
            title: Text(
              'Search for a user to view their $label.',
            ),
            subtitle: const Text(
              'Tap the search icon in the top right corner to search for a user.',
            ),
          ),
          CupertinoListSection.insetGrouped(
            topMargin: 0,
            hasLeading: false,
            header: const CupertinoListTile(
              title: Text(
                'Or tap one of the users below.',
              ),
            ),
            children: [
              for (final profile in profiles) ...[
                CupertinoListTile(
                  title: Text(profile),
                  onTap: () {
                    ref.read(usernameQueryProvider.notifier).state = profile;
                  },
                ),
              ],
            ],
          ),
        ],
      ),
      material: (context, _) => Column(
        children: [
          ListTile(
            title: Text(
              'Search for a user to view their $label.',
            ),
            subtitle: const Text(
              'Tap the search icon in the top right corner to search for a user.',
            ),
          ),
          const ListTile(
            title: Text(
              'Or tap one of the users below.',
            ),
          ),
          Column(
            children: [
              for (final profile in profiles) ...[
                ListTile(
                  title: Text(profile),
                  onTap: () {
                    ref.read(usernameQueryProvider.notifier).state = profile;
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
