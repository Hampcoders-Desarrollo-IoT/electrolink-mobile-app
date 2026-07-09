class ApiEndpoints {
  static const String baseUrl = 'http://10.0.2.2:8088/api/v1';

  static const String analyzeOnboarding =
      '/profiles/me/device-onboarding/analyze';

  static String thresholds(String profileId) =>
      '/profiles/$profileId/thresholds';
}
