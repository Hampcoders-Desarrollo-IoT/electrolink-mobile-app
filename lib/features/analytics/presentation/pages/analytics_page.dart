import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/app_top_bar.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
import '../../../history/presentation/pages/history_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../properties/presentation/pages/properties_page.dart';
import '../bloc/analytics_bloc.dart';
import '../bloc/analytics_event.dart';
import '../bloc/analytics_state.dart';
import '../widgets/anomaly_history.dart';
import '../widgets/circuit_comparison.dart';
import '../widgets/consumption_chart.dart';
import '../widgets/cost_projection_card.dart';
import '../widgets/period_tabs.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AnalyticsBloc(),
      child: const _AnalyticsView(),
    );
  }
}

class _AnalyticsView extends StatelessWidget {
  const _AnalyticsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppTopBar(showBack: true),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 96),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Analytics de Consumo',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkNavy,
                      ),
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<AnalyticsBloc, AnalyticsState>(
                      builder: (context, state) {
                        return PeriodTabs(
                          selectedIndex: state.selectedPeriod,
                          onSelected: (index) {
                            context
                                .read<AnalyticsBloc>()
                                .add(SelectPeriod(index: index));
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    const CostProjectionCard(),
                    const SizedBox(height: 24),
                    const ConsumptionChart(),
                    const SizedBox(height: 24),
                    const CircuitComparison(),
                    const SizedBox(height: 24),
                    const AnomalyHistory(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(currentIndex: 3, onTap: (i) => _onNavTap(context, i)),
    );
  }
}

void _onNavTap(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DashboardPage()),
      );
      break;
    case 1:
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const PropertiesPage()),
      );
      break;
    case 2:
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HistoryPage()),
      );
      break;
    case 3:
      break;
    case 4:
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ProfilePage()),
      );
      break;
  }
}
