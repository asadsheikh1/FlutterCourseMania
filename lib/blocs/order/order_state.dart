part of 'order_bloc.dart';

@immutable
abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderLoading extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderLoaded extends OrderState {
  final OrderModel order;

  const OrderLoaded({this.order = const OrderModel()});

  @override
  List<Object> get props => [order];
}

class OrderError extends OrderState {
  @override
  List<Object> get props => [];
}
