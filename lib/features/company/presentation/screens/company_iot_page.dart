// lib/features/company/presentation/screens/company_iot_page.dart

import 'package:flutter/material.dart';

import '../../../../core/widgets/app_top_bar.dart';

class CompanyIotPage extends StatelessWidget {
  final VoidCallback? onMenuTap;

  const CompanyIotPage({super.key, this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTopBar(onMenuTap: onMenuTap),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. ACTIVE SENSOR NODES
                const Text(
                  'ACTIVE SENSOR NODES',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                _buildSensorNodesRow(),
                const SizedBox(height: 20),

                // 2. FACILITY POWER DRAW (Gráfica)
                _buildPowerDrawCard(),
                const SizedBox(height: 20),

                // 3. RELAY CONTROL
                _buildRelayControlCard(),
                const SizedBox(height: 20),

                // 4. CIRCUIT BREAKDOWN
                _buildCircuitBreakdownCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Nodos de sensores horizontales superiores
  Widget _buildSensorNodesRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildSensorNode('Node A-1', 'Online', true),
          const SizedBox(width: 12),
          _buildSensorNode('Node B-2', 'Online', true),
          const SizedBox(width: 12),
          _buildSensorNode('Node C-3', 'Offline', false),
        ],
      ),
    );
  }

  Widget _buildSensorNode(String name, String status, bool isOnline) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            size: 10,
            color: isOnline ? const Color(0xFF10B981) : Colors.grey,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                status,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Tarjeta de consumo con gráfico de onda sinusoidal idéntico al mockup
  Widget _buildPowerDrawCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'FACILITY POWER DRAW',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Live',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // CORRECCIÓN AQUÍ: Se usa crossAxisAlignment y textBaseline correctamente
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              const Text(
                '428',
                style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: Colors.black, letterSpacing: -1),
              ),
              const SizedBox(width: 4),
              Text('kW', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
            ],
          ),
          const SizedBox(height: 4),
          const Row(
            children: [
              Icon(Icons.trending_up, color: Color(0xFF10B981), size: 14),
              SizedBox(width: 4),
              Text(
                '+3.2% vs last hour',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF10B981)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Pintor personalizado para la línea curva exacta del Mockup
          SizedBox(
            width: double.infinity,
            height: 120,
            child: CustomPaint(
              painter: _ChartCurvePainter(),
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('10:00', style: TextStyle(fontSize: 11, color: Colors.grey)),
              Text('10:15', style: TextStyle(fontSize: 11, color: Colors.grey)),
              Text('10:30', style: TextStyle(fontSize: 11, color: Colors.grey)),
              Text('10:45', style: TextStyle(fontSize: 11, color: Colors.grey)),
              Text('Now', style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  // Tarjeta de Relay Control con interruptores (Switches)
  Widget _buildRelayControlCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RELAY CONTROL',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              Icon(Icons.bolt, size: 18, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 16),
          _buildRelayRow('HVAC Main', 'Zone A', true, false),
          const SizedBox(height: 12),
          _buildRelayRow('Lighting Grid', 'Zone B', true, false),
          const SizedBox(height: 12),
          _buildRelayRow('Server Rack 1', 'Critical', false, true),
          const SizedBox(height: 16),
          // Botón de emergencia Rojo "SAFETY OVERRIDE"
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBC1A1A),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              icon: const Icon(Icons.warning_amber_rounded, size: 18),
              label: const Text(
                'SAFETY OVERRIDE',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelayRow(String title, String subtitle, bool isSwitchedOn, bool isCritical) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: isCritical ? const Color(0xFFBC1A1A) : Colors.grey[600],
                  fontWeight: isCritical ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
          Switch.adaptive(
            value: isSwitchedOn,
            activeColor: const Color(0xFF111827),
            onChanged: (val) {},
          ),
        ],
      ),
    );
  }

  // Tabla inferior de desglose de circuitos "CIRCUIT BREAKDOWN"
  Widget _buildCircuitBreakdownCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'CIRCUIT BREAKDOWN',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                Icon(Icons.filter_list, size: 16, color: Colors.grey),
              ],
            ),
          ),
          // Encabezados de Tabla
          Container(
            color: const Color(0xFFF9FAFB),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: const Row(
              children: [
                Expanded(flex: 3, child: Text('CIRCUIT NAME', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('STATUS', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('CURRENT (A)', style: TextStyle(fontSize: 10, color: Colors.grey, decoration: TextDecoration.none, fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
                Expanded(flex: 2, child: Text('VOLTAGE (V)', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
              ],
            ),
          ),
          // Filas de la Tabla
          _buildCircuitRow('Main Feed - Floor 1', 'Live', '124.5', '240', const Color(0xFF10B981)),
          const Divider(height: 1, color: Color(0xFFE5E7EB)),
          _buildCircuitRow('Main Feed - Floor 2', 'Live', '98.2', '239', const Color(0xFF10B981)),
          const Divider(height: 1, color: Color(0xFFE5E7EB)),
          _buildCircuitRow('Aux Generator C', 'Fault', '--', '--', const Color(0xFFBC1A1A)),
          const Divider(height: 1, color: Color(0xFFE5E7EB)),
          _buildCircuitRow('Maintenance Bay', 'Off', '0.0', '0', Colors.grey),
        ],
      ),
    );
  }

  Widget _buildCircuitRow(String name, String status, String current, String voltage, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Text(
                  name,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: status == 'Fault' ? const Color(0xFFBC1A1A) : Colors.black
                  )
              )
          ),
          Expanded(
              flex: 2,
              child: Row(
                children: [
                  Icon(Icons.circle, size: 8, color: statusColor),
                  const SizedBox(width: 6),
                  Text(status, style: TextStyle(fontSize: 13, color: statusColor, fontWeight: FontWeight.w500)),
                ],
              )
          ),
          Expanded(flex: 2, child: Text(current, style: const TextStyle(fontSize: 13, color: Colors.black), textAlign: TextAlign.right)),
          Expanded(flex: 2, child: Text(voltage, style: const TextStyle(fontSize: 13, color: Colors.black), textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}

// Pintor de la línea del gráfico y retícula de fondo punteada
class _ChartCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Dibujar líneas guía horizontales punteadas
    for (int i = 1; i <= 3; i++) {
      double y = size.height * (i / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final path = Path();
    // Puntos de anclaje para generar la curva idéntica de la imagen original
    path.moveTo(0, size.height * 0.6);
    path.cubicTo(size.width * 0.15, size.height * 0.5, size.width * 0.25, size.height * 0.8, size.width * 0.4, size.height * 0.5);
    path.cubicTo(size.width * 0.5, size.height * 0.2, size.width * 0.65, size.height * 1.1, size.width * 0.8, size.height * 0.2);
    path.lineTo(size.width, size.height * 0.6);

    final linePaint = Paint()
      ..color = const Color(0xFF1F2937) // Azul oscuro / negro de la línea de tendencia
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, linePaint);

    // Indicador del punto rojo crítico de selección en el pico de la gráfica
    final dotPaint = Paint()..color = const Color(0xFF1F2937);
    final ringPaint = Paint()
      ..color = const Color(0xFFBC1A1A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Offset targetPoint = Offset(size.width * 0.76, size.height * 0.32);
    canvas.drawCircle(targetPoint, 4, dotPaint);
    canvas.drawCircle(targetPoint, 8, ringPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}