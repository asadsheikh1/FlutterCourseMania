import 'package:course_mania/constants/component.dart';
import 'package:course_mania/cubits/user_cubit.dart';
import 'package:course_mania/locale/locales.dart';
import 'package:course_mania/models/user_model.dart';
import 'package:course_mania/widgets/custom_circular_progress_indicator.dart';
import 'package:course_mania/widgets/favourite_course_video_slider.dart';
import 'package:course_mania/widgets/new_widget.dart';
import 'package:flutter/material.dart';

import 'package:course_mania/constants/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});
  static const routeName = '/wishlist';

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<String> titles = [
    'Artificial Intelligence',
    'Artificial Intelligence',
    'Artificial Intelligence',
    'Artificial Intelligence',
    'Artificial Intelligence',
    'Artificial Intelligence',
  ];

  final List<Widget> images = [
    const FavouriteVideoCardSlider(),
    const FavouriteVideoCardSlider(),
    const FavouriteVideoCardSlider(),
    const FavouriteVideoCardSlider(),
    const FavouriteVideoCardSlider(),
    const FavouriteVideoCardSlider(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlackColor,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  elevation: 0,
                  color: kTransparentColor,
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
                              '${user.userName.split(" ")[0]}\'s ${AppLocalizations.of(context)!.wishlistIs!}',
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
                      AppLocalizations.of(context)!.startAdding!,
                      style: kTextStyle.copyWith(color: kWhiteColor),
                    ),
                  ),
                ),
                const NewWidget(),
                // BlocBuilder<SubscriptionCubit, List<SubscriptionModel>>(
                //   builder: (context, subState) {
                //     if (subState.isEmpty) {
                //       return const CustomCircularProgressIndicator();
                //     }
                //     for (SubscriptionModel subscription in subState) {
                //       if (subscription.fkUserId.toString() == id) {
                //         return Column(
                //           children: [
                //             Text(
                //               'User ID: ${subscription.fkUserId.toString()}',
                //               style: kTextStyle,
                //             ),
                //             Text(
                //               'Playlist ID: ${subscription.fkPlaylistId.toString()}',
                //               style: kTextStyle,
                //             ),
                //           ],
                //         );
                //       }
                //     }
                //     return Container();
                //   },
                // )
                // MyVerticalCardPager(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
