import 'package:flutter/material.dart';

import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/screens/phone_authentication_screen.dart';
import 'package:course_mania/widgets/button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const routeName = '/forgot-password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kBlackColor),
        title: Text(
          'Forgot Password',
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Email Address',
                          hintText: 'example@example.com',
                          floatingLabelStyle: TextStyle(color: kWhiteColor),
                          hintStyle: TextStyle(color: kTextColor),
                          labelStyle: TextStyle(color: kTextColor),
                          suffixIcon: Icon(
                            Icons.email,
                            color: kTextColor,
                          ),
                        ),
                      ),
                    ),
                    Button(
                      buttontext: 'Reset Password',
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                            PhoneAuthenticationScreen.routeName);
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
