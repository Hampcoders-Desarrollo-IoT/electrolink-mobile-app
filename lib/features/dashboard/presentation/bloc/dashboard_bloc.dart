import 'package:mobile_app_electrolink/core/network/api_client.dart';
import 'package:mobile_app_electrolink/core/network/api_endpoints.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/repositories/dashboard_repository.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository _repository;

  DashboardBloc({DashboardRepository? repository, ApiClient? client})
      : _repository = repository ??
            DashboardRepositoryImpl(
                client ?? ApiClient(baseUrl: ApiEndpoints.baseUrl)),
        super(DashboardInitial()) {
    on<FetchDashboard>(_onFetchDashboard);
  }

  Future<void> _onFetchDashboard(
    FetchDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    try {
      final data = await _repository.getDashboardData();
      emit(DashboardLoaded(data: data));
    } catch (e) {
      emit(DashboardError(message: e.toString()));
    }
  }
}
