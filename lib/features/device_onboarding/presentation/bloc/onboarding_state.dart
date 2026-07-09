import 'package:equatable/equatable.dart';
import '../../domain/models/device_onboarding_data.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingStep1DeviceInfo extends OnboardingState {}

class OnboardingStep2Analyzing extends OnboardingState {
  final DeviceOnboardingRequest request;

  const OnboardingStep2Analyzing(this.request);

  @override
  List<Object?> get props => [request];
}

class OnboardingStep3Confirmation extends OnboardingState {
  final DeviceOnboardingAnalysis analysis;

  const OnboardingStep3Confirmation(this.analysis);

  @override
  List<Object?> get props => [analysis];
}

class OnboardingCompleted extends OnboardingState {
  final String message;

  const OnboardingCompleted(this.message);

  @override
  List<Object?> get props => [message];
}

class OnboardingError extends OnboardingState {
  final String message;

  const OnboardingError(this.message);

  @override
  List<Object?> get props => [message];
}

class OnboardingConfirming extends OnboardingState {
  final DeviceOnboardingAnalysis analysis;

  const OnboardingConfirming(this.analysis);

  @override
  List<Object?> get props => [analysis];
}

class OnboardingConfirmError extends OnboardingState {
  final DeviceOnboardingAnalysis analysis;
  final String message;

  const OnboardingConfirmError(this.analysis, this.message);

  @override
  List<Object?> get props => [analysis, message];
}
