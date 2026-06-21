import 'package:flutter/material.dart';
// Asegúrate de validar si tu proyecto usa 'mobile_app_electrolink' o 'electrolink_mobile_app'
import 'package:mobile_app_electrolink/features/technical/presentation/screens/technical_dashboard_screen.dart';

void main() {
  runApp(const ElectroLinkApp());
}

class ElectroLinkApp extends StatelessWidget {
  const ElectroLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ElectroLink Técnico',
      theme: ThemeData(
        // Forzamos el uso de Material 3 y la paleta de colores de la app
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A237E)),
        useMaterial3: true,
      ),
      // Apuntamos directamente al Dashboard Técnico que acabamos de crear
      home: const TechnicalDashboardScreen(),
    );
  }
}