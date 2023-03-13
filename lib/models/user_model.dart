import 'dart:convert';

import 'package:equatable/equatable.dart';

PayloadModel payloadModelFromJson(String str) =>
    PayloadModel.fromJson(json.decode(str));

String payloadModelToJson(PayloadModel data) => json.encode(data.toJson());

class PayloadModel extends Equatable {
  final List<UserModel> user;

  const PayloadModel({
    required this.user,
  });

  PayloadModel copyWith({
    List<UserModel>? user,
  }) =>
      PayloadModel(
        user: user ?? this.user,
      );

  factory PayloadModel.fromJson(Map<String, dynamic> json) => PayloadModel(
        user: List<UserModel>.from(
            json["payload"].map((x) => UserModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payload": List<dynamic>.from(
          user.map((x) => x.toJson()),
        ),
      };

  @override
  List<Object?> get props => [user];
}

class UserModel extends Equatable {
  const UserModel({
    required this.avatar,
    required this.dob,
    required this.email,
    required this.fkRoleId,
    required this.isActive,
    required this.location,
    required this.phone,
    required this.subscriberCount,
    required this.userId,
    required this.userName,
    required this.userPassword,
  });

  final dynamic avatar;
  final dynamic dob;
  final String email;
  final dynamic fkRoleId;
  final int isActive;
  final dynamic location;
  final dynamic phone;
  final int subscriberCount;
  final int userId;
  final String userName;
  final String userPassword;

  UserModel copyWith({
    dynamic avatar,
    dynamic dob,
    String? email,
    dynamic fkRoleId,
    int? isActive,
    dynamic location,
    dynamic phone,
    int? subscriberCount,
    int? userId,
    String? userName,
    String? userPassword,
  }) =>
      UserModel(
        avatar: avatar ?? this.avatar,
        dob: dob ?? this.dob,
        email: email ?? this.email,
        fkRoleId: fkRoleId ?? this.fkRoleId,
        isActive: isActive ?? this.isActive,
        location: location ?? this.location,
        phone: phone ?? this.phone,
        subscriberCount: subscriberCount ?? this.subscriberCount,
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        userPassword: userPassword ?? this.userPassword,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        avatar: json["avatar"],
        dob: json["dob"],
        email: json["email"],
        fkRoleId: json["fk_role_id"],
        isActive: json["is_active"],
        location: json["location"],
        phone: json["phone"],
        subscriberCount: json["subscriber_count"],
        userId: json["user_id"],
        userName: json["user_name"],
        userPassword: json["user_password"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "dob": dob,
        "email": email,
        "fk_role_id": fkRoleId,
        "is_active": isActive,
        "location": location,
        "phone": phone,
        "subscriber_count": subscriberCount,
        "user_id": userId,
        "user_name": userName,
        "user_password": userPassword,
      };

  @override
  List<Object?> get props => [
        avatar,
        dob,
        email,
        fkRoleId,
        isActive,
        location,
        phone,
        subscriberCount,
        userId,
        userName,
        userPassword,
      ];
}
