import 'package:flutter/material.dart';

import 'package:mobile_app_electrolink/features/technical/presentation/screens/technical_dashboard_screen.dart';
import 'core/theme/app_theme.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';
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
      title: 'ElectroLink',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const DashboardPage(),
    );
  }
}