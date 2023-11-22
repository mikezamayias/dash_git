import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../controllers/token_controller.dart';
import '../themes/text_theme/cupertino_text_theme.dart';
import '../themes/text_theme/material_text_theme.dart';
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
        materialLightTheme: _buildMaterialTheme(Brightness.light),
        materialDarkTheme: _buildMaterialTheme(Brightness.dark),
        cupertinoLightTheme: _buildCupertinoTheme(Brightness.light),
        cupertinoDarkTheme: _buildCupertinoTheme(Brightness.dark),
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

  ThemeData _buildMaterialTheme(Brightness brightness) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.purple,
        brightness: brightness,
      ),
      textTheme: materialTextTheme,
      useMaterial3: true,
    );
  }

  CupertinoThemeData _buildCupertinoTheme(Brightness brightness) {
    return CupertinoThemeData(
      brightness: brightness,
      primaryColor: Colors.purple,
      textTheme: cupertinoTextThemeData,
    );
  }
}
