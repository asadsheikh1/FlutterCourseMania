import 'dart:async';

import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/constants/component.dart';
import 'package:course_mania/screens/sign_in_screen.dart';
import 'package:course_mania/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString('user_id');

    id == null
        ? Timer(
            const Duration(seconds: 1),
            () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignInScreen(),
              ),
            ),
          )
        : Timer(
            const Duration(seconds: 1),
            () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const TabsScreen(),
              ),
            ),
          );
  }

  @override
  void initState() {
    checkUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBlackColor,
      body: Center(
        child: SizedBox(
          height: size.height,
          width: size.width * 0.5,
          child: Image.asset(
            'images/logo-black.png',
            height: size.height,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
