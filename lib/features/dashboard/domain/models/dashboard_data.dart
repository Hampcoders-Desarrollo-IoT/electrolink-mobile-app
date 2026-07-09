import 'package:equatable/equatable.dart';

class PlanSummary extends Equatable {
  final String name;
  final bool isActive;

  const PlanSummary({required this.name, required this.isActive});

  factory PlanSummary.fromSubscription(Map<String, dynamic>? json) {
    if (json == null) return const PlanSummary(name: 'Free', isActive: false);
    final status = json['status'] as String? ?? 'Inactive';
    return PlanSummary(
      name: json['planType'] as String? ?? 'Free',
      isActive: status == 'Active',
    );
  }

  @override
  List<Object> get props => [name, isActive];
}

class ActiveService extends Equatable {
  final String title;
  final String subtitle;
  final String location;
  final String technicianInitials;
  final String technicianName;

  const ActiveService({
    required this.title,
    required this.subtitle,
    required this.location,
    required this.technicianInitials,
    required this.technicianName,
  });

  @override
  List<Object> get props => [title, subtitle, location, technicianName];
}

class QuickAction extends Equatable {
  final String label;
  final String icon;

  const QuickAction({required this.label, required this.icon});

  @override
  List<Object> get props => [label, icon];
}

class Property extends Equatable {
  final String name;
  final String address;
  final bool isOk;
  final String lastRevision;
  final String activeAssets;

  const Property({
    required this.name,
    required this.address,
    required this.isOk,
    required this.lastRevision,
    required this.activeAssets,
  });

  @override
  List<Object> get props => [name, address, isOk, lastRevision, activeAssets];
}

class DashboardData extends Equatable {
  final PlanSummary planSummary;
  final ActiveService activeService;
  final List<QuickAction> quickActions;
  final List<Property> properties;

  const DashboardData({
    required this.planSummary,
    required this.activeService,
    required this.quickActions,
    required this.properties,
  });

  factory DashboardData.fromApi({
    required Map<String, dynamic>? subscriptionJson,
    required Map<String, dynamic>? profileJson,
  }) {
    final planSummary = PlanSummary.fromSubscription(subscriptionJson);

    return DashboardData(
      planSummary: planSummary,
      activeService: const ActiveService(
        title: '',
        subtitle: '',
        location: '',
        technicianInitials: '',
        technicianName: '',
      ),
      quickActions: const [
        QuickAction(label: 'Añadir Dispositivo', icon: 'add'),
        QuickAction(label: 'Nueva Solicitud', icon: 'add'),
        QuickAction(label: 'Mis Facturas', icon: 'receipt'),
        QuickAction(label: 'Soporte', icon: 'support'),
        QuickAction(label: 'Historial', icon: 'history'),
      ],
      properties: const [],
    );
  }

  @override
  List<Object> get props => [planSummary, activeService, quickActions, properties];

  static const empty = DashboardData(
    planSummary: PlanSummary(name: '', isActive: false),
    activeService: ActiveService(
      title: '', subtitle: '', location: '',
      technicianInitials: '', technicianName: '',
    ),
    quickActions: [],
    properties: [],
  );
}
