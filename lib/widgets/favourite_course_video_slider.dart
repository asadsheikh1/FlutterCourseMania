import 'package:course_mania/screens/video_detail_screen.dart';
import 'package:flutter/material.dart';

import 'package:course_mania/constants/constant.dart';

class FavouriteVideoCardSlider extends StatelessWidget {
  const FavouriteVideoCardSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(VideoDetailScreen.routeName);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
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
              Image.asset(
                'images/coursethumbnail1.png',
                width: 360,
                height: 520,
              ),
              Positioned(
                top: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    size: 30,
                    shadows: [
                      BoxShadow(
                        color: kRedColor,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  color: kRedColor,
                  onPressed: () {},
                ),
              ),
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
  }
}
