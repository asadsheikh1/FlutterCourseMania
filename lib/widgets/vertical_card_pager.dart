import 'package:course_mania/cubits/subscription_cubit.dart';
import 'package:course_mania/models/subscription_model.dart';
import 'package:course_mania/widgets/custom_circular_progress_indicator.dart';
import 'package:course_mania/widgets/favourite_course_video_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

import 'package:course_mania/constants/constant.dart';

class MyVerticalCardPager extends StatelessWidget {
  MyVerticalCardPager({
    super.key,
  });

  List<String> titles = [
    'Artificial Intelligence',
    'Artificial Intelligence',
    'Artificial Intelligence',
    'Artificial Intelligence',
    'Artificial Intelligence',
    'Artificial Intelligence',
  ];

  List<Widget> images = [
    const FavouriteVideoCardSlider(),
    const FavouriteVideoCardSlider(),
    const FavouriteVideoCardSlider(),
    const FavouriteVideoCardSlider(),
    const FavouriteVideoCardSlider(),
    const FavouriteVideoCardSlider(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionCubit, List<SubscriptionModel>>(
      builder: (context, subState) {
        if (subState.isEmpty) {
          return const CustomCircularProgressIndicator();
        }
        return Expanded(
          child: VerticalCardPager(
            textStyle: TextStyle(
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: [
                    kBlackColor,
                    kBlackColor,
                  ],
                ).createShader(
                  const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                ),
            ),
            titles: titles,
            images: images,
            onPageChanged: (page) {},
            align: ALIGN.CENTER,
            onSelectedItem: (index) {
              print(index);
            },
          ),
        );
      },
    );
  }
}


// import 'package:course_mania/widgets/favourite_course_video_slider.dart';
// import 'package:flutter/material.`dart';
// import 'package:vertical_card_pager/vertical_card_pager.dart';

// import 'package:course_mania/constants/constant.dart';

// class MyVerticalCardPager extends StatelessWidget {
//   final String playlistId;

//   MyVerticalCardPager({
//     super.key,
//     required this.playlistId,
//   });

//   List<String> titles = [
//     'Artificial Intelligence',
//     'Artificial Intelligence',
//     'Artificial Intelligence',
//     'Artificial Intelligence',
//     'Artificial Intelligence',
//     'Artificial Intelligence',
//   ];

//   List<Widget> images = [
//     const FavouriteVideoCardSlider(),
//     const FavouriteVideoCardSlider(),
//     const FavouriteVideoCardSlider(),
//     const FavouriteVideoCardSlider(),
//     const FavouriteVideoCardSlider(),
//     const FavouriteVideoCardSlider(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: VerticalCardPager(
//         textStyle: TextStyle(
//           foreground: Paint()
//             ..shader = LinearGradient(
//               colors: [
//                 kBlackColor,
//                 kBlackColor,
//               ],
//             ).createShader(
//               const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
//             ),
//         ),
//         titles: titles,
//         images: images,
//         onPageChanged: (page) {},
//         align: ALIGN.CENTER,
//         onSelectedItem: (index) {
//           print(index);
//         },
//       ),
//     );
//   }
// }
