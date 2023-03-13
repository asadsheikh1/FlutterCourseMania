import 'package:course_mania/blocs/order/order_bloc.dart';
import 'package:course_mania/constants/api.dart';
import 'package:course_mania/constants/component.dart';
import 'package:course_mania/cubits/subscription_cubit.dart';
import 'package:course_mania/cubits/user_cubit.dart';
import 'package:course_mania/cubits/video_cubit.dart';
import 'package:course_mania/locale/locales.dart';
import 'package:course_mania/models/playlist_model.dart';
import 'package:course_mania/models/subscription_model.dart';
import 'package:course_mania/models/user_model.dart';
import 'package:course_mania/models/video_model.dart';
import 'package:course_mania/screens/order_screen.dart';
import 'package:course_mania/widgets/button.dart';
import 'package:course_mania/widgets/custom_circular_progress_indicator.dart';
import 'package:course_mania/widgets/outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/widgets/video_list_view.dart';
import 'package:readmore/readmore.dart' as rm;

const double width = 300.0;
const double height = 50.0;
const double playListAlign = -1;
const double descriptionAlign = 1;

class VideoDetailScreen extends StatefulWidget {
  const VideoDetailScreen({super.key});
  static const routeName = '/video-detail';

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  late double xAlign;
  late Color loginColor;
  late Color signInColor;
  bool descriptionShow = false;
  List<String> faqData = [
    'Can I enroll single class?',
    'What is fund pocily',
    'Is financial aid available?',
    'What tool I need?'
  ];
  String description =
      "Flutter is Google’s mobile UI framework for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source.";

  @override
  void initState() {
    super.initState();

    xAlign = playListAlign;
    loginColor = kWhiteColor;
    signInColor = kHintColor;
  }

  VideoListView listViews(List<VideoModel> vidState, PlaylistModel playlist) {
    List<VideoModel> videos = vidState.where((video) {
      return video.fkPlaylistId == playlist.playlistId;
    }).toList();

    return VideoListView(
      videos: videos,
    );
  }

  Future<int> subscribe(String fkUserId, String fkPlaylistId) async {
    try {
      Response response = await post(
        Uri.parse('http://127.0.0.1:5000/subscription/add'),
        body: {
          'fk_user_id': fkUserId,
          'fk_playlist_id': fkPlaylistId,
        },
      );
      if (response.statusCode == 201) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  Future<int> unsubscribe(String fkUserId, String fkPlaylistId) async {
    try {
      Response response = await post(
        Uri.parse('http://127.0.0.1:5000/subscription/delete'),
        body: {
          'fk_user_id': fkUserId,
          'fk_playlist_id': fkPlaylistId,
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  bool? isSubscribed;

  @override
  Widget build(BuildContext context) {
    PlaylistModel playlist =
        ModalRoute.of(context)!.settings.arguments as PlaylistModel;

    return BlocBuilder<VideoCubit, List<VideoModel>>(
      builder: (context, vidState) {
        int noOfVideos = vidState
            .where((video) {
              return video.fkPlaylistId == playlist.playlistId;
            })
            .toList()
            .length;

        return Scaffold(
          backgroundColor: kBlackColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            iconTheme: IconThemeData(color: kTextColor),
            backgroundColor: kBlackColor,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.details!,
              style: kTextStyle.copyWith(color: kHintColor),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: InkWell(
                  onTap: () {},
                  child: IconButton(
                    icon: const Icon(Icons.favorite),
                    color: kHintColor,
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          body: BlocBuilder<UserCubit, List<UserModel>>(
            builder: (context, userState) {
              if (userState.isEmpty) {
                return const CustomCircularProgressIndicator();
              }
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    Stack(
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
                        Positioned(
                          right: 20.0,
                          bottom: 0.0,
                          child: Container(
                            width: 80.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0)),
                              color: kBlackColor,
                            ),
                            child: Center(
                              child: Text(
                                '\$ ${playlist.cost}',
                                style: kTextStyle.copyWith(
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 10.0,
                      ),
                      child: Row(
                        children: [
                          playlist.playlistName != null
                              ? SizedBox(
                                  width: 300,
                                  child: Text(
                                    playlist.playlistName,
                                    style: kTextStyle.copyWith(
                                      color: kHintColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                )
                              : Container(),
                          const Spacer(),
                          playlist.rating != null
                              ? Row(
                                  children: [
                                    Text(
                                      playlist.rating,
                                      style: kTextStyle.copyWith(
                                        color: kTextColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Icon(
                                      FontAwesomeIcons.solidStar,
                                      color: Color(0xFFF5B400),
                                      size: 14.0,
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 10.0,
                      ),
                      child: Row(
                        children: [
                          ...userState.map(((user) {
                            if (playlist.fkUserId == user.userId) {
                              return Text(
                                '${AppLocalizations.of(context)!.by!} ${user.userName}',
                                style: kTextStyle.copyWith(
                                  color: kTextColor,
                                ),
                              );
                            }
                            return Container();
                          })).toList(),
                          const Spacer(),
                          Text(
                            '$noOfVideos ${AppLocalizations.of(context)!.tutorials!}',
                            style: kTextStyle.copyWith(color: kTextColor),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<SubscriptionCubit, List<SubscriptionModel>>(
                      builder: (context, subState) {
                        if (subState.isEmpty) {
                          return const CustomCircularProgressIndicator();
                        }
                        for (SubscriptionModel subscription in subState) {
                          isSubscribed = subscription.fkUserId.toString() ==
                                  id! &&
                              subscription.fkPlaylistId == playlist.playlistId;
                          // print(isSubscribed!);
                        }
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: playlist.fkUserId.toString() != id
                              ? isSubscribed!
                                  ? OutlineButton(
                                      buttontext: AppLocalizations.of(context)!
                                          .unsubscribe!,
                                      onPressed: () async {
                                        int isUnsubscribed = await unsubscribe(
                                          id!,
                                          playlist.playlistId.toString(),
                                        );
                                        testing();
                                        if (isUnsubscribed != 0) {
                                          Fluttertoast.showToast(
                                            msg: AppLocalizations.of(context)!
                                                .youreUnsubscribed!,
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: kBlackColor,
                                            textColor: kHintColor,
                                            fontSize: 16.0,
                                          );
                                        }
                                      },
                                    )
                                  : Button(
                                      buttontext: AppLocalizations.of(context)!
                                          .subscribe!,
                                      onPressed: () async {
                                        int isSubscribed = await subscribe(
                                          id!,
                                          playlist.playlistId.toString(),
                                        );

                                        context
                                            .read<SubscriptionCubit>()
                                            .subscription;

                                        if (isSubscribed != 0) {
                                          Fluttertoast.showToast(
                                            msg: AppLocalizations.of(context)!
                                                .youreSubscribed!,
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: kBlackColor,
                                            textColor: kHintColor,
                                            fontSize: 16.0,
                                          );
                                        }
                                      },
                                    )
                              : Container(),
                        );
                      },
                    ),
                    Center(
                      child: Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                          color: kTransparentColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        child: Stack(
                          children: [
                            AnimatedAlign(
                              alignment: Alignment(xAlign, 0),
                              duration: const Duration(milliseconds: 300),
                              child: Container(
                                width: width * 0.5,
                                height: height,
                                decoration: BoxDecoration(
                                  color: kHintColor.withOpacity(0.6),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(50.0),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  xAlign = playListAlign;
                                  loginColor = kWhiteColor;
                                  descriptionShow = false;
                                  signInColor = kHintColor;
                                });
                              },
                              child: Align(
                                alignment: const Alignment(-1, 0),
                                child: Container(
                                  width: width * 0.5,
                                  color: kTransparentColor,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${AppLocalizations.of(context)!.playlist!} ($noOfVideos)',
                                    style: TextStyle(
                                      color: loginColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  xAlign = descriptionAlign;
                                  signInColor = kWhiteColor;
                                  descriptionShow = true;
                                  loginColor = kHintColor;
                                });
                              },
                              child: Align(
                                alignment: const Alignment(1, 0),
                                child: Container(
                                  width: width * 0.5,
                                  color: kTransparentColor,
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(context)!.description!,
                                    style: TextStyle(
                                      color: signInColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: descriptionShow,
                      child: Column(
                        children: [
                          playlist.playlistDescription != null
                              ? Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: rm.ReadMoreText(
                                    playlist.playlistDescription,
                                    trimLines: 2,
                                    colorClickableText: kPrimaryColor,
                                    trimMode: rm.TrimMode.Line,
                                    style:
                                        kTextStyle.copyWith(color: kTextColor),
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                    moreStyle: kTextStyle.copyWith(
                                      color: kHintColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    lessStyle: kTextStyle.copyWith(
                                      color: kHintColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : Container(),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Row(
                              children: [
                                Text(
                                  'What you\'ll get',
                                  style: kTextStyle.copyWith(
                                    color: kHintColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.library_books_outlined,
                                          color: kHintColor, size: 18),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        '$noOfVideos Lesson(s)',
                                        style: kTextStyle.copyWith(
                                            color: kTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.android,
                                        color: kHintColor,
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        'Available on Android & iOS',
                                        style: kTextStyle.copyWith(
                                            color: kTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.bar_chart,
                                          color: kHintColor, size: 18),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Text('Begginer Level',
                                          style: kTextStyle.copyWith(
                                              color: kTextColor)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.access_time,
                                          color: kHintColor, size: 18),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Text('Lifetime Access',
                                          style: kTextStyle.copyWith(
                                              color: kTextColor)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.quiz,
                                          color: kHintColor, size: 18),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Text('100 Quiz',
                                          style: kTextStyle.copyWith(
                                              color: kTextColor)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.contact_page_outlined,
                                          color: kHintColor, size: 18),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Text('Certificate of Completion',
                                          style: kTextStyle.copyWith(
                                              color: kTextColor)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Row(
                              children: [
                                Text(
                                  'FAQ',
                                  style: kTextStyle.copyWith(
                                    color: kHintColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: faqData.map(
                                (data) {
                                  return ExpansionTile(
                                    tilePadding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    title: Text(data),
                                    iconColor: kHintColor,
                                    collapsedIconColor: kWhiteColor,
                                    textColor: kHintColor,
                                    children: [
                                      ListTile(
                                        title: Text(
                                          description,
                                          style: TextStyle(color: kTextColor),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !descriptionShow,
                      child: listViews(vidState, playlist),
                    ),
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: Card(
            elevation: 0.0,
            color: kBlackColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(OrderScreen.routeName);
                      },
                      child: Container(
                        height: 55.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: kHintColor.withOpacity(0.2),
                        ),
                        child: Icon(
                          Icons.shopping_cart,
                          color: kHintColor,
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, ordState) {
                      if (ordState is OrderLoading) {
                        return const Expanded(
                          flex: 3,
                          child: CustomCircularProgressIndicator(),
                        );
                      }
                      if (ordState is OrderLoaded) {
                        return Expanded(
                          flex: 3,
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<OrderBloc>(context).add(
                                OrderProductAdded(playlist),
                              );
                              Fluttertoast.showToast(
                                msg: "Item added to cart.",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: kBlackColor,
                                textColor: kHintColor,
                                fontSize: 16.0,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Container(
                                height: 55.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: kHintColor.withOpacity(0.2),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.buyNow!,
                                      style: kTextStyle.copyWith(
                                        color: kHintColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const Text('Something went wrong.');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  testing() {
    return context.read<SubscriptionCubit>().subscription;
  }
}
