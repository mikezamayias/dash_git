import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screwdriver/flutter_screwdriver.dart';

class DashKitWrapper extends StatelessWidget {
  const DashKitWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getSystemUIOverlayStyle(Theme.of(context)),
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: const SafeArea(
          child: Scaffold(
            body: Center(
              child: Text('DashKit'),
            ),
          ),
        ),
      ),
    );
  }

  SystemUiOverlayStyle getSystemUIOverlayStyle(ThemeData theme) {
    if (Platform.isAndroid) {
      return SystemUiOverlayStyle(
        systemNavigationBarColor: theme.colorScheme.background,
        systemNavigationBarDividerColor: theme.colorScheme.background,
        systemNavigationBarIconBrightness:
            theme.brightness.isLight ? Brightness.dark : Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            theme.brightness.isLight ? Brightness.dark : Brightness.light,
      );
    } else {
      return switch (WidgetsBinding
          .instance.platformDispatcher.platformBrightness.isLight) {
        true => SystemUiOverlayStyle.dark,
        false => SystemUiOverlayStyle.light,
      };
    }
  }
}
