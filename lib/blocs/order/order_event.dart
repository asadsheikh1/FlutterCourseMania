part of 'order_bloc.dart';

@immutable
abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderStarted extends OrderEvent {
  @override
  List<Object> get props => [];
}

class OrderProductAdded extends OrderEvent {
  final PlaylistModel playlist;

  const OrderProductAdded(this.playlist);

  @override
  List<Object> get props => [playlist];
}

class OrderProductRemoved extends OrderEvent {
  final PlaylistModel playlist;

  const OrderProductRemoved(this.playlist);

  @override
  List<Object> get props => [playlist];
}
