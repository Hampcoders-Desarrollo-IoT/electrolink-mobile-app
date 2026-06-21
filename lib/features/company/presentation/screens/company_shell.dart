import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../widgets/company_drawer.dart';
import 'company_dashboard_page.dart';
import 'company_properties_page.dart';
import 'company_services_page.dart';
import 'company_analytics_page.dart';
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
            CompanyDashboardPage(
              onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            CompanyPropertiesPage(
              onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            CompanyServicesPage(
              onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            CompanyAnalyticsPage(
              onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),
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
      floatingActionButton: _selectedIndex == 0 || _selectedIndex == 2
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
