import '../../domain/models/dashboard_data.dart';
import '../../domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  @override
  Future<DashboardData> getDashboardData() async {
    return const DashboardData(
      planSummary: PlanSummary(name: 'Plan Premium', isActive: true),
      activeService: ActiveService(
        title: 'Mantenimiento de',
        subtitle: 'Tablero',
        location: 'Casa Principal',
        technicianInitials: 'LG',
        technicianName: 'Luis García',
      ),
      quickActions: [
        QuickAction(label: 'Nueva Solicitud', icon: 'add'),
        QuickAction(label: 'Mis Facturas', icon: 'receipt'),
        QuickAction(label: 'Soporte', icon: 'support'),
        QuickAction(label: 'Historial', icon: 'history'),
      ],
      properties: [
        Property(
          name: 'Casa Principal',
          address: 'Av. Siempre Viva 742',
          isOk: true,
          lastRevision: '12 Oct 2023',
          activeAssets: '4 Tableros',
        ),
      ],
    );
  }
}
