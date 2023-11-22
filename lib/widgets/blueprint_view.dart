import 'package:flutter/material.dart';

class BlueprintView extends StatelessWidget {
  final Widget child;

  const BlueprintView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
