import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/app_top_bar.dart';

class PropertiesPage extends StatelessWidget {
  const PropertiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppTopBar(showBack: true),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.business_outlined,
                        size: 64, color: AppColors.lightGray),
                    const SizedBox(height: 16),
                    const Text(
                      'Mis Propiedades',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkNavy,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Gestiona tus propiedades registradas.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.grayText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(
        currentIndex: 1,
        onTap: _noop,
      ),
    );
  }

  static void _noop(int _) {}
}
