import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screwdriver/flutter_screwdriver.dart';

import '../controllers/token_controller.dart';
import '../models/token_model.dart';
import '../services/github_auth_service.dart';
import '../widgets/blueprint_view.dart';
import 'dash_git.dart';

class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PlatformScaffold(
      body: BlueprintView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              'DashGit',
              style: platformThemeData(
                context,
                material: (ThemeData data) => data.textTheme.displayLarge,
                cupertino: (CupertinoThemeData data) =>
                    data.textTheme.navLargeTitleTextStyle,
              ),
            ),
            const Spacer(),
            Text(
              'A GitHub dashboard app built with Flutter.',
              style: platformThemeData(
                context,
                material: (ThemeData data) => data.textTheme.headlineSmall,
                cupertino: (CupertinoThemeData data) =>
                    data.textTheme.navTitleTextStyle,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'See your profile, repositories, and more!',
              style: platformThemeData(
                context,
                material: (ThemeData data) => data.textTheme.headlineSmall,
                cupertino: (CupertinoThemeData data) =>
                    data.textTheme.navTitleTextStyle,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Built with Flutter, GitHub API, and GitHub Actions.',
              style: platformThemeData(
                context,
                material: (ThemeData data) => data.textTheme.headlineSmall,
                cupertino: (CupertinoThemeData data) =>
                    data.textTheme.navTitleTextStyle,
              ),
            ),
            const SizedBox(height: 16),
            PlatformTextButton(
              onPressed: () async {
                ref.read(gitHubAuthProvider).authenticate().whenComplete(
                  () {
                    ref
                        .read(tokenControllerProvider.notifier)
                        .fetchTokens()
                        .whenComplete(
                      () {
                        (TokenModel value) {
                          if (value.accessToken.isNotEmpty) {
                            context.navigator.pushReplacement(
                              platformPageRoute(
                                context: context,
                                builder: (context) => const DashGit(),
                              ),
                            );
                          }
                        };
                      },
                    );
                  },
                );
              },
              child: Text(
                'Get Started',
                style: platformThemeData(
                  context,
                  material: (ThemeData data) => data.textTheme.labelLarge,
                  cupertino: (CupertinoThemeData data) =>
                      data.textTheme.actionTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
