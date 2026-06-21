import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../subscription/presentation/pages/subscription_page.dart';
import '../../../auth/presentation/screens/auth_screen.dart';

class CompanyDrawer extends StatefulWidget {
  final int currentIndex;
  final void Function(int index)? onNavigateToTab;

  const CompanyDrawer({super.key, this.currentIndex = 0, this.onNavigateToTab});

  @override
  State<CompanyDrawer> createState() => _CompanyDrawerState();
}

class _CompanyDrawerState extends State<CompanyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          width: 320,
          decoration: const BoxDecoration(
            color: AppColors.drawerBg,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 15,
                offset: Offset(0, 10),
              ),
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildHeader(),
              _buildProfileCard(),
              const SizedBox(height: 8),
              Expanded(child: _buildNavLinks()),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.brandLogoBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.bolt, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Text(
            'ElectroLink',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.darkNavy,
              letterSpacing: -0.8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 286,
        decoration: BoxDecoration(
          color: AppColors.appBarBg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderLight.withValues(alpha: 0.3)),
        ),
        child: SizedBox(
          height: 123,
          child: Stack(
            children: [
              Positioned(
                left: 22,
                top: 21,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.brandLogoBg, width: 2),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0D000000),
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.business,
                      size: 32, color: AppColors.brandLogoBg),
                ),
              ),
              Positioned(
                left: 100,
                top: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TechCorp S.A.C.',
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkNavy,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Estado: Activo',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.green,
                        letterSpacing: 0.12,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 101,
                top: 68,
                child: Text(
                  'RUC: 20123456789',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.idText,
                  ),
                ),
              ),
              Positioned(
                left: 101,
                top: 86,
                child: Container(
                  padding: const EdgeInsets.only(left: 8, right: 28.02),
                  decoration: BoxDecoration(
                    color: AppColors.planBadgeBg,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star,
                          size: 12.25, color: AppColors.planBadgeText),
                      const SizedBox(width: 4),
                      Text(
                        'Enterprise Premium',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.planBadgeText,
                          letterSpacing: 0.12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavLinks() {
    final items = [
      ('Dashboard', Icons.dashboard, 0),
      ('Sedes', Icons.business_outlined, 1),
      ('Servicios', Icons.build_outlined, 2),
      ('Analytics', Icons.analytics_outlined, 3),
      ('Suscripción', Icons.card_membership_outlined, 4),
      ('Perfil', Icons.person_outline, 5),
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: items.map((item) {
          return _NavItem(
            icon: item.$2,
            label: item.$1,
            isActive: widget.currentIndex == item.$3,
            onTap: () => _navigateTo(context, item.$3),
          );
        }).toList(),
      ),
    );
  }

  void _navigateTo(BuildContext context, int index) {
    Navigator.of(context).pop();

    if (index == 4) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const SubscriptionPage()),
      );
      return;
    }

    final tabMap = {0: 0, 1: 1, 2: 2, 3: 3, 5: 4};
    final tabIndex = tabMap[index];
    if (tabIndex != null) {
      widget.onNavigateToTab?.call(tabIndex);
    }
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Column(
        children: [
          const Divider(
            color: AppColors.borderLight,
            height: 1,
            thickness: 1,
          ),
          const SizedBox(height: 17),
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const AuthScreen()),
                (route) => false,
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout, size: 18, color: AppColors.errorRed),
                  SizedBox(width: 8),
                  Text(
                    'Cerrar Sesión',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.errorRed,
                      letterSpacing: 0.28,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? AppColors.drawerActiveBg : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: isActive
                    ? AppColors.drawerActiveText
                    : AppColors.grayText,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive
                      ? AppColors.drawerActiveText
                      : AppColors.grayText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
