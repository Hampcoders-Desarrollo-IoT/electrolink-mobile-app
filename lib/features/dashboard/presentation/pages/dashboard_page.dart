import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/app_top_bar.dart';
import '../../../analytics/presentation/pages/analytics_page.dart';
import '../../../history/presentation/pages/history_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../properties/presentation/pages/properties_page.dart';
import '../../../service_request/presentation/pages/service_request_page.dart';
import '../../domain/models/dashboard_data.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import '../widgets/active_service_card.dart';
import '../widgets/dashboard_drawer.dart';
import '../widgets/plan_summary_card.dart';
import '../widgets/property_card.dart';
import '../widgets/quick_actions.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardBloc()..add(const FetchDashboard()),
      child: Scaffold(
        drawer: const DashboardDrawer(),
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading || state is DashboardInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is DashboardError) {
              return Center(child: Text(state.message));
            }
            if (state is DashboardLoaded) {
              return _buildBody(context, state.data);
            }
            return const SizedBox();
          },
        ),
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: 0,
          onTap: (i) => _onNavTap(context, i),
        ),
        floatingActionButton: GestureDetector(
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget _buildBody(BuildContext context, DashboardData data) {
    return SafeArea(
      child: Column(
        children: [
          AppTopBar(
            onMenuTap: () => Scaffold.of(context).openDrawer(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PlanSummaryCard(plan: data.planSummary),
                  const SizedBox(height: 16),
                  ActiveServiceCard(
                    service: data.activeService,
                    onViewDetails: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AnalyticsPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  QuickActionsSection(actions: data.quickActions),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'My Properties',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkText,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            const Text(
                              'Ver todas',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.darkNavy,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 8,
                              color: AppColors.darkNavy,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...data.properties.map(
                    (p) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: PropertyCard(property: p),
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

  void _onNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const PropertiesPage()),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const HistoryPage()),
        );
        break;
      case 3:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AnalyticsPage()),
        );
        break;
      case 4:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ProfilePage()),
        );
        break;
    }
  }
}
