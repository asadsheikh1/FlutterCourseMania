import 'package:course_mania/screens/video_player_screen.dart';
import 'package:flutter/material.dart';

import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/models/video_model.dart';

class VideoListView extends StatelessWidget {
  final List<VideoModel> videos;

  const VideoListView({
    super.key,
    required this.videos,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (() {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) {
                  return VideoPlayerScreen(video: videos[index]);
                }),
              ),
            );
          }),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: kHintColor.withOpacity(0.2),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: kHintColor.withOpacity(0.2),
                  child: Center(
                    child: Text(
                      (index + 1).toString(),
                      style: kTextStyle.copyWith(
                        color: kHintColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  videos.toList()[index].videoName,
                  style: kTextStyle.copyWith(
                    color: kHintColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '00.00 / 09:12',
                  style: kTextStyle.copyWith(color: kHintColor),
                ),
                trailing: CircleAvatar(
                  backgroundColor: kHintColor.withOpacity(0.2),
                  child: Center(
                    child: Icon(
                      Icons.lock_rounded,
                      color: kHintColor,
                      size: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    // return Padding(
    //   padding: const EdgeInsets.all(10.0),
    //   child: Container(
    //     width: MediaQuery.of(context).size.width,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(10.0),
    //       color: kHintColor.withOpacity(0.2),
    //     ),
    //     child: ListTile(
    //       leading: CircleAvatar(
    //         backgroundColor: kHintColor.withOpacity(0.2),
    //         child: Center(
    //           child: Text(
    //             index.toString(),
    //             style: kTextStyle.copyWith(
    //               color: kHintColor,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //       ),
    //       title: Text(
    //         video.videoName,
    //         style: kTextStyle.copyWith(
    //           color: kHintColor,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       subtitle: Text(
    //         '00.00 / 09:12',
    //         style: kTextStyle.copyWith(color: kHintColor),
    //       ),
    //       trailing: CircleAvatar(
    //         backgroundColor: kHintColor.withOpacity(0.2),
    //         child: Center(
    //           child: Icon(
    //             Icons.lock_rounded,
    //             color: kHintColor,
    //             size: 20.0,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
