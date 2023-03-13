import 'package:bloc/bloc.dart';
import 'package:course_mania/models/order_model.dart';
import 'package:course_mania/models/playlist_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'order_state.dart';
part 'order_event.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderLoading());

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    try {
      if (event is OrderStarted) {
        yield* _mapOrderStartedEventToState();
      } else if (event is OrderProductAdded) {
        yield* _mapOrderProductAddedEventToState(event, state);
      } else if (event is OrderProductRemoved) {
        yield* _mapOrderProductRemovedEventToState(event, state);
      }
    } catch (_) {}
  }

  Stream<OrderState> _mapOrderStartedEventToState() async* {
    yield OrderLoading();
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      yield const OrderLoaded();
    } catch (_) {}
  }

  Stream<OrderState> _mapOrderProductAddedEventToState(
      OrderProductAdded event, OrderState state) async* {
    if (state is OrderLoaded) {
      yield OrderLoaded(
        order: OrderModel(
          playlists: List.from(state.order.playlists)..add(event.playlist),
        ),
      );
    }
  }

  Stream<OrderState> _mapOrderProductRemovedEventToState(
      OrderProductRemoved event, OrderState state) async* {
    if (state is OrderLoaded) {
      yield OrderLoaded(
        order: OrderModel(
          playlists: List.from(state.order.playlists)..remove(event.playlist),
        ),
      );
    }
  }
}
