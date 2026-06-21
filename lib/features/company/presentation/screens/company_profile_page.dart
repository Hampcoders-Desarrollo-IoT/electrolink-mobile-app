import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_top_bar.dart';
import '../../../subscription/presentation/pages/subscription_page.dart';

class CompanyProfilePage extends StatelessWidget {
  final VoidCallback? onMenuTap;

  const CompanyProfilePage({super.key, this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTopBar(onMenuTap: onMenuTap),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCompanyHeader(),
                const SizedBox(height: 24),
                _buildSectionTitle('Información Fiscal'),
                const SizedBox(height: 12),
                _buildCompanyInfoCard(),
                const SizedBox(height: 24),
                _buildSectionTitle('Representante Legal'),
                const SizedBox(height: 12),
                _buildRepresentativeCard(),
                const SizedBox(height: 24),
                _buildSectionTitle('Suscripción'),
                const SizedBox(height: 12),
                _buildSubscriptionCard(context),
                const SizedBox(height: 24),
                _buildSectionTitle('Preferencias'),
                const SizedBox(height: 12),
                _buildPreferencesCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyHeader() {
    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.brandLogoBg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.business, color: Colors.white, size: 32),
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TechCorp S.A.C.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkNavy,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'RUC: 20123456789',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.grayText,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.greenBg,
            borderRadius: BorderRadius.circular(9999),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, size: 10, color: AppColors.green),
              SizedBox(width: 4),
              Text(
                'Activo',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.green,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.darkNavy,
      ),
    );
  }

  Widget _buildCompanyInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGray),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow('Razón Social', 'TechCorp S.A.C.'),
          const Divider(height: 20, color: AppColors.lightGray),
          _buildInfoRow('RUC', '20123456789'),
          const Divider(height: 20, color: AppColors.lightGray),
          _buildInfoRow('Industria', 'Technology'),
          const Divider(height: 20, color: AppColors.lightGray),
          _buildInfoRow('Tamaño', 'Mediana'),
          const Divider(height: 20, color: AppColors.lightGray),
          _buildInfoRow('Sitio Web', 'techcorp.com'),
          const Divider(height: 20, color: AppColors.lightGray),
          _buildInfoRow('Dirección Fiscal', 'Av. Principal 456, San Isidro, Lima'),
        ],
      ),
    );
  }

  Widget _buildRepresentativeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGray),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow('Nombre', 'Carlos López'),
          const Divider(height: 20, color: AppColors.lightGray),
          _buildInfoRow('Teléfono', '+51 999 000 111'),
          const Divider(height: 20, color: AppColors.lightGray),
          _buildInfoRow('Email', 'admin@techcorp.com'),
          const Divider(height: 20, color: AppColors.lightGray),
          _buildInfoRow('DNI', '87654321'),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2E3A59),
            Color(0xFF182442),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.card_membership, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                'Enterprise Premium',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Monitoreo IoT ilimitado • Asignación prioritaria\nReportes avanzados • Soporte 24/7',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xCCFFFFFF),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SubscriptionPage()),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Gestionar Suscripción'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGray),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildPreferenceToggle('Notificaciones SMS', true),
          const Divider(height: 20, color: AppColors.lightGray),
          _buildPreferenceToggle('Notificaciones Email', true),
          const Divider(height: 20, color: AppColors.lightGray),
          _buildPreferenceToggle('Notificaciones Push', false),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.grayText,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.darkText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPreferenceToggle(String label, bool value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.darkText,
          ),
        ),
        Switch(
          value: value,
          activeThumbColor: AppColors.primaryBlue,
          onChanged: (_) {},
        ),
      ],
    );
  }
}
