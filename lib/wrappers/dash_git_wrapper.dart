import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../themes/text_theme/material_text_theme.dart';
import '../views/dash_git.dart';

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
        builder: (context) => const PlatformApp(
          debugShowCheckedModeBanner: false,
          title: 'DashGit',
          home: DashGit(),
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
    );
  }
}
