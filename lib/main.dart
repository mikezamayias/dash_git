import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'wrappers/dash_git_wrapper.dart';

void main() {
  runApp(
    const ProviderScope(
      child: DashGitWrapper(),
    ),
  );
}
