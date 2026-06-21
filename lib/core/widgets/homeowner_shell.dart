import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/app_theme.dart';
import 'app_bottom_nav_bar.dart';
import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../features/dashboard/presentation/bloc/dashboard_event.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/dashboard/presentation/widgets/dashboard_drawer.dart';
import '../../features/service_request/presentation/pages/service_request_page.dart';
import '../../features/properties/presentation/pages/properties_page.dart';
import '../../features/history/presentation/pages/history_page.dart';
import '../../features/analytics/presentation/pages/analytics_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';

class HomeownerShell extends StatefulWidget {
  final int initialIndex;

  const HomeownerShell({super.key, this.initialIndex = 0});

  @override
  State<HomeownerShell> createState() => _HomeownerShellState();
}

class _HomeownerShellState extends State<HomeownerShell> {
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
    return BlocProvider(
      create: (_) => DashboardBloc()..add(const FetchDashboard()),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DashboardDrawer(
          onNavigateToTab: _onTabSelected,
        ),
        body: SafeArea(
          child: IndexedStack(
            index: _selectedIndex,
            children: [
              DashboardTab(
                onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
              ),
              PropertiesPage(
                onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
              ),
              HistoryPage(
                onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
              ),
              AnalyticsPage(
                onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
              ),
              ProfilePage(
                onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: _selectedIndex,
          onTap: _onTabSelected,
        ),
        floatingActionButton: _selectedIndex == 0
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
      ),
    );
  }
}
