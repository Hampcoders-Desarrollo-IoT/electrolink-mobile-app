import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_top_bar.dart';
import '../../../service_request/presentation/pages/service_request_page.dart';

class CompanyServicesPage extends StatelessWidget {
  final VoidCallback? onMenuTap;

  const CompanyServicesPage({super.key, this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTopBar(onMenuTap: onMenuTap),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Servicios',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkNavy,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ServiceRequestPage()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.add, color: Colors.white, size: 16),
                            SizedBox(width: 6),
                            Text(
                              'Nuevo',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Solicitudes ilimitadas | Prioridad en asignación.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.grayText,
                  ),
                ),
                const SizedBox(height: 20),
                _buildServiceCard(
                  serviceName: 'Mantenimiento Eléctrico General',
                  property: 'Sede Principal - San Isidro',
                  technician: 'Carlos Sánchez',
                  status: 'IN_PROGRESS',
                  statusLabel: 'En Progreso',
                  isPriority: true,
                  date: '18 Jun, 14:00',
                ),
                const SizedBox(height: 12),
                _buildServiceCard(
                  serviceName: 'Instalación IoT',
                  property: 'Sucursal Surco',
                  technician: 'María López',
                  status: 'ASSIGNED',
                  statusLabel: 'Asignado',
                  isPriority: false,
                  date: '20 Jun, 10:00',
                ),
                const SizedBox(height: 12),
                _buildServiceCard(
                  serviceName: 'Revisión de Cableado',
                  property: 'Sede Principal - San Isidro',
                  technician: 'Carlos Sánchez',
                  status: 'COMPLETED',
                  statusLabel: 'Completado',
                  isPriority: false,
                  date: '15 Jun, 16:30',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard({
    required String serviceName,
    required String property,
    required String technician,
    required String status,
    required String statusLabel,
    required bool isPriority,
    required String date,
  }) {
    Color statusColor;
    switch (status) {
      case 'IN_PROGRESS':
        statusColor = AppColors.primaryBlue;
        break;
      case 'ASSIGNED':
        statusColor = AppColors.accentYellow;
        break;
      case 'COMPLETED':
        statusColor = AppColors.green;
        break;
      default:
        statusColor = AppColors.grayText;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPriority ? AppColors.accentYellow : AppColors.lightGray,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  serviceName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkNavy,
                  ),
                ),
              ),
              if (isPriority)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.accentYellow,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Prioritario',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkNavy,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDetailRow(Icons.location_on_outlined, property),
          const SizedBox(height: 6),
          _buildDetailRow(Icons.person_outline, technician),
          const SizedBox(height: 6),
          _buildDetailRow(Icons.access_time, date),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: statusColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Ver detalle',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkNavy,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.grayText),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.grayText,
          ),
        ),
      ],
    );
  }
}
