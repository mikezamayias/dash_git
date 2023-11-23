import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';

class SearchUserView extends ConsumerWidget {
  const SearchUserView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = TextEditingController();
    final searchQuery = ref.watch(searchQueryProvider);

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Search User'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              PlatformWidget(
                cupertino: (context, _) => CupertinoSearchTextField(
                  controller: textEditingController,
                  placeholder: 'Search User',
                ),
                material: (context, _) => TextField(
                  controller: textEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Search User',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder(
                valueListenable: textEditingController,
                builder: (context, value, child) {
                  return PlatformElevatedButton(
                    onPressed: textEditingController.text.isNotEmpty
                        ? () {
                            ref.read(searchQueryProvider.notifier).state =
                                textEditingController.text;
                          }
                        : null,
                    child: PlatformText('Search'),
                  );
                },
              ),
              if (searchQuery != null && searchQuery.isNotEmpty)
                ref.watch(userProvider(searchQuery)).when(
                      data: (UserModel userModel) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                foregroundColor: Colors.transparent,
                                backgroundImage:
                                    NetworkImage(userModel.avatarUrl!),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                '${userModel.name}',
                                style: platformThemeData(
                                  context,
                                  material: (data) =>
                                      data.textTheme.titleMedium,
                                  cupertino: (data) =>
                                      data.textTheme.navTitleTextStyle,
                                ),
                              ),
                              Text(
                                '@${userModel.login!}',
                                style: platformThemeData(
                                  context,
                                  material: (data) =>
                                      data.textTheme.titleMedium,
                                  cupertino: (data) =>
                                      data.textTheme.navTitleTextStyle,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                '${userModel.location}',
                                style: platformThemeData(
                                  context,
                                  material: (data) =>
                                      data.textTheme.titleMedium,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // location
                                  Column(
                                    children: [
                                      Text(
                                        'Followers',
                                        style: platformThemeData(
                                          context,
                                          material: (data) =>
                                              data.textTheme.titleMedium,
                                          cupertino: (data) =>
                                              data.textTheme.navTitleTextStyle,
                                        ),
                                      ),
                                      Text(
                                        '${userModel.followers}',
                                        style: platformThemeData(
                                          context,
                                          material: (data) =>
                                              data.textTheme.bodyMedium,
                                          cupertino: (data) =>
                                              data.textTheme.textStyle,
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
                                          material: (data) =>
                                              data.textTheme.titleMedium,
                                          cupertino: (data) =>
                                              data.textTheme.navTitleTextStyle,
                                        ),
                                      ),
                                      Text(
                                        '${userModel.publicRepos}',
                                        style: platformThemeData(
                                          context,
                                          material: (data) =>
                                              data.textTheme.bodyMedium,
                                          cupertino: (data) =>
                                              data.textTheme.textStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      loading: () => Center(
                        child: PlatformCircularProgressIndicator(),
                      ),
                      error: (error, stack) => Center(child: Text('$error')),
                    )
              else
                const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
