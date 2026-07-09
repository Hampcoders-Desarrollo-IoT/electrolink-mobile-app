import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/device_onboarding_data.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../widgets/analysis_loading_card.dart';

class Step2AnalysisPage extends StatelessWidget {
  final DeviceOnboardingRequest request;

  const Step2AnalysisPage({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepIndicator(1),
          const SizedBox(height: 16),
          const Text(
            'Análisis Inteligente',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Analizando configuración para ${_deviceLabel(request.deviceType)}...',
            style: const TextStyle(fontSize: 13, color: AppColors.grayText),
          ),
          const SizedBox(height: 24),
          const AnalysisLoadingCard(),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () =>
                    context.read<OnboardingBloc>().add(ResetOnboarding()),
                child: const Text('Cancelar'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _deviceLabel(String type) {
    switch (type) {
      case 'HVAC': return 'HVAC';
      case 'WaterHeater': return 'Calentador';
      case 'Refrigerator': return 'Refrigerador';
      case 'SolarInverter': return 'Inversor Solar';
      case 'EVCharger': return 'Cargador EV';
      default: return 'Dispositivo';
    }
  }

  Widget _buildStepIndicator(int currentStep) {
    return Row(
      children: List.generate(3, (i) {
        final isActive = i <= currentStep;
        final isLast = i == 2;
        return Expanded(
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.darkNavy
                      : const Color(0xFFE5E7EB),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isActive ? Colors.white : AppColors.grayText,
                    ),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    height: 2,
                    color: isActive
                        ? AppColors.darkNavy
                        : const Color(0xFFE5E7EB),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
