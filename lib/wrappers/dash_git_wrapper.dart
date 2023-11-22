import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/token_controller.dart';
import '../views/dash_git.dart';
import '../views/onboarding_view.dart';

class DashGitWrapper extends StatelessWidget {
  const DashGitWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final fontFamily = GoogleFonts.ubuntu().fontFamily!;
    return PlatformProvider(
      settings: PlatformSettingsData(
        iosUsesMaterialWidgets: true,
        iosUseZeroPaddingForAppbarPlatformIcon: true,
      ),
      builder: (BuildContext context) => PlatformTheme(
        themeMode: ThemeMode.system,
        materialLightTheme: _buildMaterialTheme(Brightness.light, fontFamily),
        materialDarkTheme: _buildMaterialTheme(Brightness.dark, fontFamily),
        cupertinoLightTheme: _buildCupertinoTheme(Brightness.light, fontFamily),
        cupertinoDarkTheme: _buildCupertinoTheme(Brightness.dark, fontFamily),
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

  ThemeData _buildMaterialTheme(
    Brightness brightness,
    String fontFamily,
  ) {
    return ThemeData(
      fontFamily: fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.purple,
        brightness: brightness,
      ),
      useMaterial3: true,
    );
  }

  CupertinoThemeData _buildCupertinoTheme(
    Brightness brightness,
    String fontFamily,
  ) {
    return CupertinoThemeData(
      brightness: brightness,
      primaryColor: Colors.purple,
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(fontFamily: fontFamily),
        actionTextStyle: TextStyle(fontFamily: fontFamily),
        tabLabelTextStyle: TextStyle(fontFamily: fontFamily),
        navTitleTextStyle: TextStyle(fontFamily: fontFamily),
        navLargeTitleTextStyle: TextStyle(fontFamily: fontFamily),
        navActionTextStyle: TextStyle(fontFamily: fontFamily),
        pickerTextStyle: TextStyle(fontFamily: fontFamily),
        dateTimePickerTextStyle: TextStyle(fontFamily: fontFamily),
      ),
    );
  }
}
