import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/device_onboarding_data.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../widgets/device_type_selector.dart';

class Step1DeviceInfoPage extends StatefulWidget {
  const Step1DeviceInfoPage({super.key});

  @override
  State<Step1DeviceInfoPage> createState() => _Step1DeviceInfoPageState();
}

class _Step1DeviceInfoPageState extends State<Step1DeviceInfoPage> {
  String? _deviceType;
  double _nominalVoltage = 220;
  double _dailyUsageHours = 8;
  int _occupants = 3;
  String _locationType = 'Residential';
  final _primaryUseController = TextEditingController();

  static const _voltageOptions = [110.0, 220.0, 380.0];
  static const _locationOptions = ['Residential', 'Commercial', 'Industrial'];

  @override
  void dispose() {
    _primaryUseController.dispose();
    super.dispose();
  }

  bool get _isValid =>
      _deviceType != null &&
      _primaryUseController.text.trim().isNotEmpty;

  void _submit() {
    if (!_isValid) return;

    final bloc = context.read<OnboardingBloc>();
    bloc.add(SubmitDeviceInfo(DeviceOnboardingRequest(
      deviceType: _deviceType!,
      nominalVoltage: _nominalVoltage,
      dailyUsageHours: _dailyUsageHours,
      occupants: _occupants,
      locationType: _locationType,
      primaryUse: _primaryUseController.text.trim(),
    )));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepIndicator(0),
          const SizedBox(height: 8),
          const Text(
            'Información del Dispositivo',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Selecciona el tipo de dispositivo que deseas configurar',
            style: TextStyle(fontSize: 13, color: AppColors.grayText),
          ),
          const SizedBox(height: 24),
          const Text(
            'Tipo de dispositivo',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 12),
          DeviceTypeSelector(
            selected: _deviceType,
            onSelected: (v) => setState(() => _deviceType = v),
          ),
          const SizedBox(height: 24),
          const Text(
            'Voltaje nominal',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: _voltageOptions.map((v) {
              final isSelected = _nominalVoltage == v;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: v == _voltageOptions.last ? 0 : 8,
                  ),
                  child: GestureDetector(
                    onTap: () => setState(() => _nominalVoltage = v),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.darkNavy : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.darkNavy
                              : const Color(0xFFE5E7EB),
                        ),
                      ),
                      child: Text(
                        '${v.toInt()}V',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color:
                              isSelected ? Colors.white : AppColors.darkText,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'Horas de uso diario',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: AppColors.darkNavy,
                    inactiveTrackColor: AppColors.darkNavy.withAlpha(25),
                    thumbColor: AppColors.darkNavy,
                    overlayColor: AppColors.darkNavy.withAlpha(20),
                    trackHeight: 4,
                  ),
                  child: Slider(
                    value: _dailyUsageHours,
                    min: 1,
                    max: 24,
                    divisions: 23,
                    label: '${_dailyUsageHours.toInt()} h',
                    onChanged: (v) =>
                        setState(() => _dailyUsageHours = v),
                  ),
                ),
              ),
              SizedBox(
                width: 48,
                child: Text(
                  '${_dailyUsageHours.toInt()}h',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkNavy,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Número de ocupantes',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: AppColors.darkNavy,
                    inactiveTrackColor: AppColors.darkNavy.withAlpha(25),
                    thumbColor: AppColors.darkNavy,
                    overlayColor: AppColors.darkNavy.withAlpha(20),
                    trackHeight: 4,
                  ),
                  child: Slider(
                    value: _occupants.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: '$_occupants',
                    onChanged: (v) =>
                        setState(() => _occupants = v.toInt()),
                  ),
                ),
              ),
              SizedBox(
                width: 36,
                child: Text(
                  '$_occupants',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkNavy,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Tipo de ubicación',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: _locationOptions.map((loc) {
              final isSelected = _locationType == loc;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: loc == _locationOptions.last ? 0 : 8,
                  ),
                  child: GestureDetector(
                    onTap: () => setState(() => _locationType = loc),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.darkNavy : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.darkNavy
                              : const Color(0xFFE5E7EB),
                        ),
                      ),
                      child: Text(
                        loc,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color:
                              isSelected ? Colors.white : AppColors.darkText,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'Uso principal',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _primaryUseController,
            decoration: InputDecoration(
              hintText: 'Ej: Climatización de sala principal',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isValid ? _submit : null,
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
              child: const Text(
                'Analizar con IA',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
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
