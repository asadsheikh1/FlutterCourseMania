import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/screens/payment_successful_screen.dart';
import 'package:course_mania/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});
  static const routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kTextColor),
        backgroundColor: kBlackColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Checkout',
          style: kTextStyle.copyWith(color: kHintColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Select a Payment Method',
                  style: kTextStyle.copyWith(
                    color: kHintColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.creditCard,
                        color: kIndigoColor,
                      ),
                      title: const Text('Credit/ Debit Card'),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.paypal,
                        color: kPayPalColor,
                      ),
                      title: const Text('PayPal'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: kHintColor.withOpacity(0.2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Payment Section',
                          style: kTextStyle.copyWith(
                            color: kHintColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Card Number',
                            hintText: '0000 0000 0000 0000',
                            floatingLabelStyle: TextStyle(color: kWhiteColor),
                            hintStyle: TextStyle(color: kTextColor),
                            labelStyle: TextStyle(color: kTextColor),
                            suffixIcon: Icon(
                              FontAwesomeIcons.creditCard,
                              color: kTextColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'CVV/CVC',
                            hintText: 'CVC',
                            floatingLabelStyle: TextStyle(color: kWhiteColor),
                            hintStyle: TextStyle(color: kTextColor),
                            labelStyle: TextStyle(color: kTextColor),
                            suffixIcon: Icon(
                              Icons.payment,
                              color: kTextColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Expiry Date',
                            hintText: 'MM/YY',
                            floatingLabelStyle: TextStyle(color: kWhiteColor),
                            hintStyle: TextStyle(color: kTextColor),
                            labelStyle: TextStyle(color: kTextColor),
                            suffixIcon: Icon(
                              Icons.password,
                              color: kTextColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            // const OrderSummary(),
            Button(
              buttontext: 'Pay Now',
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(PaymentSuccessfullScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
