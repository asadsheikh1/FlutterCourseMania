import 'package:course_mania/locale/locales.dart';
import 'package:course_mania/widgets/completed_video_card_slider.dart';
import 'package:flutter/material.dart';
import 'package:course_mania/widgets/vertical_card_pager.dart';

import 'package:course_mania/constants/constant.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});
  static const routeName = '/video';

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final List<String> titles = [
    'Artificial Intelligence',
    'Artificial Intelligence',
    'Artificial Intelligence',
    'Artificial Intelligence',
    'Artificial Intelligence',
    'Artificial Intelligence',
  ];

  final List<Widget> images = [
    const CompletedVideoCardSlider(),
    const CompletedVideoCardSlider(),
    const CompletedVideoCardSlider(),
    const CompletedVideoCardSlider(),
    const CompletedVideoCardSlider(),
    const CompletedVideoCardSlider(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlackColor,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                  title: Text(
                    AppLocalizations.of(context)!.startCompleting!,
                    style: kTextStyle.copyWith(
                      color: kHintColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  subtitle: Text(
                    AppLocalizations.of(context)!.learnFrom!,
                    style: kTextStyle.copyWith(color: kWhiteColor),
                  ),
                ),
              ),
              MyVerticalCardPager(),
            ],
          ),
        ),
      ),
    );
  }
}
