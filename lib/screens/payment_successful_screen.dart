import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

import 'package:course_mania/widgets/button.dart';

class PaymentSuccessfullScreen extends StatefulWidget {
  const PaymentSuccessfullScreen({super.key});
  static const routeName = '/payment-successful';

  @override
  State<PaymentSuccessfullScreen> createState() =>
      _PaymentSuccessfullScreenState();
}

class _PaymentSuccessfullScreenState extends State<PaymentSuccessfullScreen> {
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
          'Payment Successful',
          style: kTextStyle.copyWith(color: kHintColor),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset('images/paymentsuccess.png'),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Thank you for choosing us. Start learning now.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: kTextStyle.copyWith(
                    color: kWhiteColor,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                child: Button(
                  buttontext: 'Go to Home',
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(TabsScreen.routeName);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
