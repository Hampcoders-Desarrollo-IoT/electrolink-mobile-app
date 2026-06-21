import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/subscription_repository_impl.dart';
import 'subscription_event.dart';
import 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepositoryImpl _repository;

  SubscriptionBloc({SubscriptionRepositoryImpl? repository})
      : _repository = repository ?? SubscriptionRepositoryImpl(),
        super(const SubscriptionInitial()) {
    on<FetchSubscription>(_onFetch);
  }

  Future<void> _onFetch(
      FetchSubscription event, Emitter<SubscriptionState> emit) async {
    emit(const SubscriptionLoading());
    try {
      final data = await _repository.fetchSubscription();
      emit(SubscriptionLoaded(data));
    } catch (e) {
      emit(SubscriptionError(e.toString()));
    }
  }
}
