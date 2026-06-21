import '../../domain/models/subscription_data.dart';

class SubscriptionRepositoryImpl {
  Future<SubscriptionData> fetchSubscription() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const SubscriptionData(
      planName: 'Premium',
      price: 49.99,
      status: 'Activo',
      features: [
        'Acceso ilimitado a esquemas técnicos',
        'Soporte prioritario 24/7 para técnicos',
        'Integración con herramientas IoT de diagnóstico',
      ],
      payments: [
        PaymentEntry(date: '15 Oct, 2023', amount: 49.99, status: 'Pagado'),
        PaymentEntry(date: '15 Sep, 2023', amount: 49.99, status: 'Pagado'),
        PaymentEntry(date: '15 Ago, 2023', amount: 49.99, status: 'Pagado'),
      ],
    );
  }
}
