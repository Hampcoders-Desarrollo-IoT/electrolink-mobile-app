// lib/features/company/presentation/screens/company_shell.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../widgets/company_drawer.dart';
import 'company_dashboard_page.dart';
import 'package:mobile_app_electrolink/features/company/presentation/screens/company_services_page.dart';
import 'company_iot_page.dart'; // Asegúrate de importar tu nueva página de IoT
import 'company_profile_page.dart';
import '../../../service_request/presentation/pages/service_request_page.dart';


class CompanyShell extends StatefulWidget {
  final int initialIndex;

  const CompanyShell({super.key, this.initialIndex = 0});

  @override
  State<CompanyShell> createState() => _CompanyShellState();
}

class _CompanyShellState extends State<CompanyShell> {
  late int _selectedIndex;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onTabSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CompanyDrawer(
        currentIndex: _selectedIndex,
        onNavigateToTab: _onTabSelected,
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            // Índice 0: Home
            CompanyDashboardPage(
              onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            // Índice 1: Services (Mantenimientos)
            CompanyServicesPage(
              onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            // Índice 2: IoT (Monitoreo en tiempo real)
            CompanyIotPage(
              onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            // Índice 3: Profile (Ajustes corporativos)
            CompanyProfilePage(
              onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onTabSelected,
      ),
      // El botón flotante de agregar servicio ahora se muestra en Home (0) o Services (1)
      floatingActionButton: _selectedIndex == 0 || _selectedIndex == 1
          ? GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ServiceRequestPage()),
          );
        },
        child: Container(
          width: 56,
          height: 56,
          decoration: const BoxDecoration(
            color: AppColors.primaryBlue,
            shape: BoxShape.circle,
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
          child: const Icon(Icons.add, color: Colors.white, size: 24),
        ),
      )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}