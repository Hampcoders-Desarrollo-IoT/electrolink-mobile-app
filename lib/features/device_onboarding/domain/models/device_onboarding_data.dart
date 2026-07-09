class DeviceOnboardingRequest {
  final String deviceType;
  final double nominalVoltage;
  final double dailyUsageHours;
  final int occupants;
  final String locationType;
  final String primaryUse;

  const DeviceOnboardingRequest({
    required this.deviceType,
    required this.nominalVoltage,
    required this.dailyUsageHours,
    required this.occupants,
    required this.locationType,
    required this.primaryUse,
  });

  Map<String, dynamic> toJson() => {
    'deviceType': deviceType,
    'nominalVoltage': nominalVoltage,
    'dailyUsageHours': dailyUsageHours,
    'occupants': occupants,
    'locationType': locationType,
    'primaryUse': primaryUse,
  };
}

class SuggestedThresholds {
  final double nominalVoltage;
  final double maxConsumptionWatts;
  final double maxCurrentAmps;
  final double minPowerFactor;
  final double nominalFrequency;
  final int disconnectionThresholdMin;

  const SuggestedThresholds({
    required this.nominalVoltage,
    required this.maxConsumptionWatts,
    required this.maxCurrentAmps,
    required this.minPowerFactor,
    required this.nominalFrequency,
    required this.disconnectionThresholdMin,
  });

  factory SuggestedThresholds.fromJson(Map<String, dynamic> json) =>
      SuggestedThresholds(
        nominalVoltage: (json['nominalVoltage'] as num).toDouble(),
        maxConsumptionWatts: (json['maxConsumptionWatts'] as num).toDouble(),
        maxCurrentAmps: (json['maxCurrentAmps'] as num).toDouble(),
        minPowerFactor: (json['minPowerFactor'] as num).toDouble(),
        nominalFrequency: (json['nominalFrequency'] as num).toDouble(),
        disconnectionThresholdMin: json['disconnectionThresholdMin'] as int,
      );

  Map<String, dynamic> toThresholdsMap() => {
    'nominalVoltage': nominalVoltage,
    'maxConsumptionWatts': maxConsumptionWatts,
    'maxCurrentAmps': maxCurrentAmps,
    'minPowerFactor': minPowerFactor,
    'nominalFrequency': nominalFrequency,
    'disconnectionThresholdMin': disconnectionThresholdMin,
  };
}

class DeviceOnboardingAnalysis {
  final String reasoning;
  final SuggestedThresholds suggestedThresholds;

  const DeviceOnboardingAnalysis({
    required this.reasoning,
    required this.suggestedThresholds,
  });

  factory DeviceOnboardingAnalysis.fromJson(Map<String, dynamic> json) =>
      DeviceOnboardingAnalysis(
        reasoning: json['reasoning'] as String,
        suggestedThresholds:
            SuggestedThresholds.fromJson(json['suggestedThresholds'] as Map<String, dynamic>),
      );
}
