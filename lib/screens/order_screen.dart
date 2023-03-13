import 'package:course_mania/blocs/order/order_bloc.dart';
import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/locale/locales.dart';
import 'package:course_mania/screens/checkout_screen.dart';
import 'package:course_mania/widgets/custom_circular_progress_indicator.dart';
import 'package:course_mania/widgets/order_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:course_mania/widgets/button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  static const routeName = '/order';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBlackColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kTextColor),
        backgroundColor: kBlackColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.orders!,
          style: kTextStyle.copyWith(color: kHintColor),
        ),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const CustomCircularProgressIndicator();
          }
          if (state is OrderLoaded) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.63,
                    child: state.order.playlists.isNotEmpty
                        ? ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return OrderListTile(
                                playlist: state.order
                                    .productQuantity(state.order.playlists)
                                    .keys
                                    .elementAt(index),
                              );
                            },
                            itemCount: state.order
                                .productQuantity(state.order.playlists)
                                .keys
                                .length,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.shoppingCart,
                                color: kTextColor,
                                size: 120,
                              ),
                              const SizedBox(height: 40),
                              Text(
                                AppLocalizations.of(context)!.noItems!,
                                style: kTextStyle.copyWith(
                                  color: kTextColor,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                  ),
                  Container(
                    color: kBlackColor,
                    height: size.height * 0.37,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: kHintColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    AppLocalizations.of(context)!.orderSummary!,
                                    style: kTextStyle.copyWith(
                                      color: kHintColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.sub!,
                                        style: kTextStyle.copyWith(
                                            color: kTextColor),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '\$ ${state.order.subTotalString}',
                                        style: kTextStyle.copyWith(
                                            color: kTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.total!,
                                        style: kTextStyle.copyWith(
                                            color: kHintColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '\$ ${state.order.totalString}',
                                        style: kTextStyle.copyWith(
                                            color: kHintColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Button(
                            buttontext: AppLocalizations.of(context)!.checkout!,
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(CheckoutScreen.routeName);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text('Something went wrong.');
          }
        },
      ),
    );
  }
}
