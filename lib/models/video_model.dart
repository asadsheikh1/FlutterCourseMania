import 'dart:convert';

import 'package:equatable/equatable.dart';

PayloadModel payloadModelFromJson(String str) =>
    PayloadModel.fromJson(json.decode(str));

String payloadModelToJson(PayloadModel data) => json.encode(data.toJson());

class PayloadModel extends Equatable {
  final List<VideoModel> videos;

  const PayloadModel({
    required this.videos,
  });

  PayloadModel copyWith({
    List<VideoModel>? videos,
  }) =>
      PayloadModel(
        videos: videos ?? this.videos,
      );

  factory PayloadModel.fromJson(Map<String, dynamic> json) => PayloadModel(
        videos: List<VideoModel>.from(
            json["payload"].map((x) => VideoModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payload": List<dynamic>.from(
          videos.map((x) => x.toJson()),
        ),
      };

  @override
  List<Object?> get props => [videos];
}

class VideoModel extends Equatable {
  final dynamic addedDatetime;
  final int commentCount;
  final dynamic fkPlaylistId;
  final int isActive;
  final dynamic thumbnail;
  final dynamic videoDescription;
  final int videoId;
  final String videoName;
  final dynamic videoPath;
  final int viewCount;

  const VideoModel({
    required this.addedDatetime,
    required this.commentCount,
    required this.fkPlaylistId,
    required this.isActive,
    required this.thumbnail,
    required this.videoDescription,
    required this.videoId,
    required this.videoName,
    required this.videoPath,
    required this.viewCount,
  });

  VideoModel copyWith({
    dynamic addedDatetime,
    int? commentCount,
    dynamic fkPlaylistId,
    int? isActive,
    dynamic thumbnail,
    dynamic videoDescription,
    int? videoId,
    String? videoName,
    dynamic videoPath,
    int? viewCount,
  }) =>
      VideoModel(
        addedDatetime: addedDatetime ?? this.addedDatetime,
        commentCount: commentCount ?? this.commentCount,
        fkPlaylistId: fkPlaylistId ?? this.fkPlaylistId,
        isActive: isActive ?? this.isActive,
        thumbnail: thumbnail ?? this.thumbnail,
        videoDescription: videoDescription ?? this.videoDescription,
        videoId: videoId ?? this.videoId,
        videoName: videoName ?? this.videoName,
        videoPath: videoPath ?? this.videoPath,
        viewCount: viewCount ?? this.viewCount,
      );

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        addedDatetime: json["added_datetime"],
        commentCount: json["comment_count"],
        fkPlaylistId: json["fk_playlist_id"],
        isActive: json["is_active"],
        thumbnail: json["thumbnail"],
        videoDescription: json["video_description"],
        videoId: json["video_id"],
        videoName: json["video_name"],
        videoPath: json["video_path"],
        viewCount: json["view_count"],
      );

  Map<String, dynamic> toJson() => {
        "added_datetime": addedDatetime,
        "comment_count": commentCount,
        "fk_playlist_id": fkPlaylistId,
        "is_active": isActive,
        "thumbnail": thumbnail,
        "video_description": videoDescription,
        "video_id": videoId,
        "video_name": videoName,
        "video_path": videoPath,
        "view_count": viewCount,
      };

  @override
  List<Object?> get props => [
        addedDatetime,
        commentCount,
        fkPlaylistId,
        isActive,
        thumbnail,
        videoDescription,
        videoId,
        videoName,
        videoPath,
        viewCount,
      ];
}
