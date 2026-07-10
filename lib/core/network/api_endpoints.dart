class ApiEndpoints {
  //static const String baseUrl = 'http://127.0.0.1:8088'; <- Mac port for run flutter 
  static const String baseUrl = 'http://10.0.2.2:8088';  // <- Android Studio emulator port for run flutter

  static const String analyzeOnboarding =
      '/profiles/me/device-onboarding/analyze';

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
