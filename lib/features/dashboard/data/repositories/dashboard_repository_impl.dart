import 'package:mobile_app_electrolink/core/network/api_client.dart';
import 'package:mobile_app_electrolink/core/network/api_endpoints.dart';
import '../../domain/models/dashboard_data.dart';
import '../../domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final ApiClient _client;

  DashboardRepositoryImpl(this._client);

  @override
  Future<DashboardData> getDashboardData() async {
    Map<String, dynamic>? subscriptionJson;
    Map<String, dynamic>? profileJson;

    try {
      final subResponse = await _client.get(ApiEndpoints.mySubscription);
      subscriptionJson = subResponse.data as Map<String, dynamic>?;
    } catch (_) {}

    try {
      final profResponse = await _client.get(ApiEndpoints.myProfile);
      profileJson = profResponse.data as Map<String, dynamic>?;
    } catch (_) {}

    return DashboardData.fromApi(
      subscriptionJson: subscriptionJson,
      profileJson: profileJson,
    );
  }
}
