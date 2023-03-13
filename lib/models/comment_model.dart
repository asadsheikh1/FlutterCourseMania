import 'dart:convert';

import 'package:equatable/equatable.dart';

PayloadModel payloadModelFromJson(String str) =>
    PayloadModel.fromJson(json.decode(str));

String payloadModelToJson(PayloadModel data) => json.encode(data.toJson());

class PayloadModel extends Equatable {
  final List<CommentModel> comments;

  const PayloadModel({
    required this.comments,
  });

  PayloadModel copyWith({
    List<CommentModel>? comments,
  }) =>
      PayloadModel(
        comments: comments ?? this.comments,
      );

  factory PayloadModel.fromJson(Map<String, dynamic> json) => PayloadModel(
        comments: List<CommentModel>.from(
            json["payload"].map((x) => CommentModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payload": List<dynamic>.from(
          comments.map((x) => x.toJson()),
        ),
      };

  @override
  List<Object?> get props => [comments];
}

class CommentModel extends Equatable {
  final String addedDatetime;
  final String commentDescription;
  final int commentId;
  final int fkUserId;
  final int fkVideoId;
  final int isActive;

  const CommentModel({
    required this.addedDatetime,
    required this.commentDescription,
    required this.commentId,
    required this.fkUserId,
    required this.fkVideoId,
    required this.isActive,
  });

  CommentModel copyWith({
    String? addedDatetime,
    String? commentDescription,
    int? commentId,
    int? fkUserId,
    int? fkVideoId,
    int? isActive,
  }) =>
      CommentModel(
        addedDatetime: addedDatetime ?? this.addedDatetime,
        commentDescription: commentDescription ?? this.commentDescription,
        commentId: commentId ?? this.commentId,
        fkUserId: fkUserId ?? this.fkUserId,
        fkVideoId: fkVideoId ?? this.fkVideoId,
        isActive: isActive ?? this.isActive,
      );

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        addedDatetime: json["added_datetime"],
        commentDescription: json["comment_description"],
        commentId: json["comment_id"],
        fkUserId: json["fk_user_id"],
        fkVideoId: json["fk_video_id"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "added_datetime": addedDatetime,
        "comment_description": commentDescription,
        "comment_id": commentId,
        "fk_user_id": fkUserId,
        "fk_video_id": fkVideoId,
        "is_active": isActive,
      };

  @override
  List<Object?> get props => [
        addedDatetime,
        commentDescription,
        commentId,
        fkUserId,
        fkVideoId,
        isActive
      ];
}
