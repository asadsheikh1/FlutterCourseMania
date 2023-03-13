import 'package:course_mania/screens/video_detail_screen.dart';
import 'package:flutter/material.dart';

import 'package:course_mania/constants/constant.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CompletedVideoCardSlider extends StatelessWidget {
  const CompletedVideoCardSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                top: 30,
                child: LinearPercentIndicator(
                  barRadius: const Radius.circular(40),
                  width: MediaQuery.of(context).size.width - 220,
                  animation: true,
                  lineHeight: 15.0,
                  animationDuration: 400,
                  percent: 0.7,
                  center: Text(
                    "70 %",
                    style: TextStyle(
                      color: kWhiteColor,
                    ),
                  ),
                  linearGradient: LinearGradient(
                    colors: [
                      kIndigoColor,
                      kPinkAccentColor,
                    ],
                  ),
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
