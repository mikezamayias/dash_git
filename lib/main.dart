import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'wrappers/dash_git_wrapper.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://sngrhmtgooegdhynouos.supabase.co/auth/v1/callback',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNuZ3JobXRnb29lZ2RoeW5vdW9zIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDA2NTk0ODIsImV4cCI6MjAxNjIzNTQ4Mn0.sWdaeZPCyITiW3JrbMNRkN-5gyYiRTTGd-n4dua4hYI',
  );

  runApp(
    const ProviderScope(
      child: DashGitWrapper(),
    ),
  );
}
