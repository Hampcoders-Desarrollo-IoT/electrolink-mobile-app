import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_top_bar.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../device_onboarding/data/repositories/onboarding_repository_impl.dart';
import '../../../device_onboarding/presentation/pages/onboarding_wizard_page.dart';
import '../../../service_request/presentation/pages/service_request_page.dart';
import '../../domain/models/dashboard_data.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_state.dart';
import '../widgets/active_service_card.dart';
import '../widgets/plan_summary_card.dart';
import '../widgets/property_card.dart';
import '../widgets/quick_actions.dart';

class DashboardTab extends StatelessWidget {
  final VoidCallback? onMenuTap;

  const DashboardTab({super.key, this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
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
    );
  }

  void _onQuickActionTap(BuildContext context, String label) {
    switch (label) {
      case 'Añadir Dispositivo':
        final client = ApiClient(baseUrl: ApiEndpoints.baseUrl);
        final repo = OnboardingRepositoryImpl(client);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => OnboardingWizardPage(repository: repo),
          ),
        );
        break;
      case 'Nueva Solicitud':
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ServiceRequestPage()),
        );
        break;
    }
  }

  Widget _buildBody(BuildContext context, DashboardData data) {
    return Column(
      children: [
        AppTopBar(onMenuTap: onMenuTap),
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
                  onViewDetails: () {},
                ),
                const SizedBox(height: 24),
                QuickActionsSection(
                  actions: data.quickActions,
                  onActionTap: (label) => _onQuickActionTap(context, label),
                ),
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
                      child: const Row(
                        children: [
                          Text(
                            'Ver todas',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.darkNavy,
                            ),
                          ),
                          SizedBox(width: 4),
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
    );
  }
}
