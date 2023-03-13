import 'package:flutter/material.dart';

import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/screens/notification_permission_screen.dart';
import 'package:course_mania/screens/otp_screen.dart';
import 'package:course_mania/widgets/button.dart';

class PhoneAuthenticationScreen extends StatefulWidget {
  const PhoneAuthenticationScreen({super.key});
  static const routeName = '/phone-authentication';

  @override
  State<PhoneAuthenticationScreen> createState() =>
      _PhoneAuthenticationScreenState();
}

class _PhoneAuthenticationScreenState extends State<PhoneAuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kBlackColor),
        title: Text(
          'Phone Verification',
          style: kTextStyle.copyWith(color: kWhiteColor),
        ),
        centerTitle: true,
        backgroundColor: kBlackColor,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 50.0),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: kBlackColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                          "We have sent code to your number +92-333-1112001",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: kTextStyle.copyWith(
                              color: kWhiteColor, fontSize: 16.0)),
                    ),
                    const OtpForm(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "You can request OTP after 01:52",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: kTextStyle.copyWith(
                          color: kWhiteColor,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Button(
                      buttontext: 'Verify',
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                            NotificationPermissionScreen.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
