import 'package:flutter/material.dart';

import 'wrappers/dash_kit_wrapper.dart';

void main() {
  runApp(const DashKit());
}

class DashKit extends StatelessWidget {
  const DashKit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DashGit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const DashKitWrapper(),
    );
  }
}
