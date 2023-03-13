import 'package:course_mania/constants/api.dart';
import 'package:course_mania/constants/component.dart';
import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/cubits/comment_cubit.dart';
import 'package:course_mania/cubits/user_cubit.dart';
import 'package:course_mania/models/comment_model.dart';
import 'package:course_mania/models/user_model.dart';
import 'package:course_mania/models/video_model.dart';
import 'package:course_mania/widgets/button.dart';
import 'package:course_mania/widgets/custom_circular_progress_indicator.dart';
import 'package:course_mania/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:course_mania/models/comment_model.dart' as comment_model;

class VideoPlayerScreen extends StatefulWidget {
  final VideoModel? video;

  const VideoPlayerScreen({super.key, this.video});
  static const routeName = '/video-player';

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  TextEditingController commentController = TextEditingController();
  String errorMessage = '';

  void addComment(
      String fkUserId, String fkVideoid, String commentDescription) async {
    try {
      http.Response response = await http.post(
        Uri.parse('http://127.0.0.1:5000/comment/add'),
        body: {
          'fk_user_id': fkUserId,
          'fk_video_id': fkVideoid,
          'comment_description': commentDescription,
          'added_datetime': DateTime.now().toString(),
        },
      );
      if (response.statusCode == 201) {
        clear();
      } else {}
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  void deleteComment(String commentId) async {
    try {
      http.Response response = await http.post(
        Uri.parse('http://127.0.0.1:5000/comment/delete/$commentId'),
      );
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Comment deleted successfully.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kBlackColor,
          textColor: kHintColor,
          fontSize: 16.0,
        );
      } else {}
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<List<CommentModel>> getComment() async {
    try {
      final response =
          await http.get(Uri.parse(Api().baseApi + "comment/getall"));
      if (response.statusCode == 200) {
        final payload = comment_model.payloadModelFromJson(response.body);
        return payload.comments;
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  void clear() {
    commentController.clear();
  }

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        Uri.parse('http://127.0.0.1:5000/${widget.video!.videoPath}')
            .toString())
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => _controller.play());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = _controller.value.volume == 0;
    return BlocProvider(
      create: (context) => CommentCubit()..comment,
      child: BlocBuilder<UserCubit, List<UserModel>>(
        builder: (context, userState) {
          if (userState.isEmpty) {
            return const CustomCircularProgressIndicator();
          }
          return BlocBuilder<CommentCubit, List<CommentModel>>(
            builder: (context, commentState) {
              if (commentState.isEmpty) {
                return const CustomCircularProgressIndicator();
              }
              for (UserModel user in userState) {
                if (user.userId.toString() == id) {
                  return Scaffold(
                    backgroundColor: kBlackColor,
                    resizeToAvoidBottomInset: false,
                    appBar: AppBar(
                      iconTheme: IconThemeData(color: kTextColor),
                      backgroundColor: kBlackColor,
                      elevation: 0.0,
                      centerTitle: true,
                      title: Text(
                        widget.video!.videoName,
                        style: kTextStyle.copyWith(color: kHintColor),
                      ),
                    ),
                    body: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 350,
                            width: double.infinity,
                            child: _controller.value.isInitialized
                                ? Column(
                                    children: [
                                      VideoPlayerWidget(
                                        controller: _controller,
                                      ),
                                      Text(
                                        '${_controller.value.duration.inMinutes.toString().padLeft(2, '0')}:${_controller.value.duration.inSeconds.toString().padLeft(2, '0')}',
                                        style: kTextStyle.copyWith(
                                          color: kHintColor,
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: kHintColor,
                                        child: IconButton(
                                          icon: Icon(
                                            isMuted
                                                ? Icons.volume_mute
                                                : Icons.volume_up,
                                            color: kWhiteColor,
                                          ),
                                          onPressed: () {
                                            _controller.setVolume(
                                              isMuted ? 1 : 0,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            child: Text(
                              'Comments',
                              style: kTextStyle.copyWith(
                                color: kTextColor,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          ...commentState.map((comment) {
                            if (comment.fkVideoId == widget.video!.videoId) {
                              return comment.isActive == 1
                                  ? Column(
                                      children: [
                                        Divider(color: kTextColor),
                                        ...userState.map((user) {
                                          if (user.userId == comment.fkUserId) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: kHintColor
                                                      .withOpacity(0.2),
                                                ),
                                                child: ListTile(
                                                  leading: CircleAvatar(
                                                    backgroundColor: kHintColor
                                                        .withOpacity(0.2),
                                                    child: Center(
                                                      child: user.avatar == null
                                                          ? CircleAvatar(
                                                              radius: 60.0,
                                                              backgroundColor:
                                                                  kTransparentColor,
                                                              backgroundImage:
                                                                  const AssetImage(
                                                                'images/profile1.jpg',
                                                              ),
                                                            )
                                                          : CircleAvatar(
                                                              radius: 60.0,
                                                              backgroundColor:
                                                                  kTransparentColor,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                Api().baseApi +
                                                                    user.avatar,
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                  title: Text(
                                                    user.userName,
                                                    style: kTextStyle.copyWith(
                                                      color: kHintColor,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    comment.commentDescription,
                                                    style: kTextStyle,
                                                  ),
                                                  trailing: FittedBox(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '2 min ago',
                                                          style: kTextStyle
                                                              .copyWith(
                                                            color: kTextColor,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        id ==
                                                                comment.fkUserId
                                                                    .toString()
                                                            ? IconButton(
                                                                onPressed: () {
                                                                  deleteComment(comment
                                                                      .commentId
                                                                      .toString());
                                                                  context
                                                                      .read<
                                                                          CommentCubit>()
                                                                      .comment;
                                                                  setState(
                                                                      () {});
                                                                },
                                                                icon: Icon(
                                                                  Icons.delete,
                                                                  color:
                                                                      kTextColor,
                                                                ),
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          return Container();
                                        }).toList(),
                                      ],
                                    )
                                  : Container();
                            }
                            return Container();
                          }).toList(),
                        ],
                      ),
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: kHintColor,
                      child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0),
                              ),
                            ),
                            backgroundColor: kBlackColor,
                            context: context,
                            isScrollControlled: true,
                            builder: (ctx) => Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: TextFormField(
                                      controller: commentController,
                                      keyboardType: TextInputType.emailAddress,
                                      maxLines: 2,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: kHintColor.withOpacity(0.2),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: kHintColor,
                                          ),
                                        ),
                                        alignLabelWithHint: true,
                                        border: const OutlineInputBorder(),
                                        labelText: 'Add a comment',
                                        floatingLabelStyle:
                                            TextStyle(color: kTextColor),
                                        labelStyle:
                                            TextStyle(color: kTextColor),
                                        suffixIcon: Icon(
                                          Icons.comment,
                                          color: kTextColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Button(
                                    buttontext: 'Submit',
                                    onPressed: () {
                                      addComment(
                                        id!,
                                        widget.video!.videoId.toString(),
                                        commentController.text,
                                      );

                                      context.read<CommentCubit>().comment;

                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.comment,
                        ),
                      ),
                    ),
                  );
                }
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}
