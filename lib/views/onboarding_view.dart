import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../widgets/blueprint_view.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: BlueprintView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            PlatformText(
              'DashGit',
              style: platformThemeData(
                context,
                material: (ThemeData data) => data.textTheme.displayLarge,
                cupertino: (CupertinoThemeData data) =>
                    data.textTheme.navLargeTitleTextStyle,
              ),
            ),
            const Spacer(),
            PlatformText(
              'A GitHub dashboard app built with Flutter.',
              style: platformThemeData(
                context,
                material: (ThemeData data) => data.textTheme.headlineSmall,
                cupertino: (CupertinoThemeData data) =>
                    data.textTheme.navTitleTextStyle,
              ),
            ),
            const SizedBox(height: 16),
            PlatformText(
              'See your profile, repositories, and more!',
              style: platformThemeData(
                context,
                material: (ThemeData data) => data.textTheme.headlineSmall,
                cupertino: (CupertinoThemeData data) =>
                    data.textTheme.navTitleTextStyle,
              ),
            ),
            const SizedBox(height: 16),
            PlatformText(
              'Built with Flutter, GitHub API, and GitHub Actions.',
              style: platformThemeData(
                context,
                material: (ThemeData data) => data.textTheme.headlineSmall,
                cupertino: (CupertinoThemeData data) =>
                    data.textTheme.navTitleTextStyle,
              ),
            ),
            const SizedBox(height: 16),
            SupaSocialsAuth(
              socialProviders: const [
                SocialProviders.github,
              ],
              redirectUrl: 'io.supabase.flutter://reset-callback/',
              onSuccess: (Session response) {
                // do something, for example: navigate('home');
                log(
                  response.toString(),
                  name: 'SupaSocialsAuth:onSuccess',
                );
              },
              onError: (error) {
                // do something, for example: navigate("wait_for_email");
                log(
                  error.toString(),
                  name: 'SupaSocialsAuth:onError',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
