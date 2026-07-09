import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/auth/auth_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/device_onboarding_data.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../widgets/threshold_slider_card.dart';

class Step3ConfirmationPage extends StatelessWidget {
  final DeviceOnboardingAnalysis analysis;

  const Step3ConfirmationPage({super.key, required this.analysis});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final thresholds = analysis.suggestedThresholds;
        final isConfirming = state is OnboardingConfirming;
        final error = state is OnboardingConfirmError ? state.message : null;

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStepIndicator(2),
              const SizedBox(height: 8),
              const Text(
                'Confirmar Umbrales',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Revisa y ajusta los valores sugeridos por la IA',
                style: TextStyle(fontSize: 13, color: AppColors.grayText),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFCCD9FF)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.lightbulb_outline,
                        size: 20, color: AppColors.darkNavy),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        analysis.reasoning,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.darkText,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Umbrales sugeridos',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 12),
              ThresholdSliderCard(
                label: 'Voltaje nominal',
                unit: 'V',
                value: thresholds.nominalVoltage,
                min: 100,
                max: 400,
                divisions: 30,
                onChanged: (v) => context
                    .read<OnboardingBloc>()
                    .add(const AdjustThreshold('nominalVoltage', 220)),
              ),
              const SizedBox(height: 10),
              ThresholdSliderCard(
                label: 'Consumo máximo',
                unit: 'W',
                value: thresholds.maxConsumptionWatts,
                min: 500,
                max: 20000,
                divisions: 40,
                formatValue: (v) => '${v.toInt()}',
                onChanged: (v) => context
                    .read<OnboardingBloc>()
                    .add(AdjustThreshold('maxConsumptionWatts', v)),
              ),
              const SizedBox(height: 10),
              ThresholdSliderCard(
                label: 'Corriente máxima',
                unit: 'A',
                value: thresholds.maxCurrentAmps,
                min: 1,
                max: 100,
                divisions: 100,
                onChanged: (v) => context
                    .read<OnboardingBloc>()
                    .add(AdjustThreshold('maxCurrentAmps', v)),
              ),
              const SizedBox(height: 10),
              ThresholdSliderCard(
                label: 'Factor de potencia',
                unit: '',
                value: thresholds.minPowerFactor,
                min: 0.5,
                max: 1.0,
                divisions: 50,
                formatValue: (v) => v.toStringAsFixed(2),
                onChanged: (v) => context
                    .read<OnboardingBloc>()
                    .add(AdjustThreshold('minPowerFactor', v)),
              ),
              const SizedBox(height: 10),
              ThresholdSliderCard(
                label: 'Frecuencia nominal',
                unit: 'Hz',
                value: thresholds.nominalFrequency,
                min: 50,
                max: 60,
                divisions: 10,
                formatValue: (v) => '${v.toInt()}',
                onChanged: (v) => context
                    .read<OnboardingBloc>()
                    .add(AdjustThreshold('nominalFrequency', v)),
              ),
              const SizedBox(height: 10),
              ThresholdSliderCard(
                label: 'Desconexión por inactividad',
                unit: 'min',
                value: thresholds.disconnectionThresholdMin.toDouble(),
                min: 5,
                max: 60,
                divisions: 12,
                formatValue: (v) => '${v.toInt()}',
                onChanged: (v) => context
                    .read<OnboardingBloc>()
                    .add(AdjustThreshold('disconnectionThresholdMin', v.toInt())),
              ),
              if (error != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline,
                          size: 18, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          error,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isConfirming
                      ? null
                      : () {
                            final authState = context.read<AuthBloc>().state;
                            if (authState is AuthAuthenticated) {
                              context
                                  .read<OnboardingBloc>()
                                  .add(ConfirmThresholds(authState.profileId));
                            }
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkNavy,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xFFE5E7EB),
                    disabledForegroundColor: AppColors.grayText,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isConfirming
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Confirmar y Guardar',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: isConfirming
                      ? null
                      : () => context
                          .read<OnboardingBloc>()
                          .add(ResetOnboarding()),
                  child: const Text('Volver al inicio'),
                ),
              ),
            ],
          ),
        );
      },
    );
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
