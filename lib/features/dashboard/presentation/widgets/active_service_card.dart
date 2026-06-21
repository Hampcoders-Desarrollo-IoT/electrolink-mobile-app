import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/dashboard_data.dart';

class ActiveServiceCard extends StatelessWidget {
  final ActiveService service;

  const ActiveServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [AppColors.darkNavy, AppColors.primaryBlue],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.yellowBg,
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(color: AppColors.yellowBorder),
                    ),
                    child: const Text(
                      'In Progress',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.accentYellow,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Mantenimiento de\nTablero',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 13, color: AppColors.lightBlueText),
                      const SizedBox(width: 4),
                      Text(
                        service.location,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.lightBlueText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Icon(Icons.electrical_services,
                  size: 30, color: Colors.white),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(color: Color(0x1AFFFFFF), height: 1),
          const SizedBox(height: 9),
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFBDDEFE),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    service.technicianInitials,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF43627E),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Assigned Technician',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.lightBlueText,
                    ),
                  ),
                  Text(
                    service.technicianName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.14,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'View Details',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkNavy,
                    letterSpacing: 0.14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
