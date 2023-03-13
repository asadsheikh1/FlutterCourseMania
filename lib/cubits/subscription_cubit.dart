import 'package:course_mania/models/subscription_model.dart';
import 'package:course_mania/services/subscription_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionCubit extends Cubit<List<SubscriptionModel>> {
  SubscriptionCubit() : super([]);

  final SubscriptionService _subscriptionService = SubscriptionService();

  void get subscription async =>
      emit(await _subscriptionService.getSubscription());
}
