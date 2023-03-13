import 'package:course_mania/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/widgets/button.dart';
import 'package:course_mania/widgets/unicorn_button.dart';

class NotificationPermissionScreen extends StatefulWidget {
  const NotificationPermissionScreen({super.key});
  static const routeName = '/notification-permission';

  @override
  State<NotificationPermissionScreen> createState() =>
      _NotificationPermissionScreenState();
}

class _NotificationPermissionScreenState
    extends State<NotificationPermissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kTextColor),
        backgroundColor: kBlackColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Notifications',
          style: kTextStyle.copyWith(color: kWhiteColor),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset('images/notification.png'),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Stay notified about, new course update, scoreboard status",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style:
                      kTextStyle.copyWith(color: kWhiteColor, fontSize: 16.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                child: Button(
                  buttontext: 'Allow',
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(TabsScreen.routeName);
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                child: UnicornOutlineButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(TabsScreen.routeName);
                  },
                  buttontext: 'Skip',
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
