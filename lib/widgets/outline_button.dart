import 'package:flutter/material.dart';

import 'package:course_mania/constants/constant.dart';

class OutlineButton extends StatelessWidget {
  final String buttontext;
  final VoidCallback onPressed;

  const OutlineButton({
    super.key,
    required this.buttontext,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          gradient: LinearGradient(
            colors: [
              kBlackColor,
              kBlackColor,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: kCyanColor.withOpacity(0.6),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(-2, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            buttontext,
            style: kTextStyle.copyWith(
              fontSize: 20.0,
              color: kHintColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
