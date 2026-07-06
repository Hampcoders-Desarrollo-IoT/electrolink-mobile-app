
import 'package:flutter/material.dart';

import '../../../../core/widgets/app_top_bar.dart';

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
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Servicios',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    FloatingActionButton.small(
                      onPressed: () {},
                      backgroundColor: Colors.black,
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Servicios Activos',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                _buildActiveServiceCard(
                    'Falla del Compresor HVAC', 'Sector 4, Edificio Principal'),
                const SizedBox(height: 16),
                _buildScheduledServiceCard(
                    'Calibración Trimestral de Medidores', 'Todas las Zonas'),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Historial de Servicios',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    TextButton(onPressed: () {}, child: const Text('Ver Todo')),
                  ],
                ),
                _buildHistoryItem(
                    'Instalación de Termostato Inteligente', 'Completado'),
                _buildHistoryItem(
                    'Auditoría de Energía de Emergencia', 'Completado'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActiveServiceCard(String title, String location) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                // Flexible para prevenir desbordamiento en el título largo
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                const Text('En Progreso'),
              ],
            ),
            const SizedBox(height: 8),
            Text(location),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Asignado'),
                Text('En Tránsito'),
                Text('Trabajando'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildScheduledServiceCard(String title, String location) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                // Flexible para prevenir desbordamiento
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                const Text('Programado'),
              ],
            ),
            const SizedBox(height: 8),
            Text(location),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Asignado'),
                Text('En Tránsito'),
                Text('Trabajando'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(String title, String status) {
    return ListTile(
      title: Text(title),
      subtitle: Text(status),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}