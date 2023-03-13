import 'package:course_mania/constants/api.dart';
import 'package:course_mania/cubits/playlist_cubit.dart';
import 'package:course_mania/cubits/user_cubit.dart';
import 'package:course_mania/locale/locales.dart';
import 'package:course_mania/models/playlist_model.dart';
import 'package:course_mania/constants/component.dart';
import 'package:course_mania/models/user_model.dart';
import 'package:course_mania/screens/video_detail_screen.dart';
import 'package:course_mania/widgets/custom_circular_progress_indicator.dart';
import 'package:course_mania/widgets/playlist_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/cubits/category_cubit.dart';
import 'package:course_mania/models/category_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    cacheData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<CategoryCubit, List<CategoryModel>>(
        builder: (context, catState) {
          if (catState.isEmpty) {
            return const CustomCircularProgressIndicator();
          } else {
            return DefaultTabController(
              length: catState.length,
              child: Scaffold(
                backgroundColor: kBlackColor,
                resizeToAvoidBottomInset: false,
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      Card(
                        elevation: 0,
                        color: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: ListTile(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          tileColor: kHintColor.withOpacity(0.2),
                          title: BlocBuilder<UserCubit, List<UserModel>>(
                            builder: (context, userState) {
                              if (userState.isEmpty) {
                                return const CustomCircularProgressIndicator();
                              }
                              for (UserModel user in userState) {
                                if (user.userId.toString() == id) {
                                  return Text(
                                    '${AppLocalizations.of(context)!.hey!} ${user.userName.split(" ")[0]}, 👋',
                                    style: kTextStyle.copyWith(
                                      color: kHintColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  );
                                }
                              }
                              return Container();
                            },
                          ),
                          subtitle: Text(
                            AppLocalizations.of(context)!.findSource!,
                            style: kTextStyle.copyWith(color: kWhiteColor),
                          ),
                          trailing: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: kHintColor.withOpacity(0.2),
                            ),
                            child: IconButton(
                              onPressed: () {
                                showSearch(
                                  context: context,
                                  delegate: CustomSearchDelegate(),
                                );
                              },
                              icon: const Icon(Icons.search),
                              color: kHintColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: TabBar(
                          isScrollable: true,
                          indicator: ShapeDecoration(
                            gradient: LinearGradient(
                              colors: [
                                kHintColor.withOpacity(0.2),
                                kGreenAccentColor.withOpacity(0.2),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          overlayColor: MaterialStateProperty.all<Color>(
                            kHintColor.withOpacity(0.2),
                          ),
                          physics: const ClampingScrollPhysics(),
                          indicatorColor: kHintColor,
                          labelColor: kWhiteColor,
                          tabs: catState.map((category) {
                            return Tab(text: category.categoryName);
                          }).toList(),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: catState.map((category) {
                            return BlocBuilder<PlaylistCubit,
                                List<PlaylistModel>>(
                              builder: (context, playlistState) {
                                if (playlistState.isEmpty) {
                                  return const CustomCircularProgressIndicator();
                                }
                                return Column(
                                  children: [
                                    CarouselSlider(
                                      options: CarouselOptions(
                                        autoPlay: true,
                                        aspectRatio: 0.72,
                                        enlargeCenterPage: true,
                                        clipBehavior: Clip.none,
                                      ),
                                      items: playlistState
                                          .map((playlist) {
                                            return PlaylistCard(
                                              playlist: playlist,
                                            );
                                          })
                                          .where((element) =>
                                              element.playlist.fkCategoryId ==
                                              category.categoryId)
                                          .toList(),
                                    ),
                                  ],
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: kHintColor,
        ),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: kHintColor,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    String result = "";
    return BlocBuilder<PlaylistCubit, List<PlaylistModel>>(
      builder: (context, playlistState) {
        if (playlistState.isEmpty) {
          return const CustomCircularProgressIndicator();
        }
        final suggestions = playlistState.where((playlist) {
          return playlist.playlistName
              .toLowerCase()
              .contains(query.toLowerCase());
        });
        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                suggestions.elementAt(index).playlistName,
              ),
              onTap: () {
                result = suggestions.elementAt(index).playlistName;
                close(context, result);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<PlaylistCubit, List<PlaylistModel>>(
      builder: (context, playlistState) {
        if (playlistState.isEmpty) {
          return const CustomCircularProgressIndicator();
        }
        final List<PlaylistModel> suggestions = playlistState.where((playlist) {
          return playlist.playlistName
              .toLowerCase()
              .contains(query.toLowerCase());
        }).toList();

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          color: kBlackColor,
          width: double.infinity,
          child: Column(
            children: [
              ...suggestions.map((playlist) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      VideoDetailScreen.routeName,
                      arguments: playlist,
                    );
                  },
                  child: ListTile(
                    leading: playlist.thumbnail != null
                        ? CircleAvatar(
                            backgroundColor: kWhiteColor,
                            backgroundImage: NetworkImage(
                              Api().baseApi + playlist.thumbnail.toString(),
                            ),
                          )
                        : CircleAvatar(
                            backgroundColor: kTransparentColor,
                            backgroundImage: const AssetImage(
                              'images/coursethumbnail1.png',
                            ),
                          ),
                    title: Text(
                      playlist.playlistName,
                      style: kTextStyle.copyWith(color: kHintColor),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      textTheme: TextTheme(
        headline6: TextStyle(
          color: kWhiteColor,
        ),
      ),
      hintColor: kTextColor,
      appBarTheme: AppBarTheme(
        color: kBlackColor,
        toolbarTextStyle: TextTheme(
          headline6: TextStyle(
            fontWeight: FontWeight.bold,
            color: kWhiteColor,
          ),
        ).bodyText2,
        titleTextStyle: TextTheme(
          headline6: TextStyle(
            fontWeight: FontWeight.bold,
            color: kWhiteColor,
          ),
        ).headline6,
      ),
    );
  }
}
