class ApiEndpoints {
  static const String baseUrl = 'http://10.0.2.2:8088/api/v1';

  static const String analyzeOnboarding =
      '/profiles/me/device-onboarding/analyze';
  static const String adjustOnboarding =
      '/profiles/me/device-onboarding/adjust';

  static String thresholds(String profileId) =>
      '/profiles/$profileId/thresholds';

  static const String completeHomeowner = '/profiles/me/complete/homeowner';

  static const String myProfile = '/profiles/me';
  static const String mySubscription = '/subscriptions/me';
  static const String myPaymentHistory = '/subscriptions/me/payment-history';
  static const String checkout = '/subscriptions/checkout';
  static const String cancelSubscription = '/subscriptions/me/cancel';
  static const String customerPortal = '/subscriptions/me/portal';
}
