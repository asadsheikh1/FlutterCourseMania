import 'dart:convert';

import 'package:equatable/equatable.dart';

PayloadModel payloadModelFromJson(String str) =>
    PayloadModel.fromJson(json.decode(str));

String payloadModelToJson(PayloadModel data) => json.encode(data.toJson());

class PayloadModel extends Equatable {
  final List<SubscriptionModel> subscriptions;

  const PayloadModel({
    required this.subscriptions,
  });

  PayloadModel copyWith({
    List<SubscriptionModel>? subscriptions,
  }) =>
      PayloadModel(
        subscriptions: subscriptions ?? this.subscriptions,
      );

  factory PayloadModel.fromJson(Map<String, dynamic> json) => PayloadModel(
        subscriptions: List<SubscriptionModel>.from(
            json["payload"].map((x) => SubscriptionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payload": List<dynamic>.from(
          subscriptions.map((x) => x.toJson()),
        ),
      };

  @override
  List<Object?> get props => [subscriptions];
}

class SubscriptionModel extends Equatable {
  final dynamic fkPlaylistId;
  final dynamic fkUserId;
  final dynamic isActive;

  const SubscriptionModel({
    required this.fkPlaylistId,
    required this.fkUserId,
    required this.isActive,
  });

  SubscriptionModel copyWith({
    dynamic fkPlaylistId,
    dynamic fkUserId,
    dynamic isActive,
    dynamic subscribeId,
  }) =>
      SubscriptionModel(
        fkPlaylistId: fkPlaylistId ?? this.fkPlaylistId,
        fkUserId: fkUserId ?? this.fkUserId,
        isActive: isActive ?? this.isActive,
      );

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionModel(
        fkPlaylistId: json["fk_playlist_id"],
        fkUserId: json["fk_user_id"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "fk_playlist_id": fkPlaylistId,
        "fk_user_id": fkUserId,
        "is_active": isActive,
      };

  @override
  List<Object?> get props => [
        fkPlaylistId,
        fkUserId,
        isActive,
      ];
}
