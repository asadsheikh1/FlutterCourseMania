import 'package:course_mania/constants/api.dart';
import 'package:course_mania/constants/component.dart';
import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/cubits/playlist_cubit.dart';
import 'package:course_mania/cubits/subscription_cubit.dart';
import 'package:course_mania/models/playlist_model.dart';
import 'package:course_mania/models/subscription_model.dart';
import 'package:course_mania/screens/video_detail_screen.dart';
import 'package:course_mania/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionCubit, List<SubscriptionModel>>(
      builder: (context, subState) {
        if (subState.isEmpty) {
          return const CustomCircularProgressIndicator();
        }
        return BlocBuilder<PlaylistCubit, List<PlaylistModel>>(
          builder: (context, playlistState) {
            if (playlistState.isEmpty) {
              return const CustomCircularProgressIndicator();
            }
            return Column(
              children: [
                ...subState.map((subscription) {
                  if (subscription.fkUserId.toString() == id) {
                    return Column(
                      children: [
                        ...playlistState.map((playlist) {
                          if (subscription.fkPlaylistId.toString() ==
                              playlist.playlistId.toString()) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  VideoDetailScreen.routeName,
                                  arguments: playlist,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  height: 200,
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
                                        color:
                                            kGreenAccentColor.withOpacity(0.2),
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
                                              Api().baseApi +
                                                  playlist.thumbnail,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 250.0,
                                              fit: BoxFit.contain,
                                            )
                                          : Image.asset(
                                              'images/coursethumbnail1.png',
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 250.0,
                                              fit: BoxFit.cover,
                                            ),
                                      Positioned(
                                        bottom: 50,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
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
                                                kGreenAccentColor
                                                    .withOpacity(0.8),
                                                kCyanColor.withOpacity(0.8),
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            boxShadow: [
                                              BoxShadow(
                                                color: kGreenAccentColor
                                                    .withOpacity(0.6),
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
                          }
                          return Container();
                        }),
                      ],
                    );
                  }
                  return Container();
                }),
              ],
            );
          },
        );
      },
    );
  }
}

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:course_mania/constants/api.dart';
// import 'package:course_mania/constants/component.dart';
// import 'package:course_mania/constants/constant.dart';
// import 'package:course_mania/cubits/playlist_cubit.dart';
// import 'package:course_mania/cubits/subscription_cubit.dart';
// import 'package:course_mania/models/playlist_model.dart';
// import 'package:course_mania/models/subscription_model.dart';
// import 'package:course_mania/widgets/custom_circular_progress_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class NewWidget extends StatelessWidget {
//   const NewWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SubscriptionCubit, List<SubscriptionModel>>(
//       builder: (context, subState) {
//         if (subState.isEmpty) {
//           return const CustomCircularProgressIndicator();
//         }
//         return BlocBuilder<PlaylistCubit, List<PlaylistModel>>(
//           builder: (context, playlistState) {
//             if (playlistState.isEmpty) {
//               return const CustomCircularProgressIndicator();
//             }
//             return Column(
//               children: [
//                 ...subState.map((subscription) {
//                   if (subscription.fkUserId.toString() == id) {
//                     return Column(
//                       children: [
//                         ...playlistState.map((playlist) {
//                           if (subscription.fkPlaylistId.toString() ==
//                               playlist.playlistId.toString()) {
//                             return CarouselSlider(
//                               options: CarouselOptions(
//                                 height: 220,
//                                 aspectRatio: 16 / 9,
//                                 viewportFraction: 0.8,
//                                 initialPage: 0,
//                                 enableInfiniteScroll: true,
//                                 autoPlay: true,
//                                 enlargeCenterPage: true,
//                                 enlargeFactor: 0.3,
//                                 onPageChanged: ((index, reason) {}),
//                                 scrollDirection: Axis.vertical,
//                               ),
//                               items: [1].map((i) {
//                                 return Container(
//                                   height: 100,
//                                   width: MediaQuery.of(context).size.width,
//                                   margin: EdgeInsets.symmetric(horizontal: 5.0),
//                                   decoration: BoxDecoration(color: kHintColor),
//                                   child: Stack(
//                                     children: [
//                                       SizedBox(
//                                         width: double.infinity,
//                                         child: Image.network(
//                                           Api().baseApi + playlist.thumbnail,
//                                           scale: 1,
//                                           fit: BoxFit.contain,
//                                         ),
//                                       ),
//                                       Text(
//                                         playlist.playlistName,
//                                         style: TextStyle(fontSize: 16.0),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               }).toList(),
//                             );
//                             // return Column(
//                             //   children: [
//                             //     Text(
//                             //       'Playlist ID: ${subscription.fkPlaylistId.toString()}',
//                             //       style: kTextStyle,
//                             //     ),
//                             //     Text(
//                             //       'Playlist Name: ${playlist.playlistName}',
//                             //       style: kTextStyle,
//                             //     ),
//                             //   ],
//                             // );
//                           }
//                           return Container();
//                         }),
//                       ],
//                     );
//                   }
//                   return Container();
//                 }),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }
