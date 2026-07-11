import 'package:flutter/material.dart';
import 'package:mobile_app_electrolink/core/theme/app_theme.dart';
import 'package:mobile_app_electrolink/core/network/api_client.dart';
import 'package:mobile_app_electrolink/core/network/api_endpoints.dart';
import 'package:mobile_app_electrolink/features/device_onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:mobile_app_electrolink/features/device_onboarding/presentation/pages/onboarding_wizard_page.dart';

class CompanyIotPage extends StatelessWidget {
  final VoidCallback? onMenuTap;

  const CompanyIotPage({super.key, this.onMenuTap});

  void _openOnboarding(BuildContext context) {
    final client = ApiClient(baseUrl: ApiEndpoints.baseUrl);
    final repo = OnboardingRepositoryImpl(client);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OnboardingWizardPage(repository: repo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                _buildSensorNodesSection(context),
                const SizedBox(height: 24),
                _buildPowerDrawCard(),
                const SizedBox(height: 24),
                _buildRelayControlCard(),
                const SizedBox(height: 24),
                _buildCircuitBreakdownCard(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: AppColors.appBarBg,
        border: Border(bottom: BorderSide(color: AppColors.borderLight)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: onMenuTap,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.menu, size: 18, color: AppColors.darkNavy),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'IoT Monitoring',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.darkNavy,
            ),
          ),
          const Spacer(),
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: AppColors.lightGray,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.notifications_none,
                size: 16, color: AppColors.darkNavy),
          ),
          const SizedBox(width: 12),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.profileBg,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.borderLight),
            ),
            child: const Icon(Icons.person, size: 18, color: AppColors.darkNavy),
          ),
        ],
      ),
    );
  }

  Widget _buildSensorNodesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'ACTIVE SENSOR NODES',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.grayText,
                letterSpacing: 0.6,
              ),
            ),
            GestureDetector(
              onTap: () => _openOnboarding(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.darkNavy,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, size: 14, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'Añadir dispositivo',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 70,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildSensorNode('Node A-1', 'Online', true),
              const SizedBox(width: 12),
              _buildSensorNode('Node B-2', 'Online', true),
              const SizedBox(width: 12),
              _buildSensorNode('Node C-3', 'Offline', false),
              const SizedBox(width: 12),
              _buildSensorNode('Node D-4', 'Online', true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSensorNode(String name, String status, bool isOnline) {
    final dotColor = isOnline ? const Color(0xFF006C49) : const Color(0xFF76777D);
    return Container(
      padding: const EdgeInsets.fromLTRB(13, 13, 24, 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (isOnline)
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: dotColor.withAlpha(51),
                      shape: BoxShape.circle,
                    ),
                  ),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: dotColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPowerDrawCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'FACILITY POWER DRAW',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.grayText,
                  letterSpacing: 0.6,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F4F6),
                  border: Border.all(color: AppColors.borderLight),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Live',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.grayText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              const Text(
                '428',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: -0.96,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'kW',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: AppColors.grayText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              SizedBox(
                width: 12,
                height: 8,
                child: CustomPaint(
                  painter: _TrendUpPainter(),
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                '+3.2% vs last hour',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF006C49),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 192,
            child: CustomPaint(
              painter: _ChartCurvePainter(),
            ),
          ),
          const SizedBox(height: 24),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('10:00', style: TextStyle(fontSize: 12, color: Color(0xFF76777D))),
              Text('10:15', style: TextStyle(fontSize: 12, color: Color(0xFF76777D))),
              Text('10:30', style: TextStyle(fontSize: 12, color: Color(0xFF76777D))),
              Text('10:45', style: TextStyle(fontSize: 12, color: Color(0xFF76777D))),
              Text('Now', style: TextStyle(fontSize: 12, color: Color(0xFF76777D))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRelayControlCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RELAY CONTROL',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.grayText,
                  letterSpacing: 0.6,
                ),
              ),
              Icon(Icons.bolt, size: 18, color: AppColors.grayText),
            ],
          ),
          const SizedBox(height: 24),
          _buildRelayRow('HVAC Main', 'Zone A', true),
          const SizedBox(height: 16),
          _buildRelayRow('Lighting Grid', 'Zone B', true),
          const SizedBox(height: 16),
          _buildRelayRow('Server Rack 1', 'Critical', false),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBA1A1A),
                foregroundColor: Colors.white,
                elevation: 0,
                shadowColor: const Color(0xFFBA1A1A).withAlpha(51),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning_amber_rounded, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'SAFETY OVERRIDE',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelayRow(String title, String subtitle, bool isSwitchedOn) {
    final isCritical = subtitle == 'Critical';
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: isCritical ? const Color(0xFFBA1A1A) : AppColors.grayText,
                ),
              ),
            ],
          ),
          _buildCustomSwitch(isSwitchedOn),
        ],
      ),
    );
  }

  Widget _buildCustomSwitch(bool value) {
    return Container(
      width: 44,
      height: 24,
      decoration: BoxDecoration(
        color: value ? AppColors.darkNavy : AppColors.darkNavy.withAlpha(128),
        borderRadius: BorderRadius.circular(9999),
      ),
      padding: const EdgeInsets.all(2),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 200),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildCircuitBreakdownCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 17),
            decoration: const BoxDecoration(
              color: Color(0xFFF7F9FB),
              border: Border(
                bottom: BorderSide(color: AppColors.borderLight),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'CIRCUIT BREAKDOWN',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.grayText,
                    letterSpacing: 0.6,
                  ),
                ),
                const Icon(Icons.filter_list, size: 16, color: AppColors.grayText),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.borderLight),
              ),
            ),
            child: const Row(
              children: [
                Expanded(flex: 3, child: _TableHeader('CIRCUIT\nNAME')),
                Expanded(flex: 2, child: _TableHeader('STATUS')),
                Expanded(flex: 2, child: _TableHeaderRight('CURRENT\n(A)')),
                Expanded(flex: 2, child: _TableHeaderRight('VOLTAGE\n(V)')),
              ],
            ),
          ),
          _buildCircuitRow('Main Feed -', 'Floor 1', 'Live', '124.5', '240', const Color(0xFF006C49)),
          _buildDivider(),
          _buildCircuitRow('Main Feed -', 'Floor 2', 'Live', '98.2', '239', const Color(0xFF006C49)),
          _buildDivider(),
          _buildCircuitRow('Aux', 'Generator C', 'Fault', '--', '--', const Color(0xFFBA1A1A)),
          _buildDivider(),
          _buildCircuitRow('Maintenance', 'Bay', 'Off', '0.0', '0', const Color(0xFF76777D)),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: AppColors.borderLight.withAlpha(77),
    );
  }

  Widget _buildCircuitRow(String line1, String line2, String status, String current, String voltage, Color statusColor) {
    final isFault = status == 'Fault';
    final isOff = status == 'Off';
    final textColor = isFault ? const Color(0xFFBA1A1A) : (isOff ? const Color(0xFF76777D) : Colors.black);
    final valueColor = isFault ? const Color(0xFFBA1A1A) : (isOff ? const Color(0xFF76777D) : Colors.black);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    line1,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  Text(
                    line2,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              current,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'monospace',
                color: valueColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              voltage,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'monospace',
                color: valueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  final String text;
  const _TableHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFF76777D),
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _TableHeaderRight extends StatelessWidget {
  final String text;
  const _TableHeaderRight(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        textAlign: TextAlign.right,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFF76777D),
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _TrendUpPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF006C49)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width, size.height);
    path.lineTo(size.width * 0.6, size.height * 0.3);
    path.lineTo(size.width * 0.35, size.height * 0.6);
    path.lineTo(size.width * 0.1, size.height * 0.15);
    path.moveTo(size.width * 0.1, size.height * 0.15);
    canvas.drawPath(path, paint);

    canvas.drawLine(
      Offset(size.width * 0.1 - 3, size.height * 0.15 + 3),
      Offset(size.width * 0.1, size.height * 0.15),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ChartCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.borderLight.withAlpha(77)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 0; i < 4; i++) {
      double y = size.height * (i / 3);
      final dashPath = Path();
      dashPath.moveTo(0, y);
      dashPath.lineTo(size.width, y);
      canvas.drawPath(dashPath, gridPaint);
    }

    final path = Path();
    path.moveTo(0, size.height * 0.6);
    path.cubicTo(
      size.width * 0.15, size.height * 0.5,
      size.width * 0.25, size.height * 0.8,
      size.width * 0.4, size.height * 0.5,
    );
    path.cubicTo(
      size.width * 0.5, size.height * 0.2,
      size.width * 0.65, size.height * 1.1,
      size.width * 0.8, size.height * 0.2,
    );
    path.lineTo(size.width, size.height * 0.6);

    final linePaint = Paint()
      ..color = const Color(0xFF1F2937)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, linePaint);

    final dotPaint = Paint()..color = const Color(0xFF1F2937);
    final ringPaint = Paint()
      ..color = const Color(0xFFBA1A1A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final targetPoint = Offset(size.width * 0.76, size.height * 0.32);
    canvas.drawCircle(targetPoint, 4, dotPaint);
    canvas.drawCircle(targetPoint, 8, ringPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
