import 'package:flutter/material.dart';
import 'package:mobile_app_electrolink/features/auth/presentation/screens/auth_screen.dart';

import 'features/auth/presentation/screens/auth_screen.dart';

void main() {
  runApp(const ElectroLinkApp());
}

class ElectroLinkApp extends StatelessWidget {
  const ElectroLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ElectroLink',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A237E)),
        useMaterial3: true,
      ),
      home: const AuthScreen(),
    );
  }
}