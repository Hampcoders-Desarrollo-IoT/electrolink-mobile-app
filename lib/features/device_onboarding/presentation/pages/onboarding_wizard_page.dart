import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import 'step1_device_info_page.dart';
import 'step2_analysis_page.dart';
import 'step3_confirmation_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingWizardPage extends StatelessWidget {
  final OnboardingRepository repository;

  const OnboardingWizardPage({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(repository),
      child: const _OnboardingWizardShell(),
    );
  }
}

class _OnboardingWizardShell extends StatelessWidget {
  const _OnboardingWizardShell();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Añadir Dispositivo'),
            backgroundColor: Colors.white,
            foregroundColor: AppColors.darkNavy,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, OnboardingState state) {
    if (state is OnboardingInitial || state is OnboardingStep1DeviceInfo) {
      return Step1DeviceInfoPage();
    }
    if (state is OnboardingStep2Analyzing) {
      return Step2AnalysisPage(request: state.request);
    }
    if (state is OnboardingStep3Confirmation || state is OnboardingConfirming || state is OnboardingConfirmError) {
      final analysis = state is OnboardingStep3Confirmation
          ? state.analysis
          : state is OnboardingConfirming
              ? (state as OnboardingConfirming).analysis
              : (state as OnboardingConfirmError).analysis;
      return Step3ConfirmationPage(analysis: analysis);
    }
    if (state is OnboardingCompleted) {
      return _CompletionPage(message: state.message);
    }
    if (state is OnboardingError) {
      return _ErrorPage(
        message: state.message,
        onRetry: () => context.read<OnboardingBloc>().add(ResetOnboarding()),
      );
    }
    return const SizedBox();
  }
}

class _CompletionPage extends StatelessWidget {
  final String message;

  const _CompletionPage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 64, color: Colors.green),
            const SizedBox(height: 24),
            const Text(
              '¡Dispositivo Configurado!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: const TextStyle(fontSize: 14, color: AppColors.grayText),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkNavy,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Finalizar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorPage extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorPage({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 24),
            Text(
              message,
              style: const TextStyle(fontSize: 14, color: AppColors.grayText),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkNavy,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
