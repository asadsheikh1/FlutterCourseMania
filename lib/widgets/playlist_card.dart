import 'package:course_mania/constants/api.dart';
import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/cubits/user_cubit.dart';
import 'package:course_mania/cubits/video_cubit.dart';
import 'package:course_mania/models/playlist_model.dart';
import 'package:course_mania/models/user_model.dart';
import 'package:course_mania/models/video_model.dart';
import 'package:course_mania/screens/video_detail_screen.dart';
import 'package:course_mania/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaylistCard extends StatelessWidget {
  final PlaylistModel playlist;

  const PlaylistCard({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, List<UserModel>>(
      builder: (context, userState) {
        if (userState.isEmpty) {
          return const CustomCircularProgressIndicator();
        }
        return BlocBuilder<VideoCubit, List<VideoModel>>(
          builder: (context, vidState) {
            if (vidState.isEmpty) {
              return const CustomCircularProgressIndicator();
            }
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  VideoDetailScreen.routeName,
                  arguments: playlist,
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  height: 560,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        kCyanColor,
                        kHintColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: kGreenAccentColor.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(-5, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      playlist.thumbnail != null
                          ? Image.network(
                              Api().baseApi + playlist.thumbnail,
                              width: MediaQuery.of(context).size.width,
                              height: 250.0,
                              fit: BoxFit.contain,
                            )
                          : Image.asset(
                              'images/coursethumbnail1.png',
                              width: MediaQuery.of(context).size.width,
                              height: 250.0,
                              fit: BoxFit.cover,
                            ),
                      playlist.rating != null
                          ? Positioned(
                              right: 0.0,
                              top: 20.0,
                              child: Container(
                                width: 80.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    bottomLeft: Radius.circular(20.0),
                                  ),
                                  color: kBlackColor,
                                ),
                                child: Center(
                                  child: Text(
                                    '${playlist.rating.toString()} / 5',
                                    style: kTextStyle.copyWith(
                                      color: kWhiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      Positioned(
                        bottom: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                ...userState.map(((user) {
                                  if (playlist.fkUserId == user.userId) {
                                    return Row(
                                      children: [
                                        Icon(
                                          Icons.person_outline,
                                          color: kWhiteColor,
                                        ),
                                        Text(
                                          user.userName,
                                          style: kTextStyle.copyWith(
                                            color: kWhiteColor,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return Container();
                                })).toList(),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.attach_money,
                                  color: kWhiteColor,
                                ),
                                Text(
                                  playlist.cost,
                                  style: kTextStyle.copyWith(
                                    color: kWhiteColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      playlist.playlistName != null
                          ? Positioned(
                              bottom: 80,
                              child: SizedBox(
                                width: 300,
                                child: Text(
                                  playlist.playlistName,
                                  style: kTextStyle.copyWith(
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : Container(),
                      Positioned(
                        bottom: -30,
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                kGreenAccentColor.withOpacity(0.8),
                                kCyanColor.withOpacity(0.8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                color: kGreenAccentColor.withOpacity(0.6),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.play_arrow,
                            size: 40,
                            color: kWhiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
