import 'package:equatable/equatable.dart';

class SubscriptionData extends Equatable {
  final String planName;
  final double price;
  final String status;
  final List<String> features;
  final List<PaymentEntry> payments;

  const SubscriptionData({
    required this.planName,
    required this.price,
    required this.status,
    required this.features,
    required this.payments,
  });

  @override
  List<Object> get props => [planName, price, status, features, payments];
}

class PaymentEntry extends Equatable {
  final String date;
  final double amount;
  final String status;

  const PaymentEntry({
    required this.date,
    required this.amount,
    required this.status,
  });

  @override
  List<Object> get props => [date, amount, status];
}
