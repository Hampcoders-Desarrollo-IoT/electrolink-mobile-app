import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    _NavItemData(Icons.home, 'Home'),
    _NavItemData(Icons.business_outlined, 'Propiedades'),
    _NavItemData(Icons.history, 'Historial'),
    _NavItemData(Icons.analytics_outlined, 'Analytics'),
    _NavItemData(Icons.person_outline, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = max(38.0, (screenWidth - 40) / _items.length);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_items.length, (index) {
            final item = _items[index];
            final isActive = index == currentIndex;
            return GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                constraints: BoxConstraints(minWidth: itemWidth),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: isActive
                    ? BoxDecoration(
                        color: AppColors.accentYellow,
                        borderRadius: BorderRadius.circular(9999),
                      )
                    : null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.icon,
                      size: 18,
                      color: isActive ? AppColors.darkNavy : AppColors.grayText,
                    ),
                    const SizedBox(height: 4),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isActive ? AppColors.darkNavy : AppColors.grayText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final String label;

  const _NavItemData(this.icon, this.label);
}
