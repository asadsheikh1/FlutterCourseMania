import 'package:course_mania/models/playlist_model.dart';
import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final List<PlaylistModel> playlists;

  const OrderModel({this.playlists = const <PlaylistModel>[]});

  double deliveryFee(subTotal) {
    if (subTotal == 0 || subTotal >= 30) {
      return 0.0;
    } else {
      return 2.0;
    }
  }

  double total(subTotal, deliveryFee) {
    return subTotal + deliveryFee(subTotal);
  }

  String freeDelivery(subTotal) {
    if (subTotal >= 30) {
      return 'You have FREE delivery.';
    } else {
      double missing = 30.0 - subTotal;
      return 'Add \$${missing.toStringAsFixed(2)} for free delivery.';
    }
  }

  Map productQuantity(playlists) {
    var quantity = {};

    playlists.forEach((product) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product] += 1;
      }
    });

    return quantity;
  }

  double get subTotal =>
      playlists.fold(0, (total, current) => total + double.parse(current.cost));

  String get subTotalString => subTotal.toStringAsFixed(2);

  String get freeDeliveryString => freeDelivery(subTotal);

  String get totalString => total(subTotal, deliveryFee).toStringAsFixed(2);

  String get deliveryFeeString => deliveryFee(subTotal).toStringAsFixed(2);

  @override
  List<Object?> get props => [playlists];
}
