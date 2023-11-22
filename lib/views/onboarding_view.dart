import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              PlatformTextButton(
                onPressed: () {},
                child: PlatformText(
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
      ),
    );
  }
}
