import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../controllers/token_controller.dart';
import '../views/dash_git.dart';
import '../views/onboarding_view.dart';

class DashGitWrapper extends StatelessWidget {
  const DashGitWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      settings: PlatformSettingsData(
        iosUsesMaterialWidgets: true,
        iosUseZeroPaddingForAppbarPlatformIcon: true,
      ),
      builder: (BuildContext context) => PlatformTheme(
        themeMode: ThemeMode.system,
        materialLightTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.purple,
          ),
          useMaterial3: true,
        ),
        materialDarkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.purple,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        cupertinoLightTheme: const CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.purple,
          applyThemeToAll: true,
        ),
        cupertinoDarkTheme: const CupertinoThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.purple,
          applyThemeToAll: true,
        ),
        matchCupertinoSystemChromeBrightness: true,
        builder: (context) => PlatformApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ],
          title: 'DashGit',
          home: FutureBuilder(
            future: TokenController().fetchTokens(),
            builder: (context, snapshot) {
              return TokenController().tokenModel != null
                  ? const DashGit()
                  : const OnboardingView();
            },
          ),
          // home: DashGit(),
        ),
      ),
    );
  }
}
