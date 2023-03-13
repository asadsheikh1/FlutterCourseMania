import 'dart:convert';

import 'package:equatable/equatable.dart';

PayloadModel payloadModelFromJson(String str) =>
    PayloadModel.fromJson(json.decode(str));

String payloadModelToJson(PayloadModel data) => json.encode(data.toJson());

class PayloadModel extends Equatable {
  final List<PlaylistModel> playlist;

  const PayloadModel({
    required this.playlist,
  });

  PayloadModel copyWith({
    List<PlaylistModel>? playlist,
  }) =>
      PayloadModel(
        playlist: playlist ?? this.playlist,
      );

  factory PayloadModel.fromJson(Map<String, dynamic> json) => PayloadModel(
        playlist: List<PlaylistModel>.from(
            json["payload"].map((x) => PlaylistModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payload": List<dynamic>.from(
          playlist.map((x) => x.toJson()),
        ),
      };

  @override
  List<Object?> get props => [playlist];
}

class PlaylistModel extends Equatable {
  final String cost;
  final dynamic fkCategoryId;
  final dynamic fkMerchantId;
  final dynamic fkUserId;
  final int isActive;
  final dynamic playlistDescription;
  final int playlistId;
  final dynamic playlistName;
  final dynamic thumbnail;
  final dynamic rating;

  const PlaylistModel({
    required this.cost,
    required this.fkCategoryId,
    required this.fkMerchantId,
    required this.fkUserId,
    required this.isActive,
    required this.playlistDescription,
    required this.playlistId,
    required this.playlistName,
    required this.thumbnail,
    required this.rating,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json) => PlaylistModel(
        cost: json["cost"],
        fkCategoryId: json["fk_category_id"],
        fkMerchantId: json["fk_merchant_id"],
        fkUserId: json["fk_user_id"],
        isActive: json["is_active"],
        playlistDescription: json["playlist_description"],
        playlistId: json["playlist_id"],
        playlistName: json["playlist_name"],
        thumbnail: json["thumbnail"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "cost": cost,
        "fk_category_id": fkCategoryId,
        "fk_merchant_id": fkMerchantId,
        "fk_user_id": fkUserId,
        "is_active": isActive,
        "playlist_description": playlistDescription,
        "playlist_id": playlistId,
        "playlist_name": playlistName,
        "thumbnail": thumbnail,
        "rating": rating,
      };

  @override
  List<Object?> get props => [
        cost,
        fkCategoryId,
        fkMerchantId,
        fkUserId,
        isActive,
        playlistDescription,
        playlistId,
        playlistName,
        thumbnail,
        rating,
      ];
}
