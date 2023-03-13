import 'package:course_mania/blocs/order/order_bloc.dart';
import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/cubits/user_cubit.dart';
import 'package:course_mania/models/playlist_model.dart';
import 'package:course_mania/models/user_model.dart';
import 'package:course_mania/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderListTile extends StatelessWidget {
  final PlaylistModel playlist;

  const OrderListTile({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: kHintColor.withOpacity(0.2),
        contentPadding: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        leading: CircleAvatar(
          radius: 30.0,
          backgroundColor: kTransparentColor,
          backgroundImage: const AssetImage('images/coursethumbnail1.png'),
        ),
        title: Text(
          playlist.playlistName,
          softWrap: true,
          style: kTextStyle.copyWith(
            color: kHintColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: BlocBuilder<UserCubit, List<UserModel>>(
          builder: (context, userState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...userState.map(((user) {
                  if (playlist.fkUserId == user.userId) {
                    return Text(
                      'By ${user.userName}',
                      style: kTextStyle.copyWith(
                        color: kTextColor,
                      ),
                    );
                  }
                  return Container();
                })).toList(),
                Row(
                  children: [
                    Text(
                      playlist.rating,
                      style: kTextStyle.copyWith(
                        color: const Color(0xFFF5B400),
                      ),
                    ),
                    const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFF5B400),
                    ),
                    Text(
                      '(564 ratings)',
                      style: kTextStyle.copyWith(
                        color: kTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '\$ ${playlist.cost}',
              style: kTextStyle.copyWith(
                color: kHintColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is OrderLoading) {
                  return const CustomCircularProgressIndicator();
                }
                if (state is OrderLoaded) {
                  return GestureDetector(
                    onTap: () {
                      BlocProvider.of<OrderBloc>(context)
                          .add(OrderProductRemoved(playlist));
                      Fluttertoast.showToast(
                        msg: "Item removed from cart.",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: kBlackColor,
                        textColor: kHintColor,
                        fontSize: 16.0,
                      );
                    },
                    child: Icon(
                      Icons.delete,
                      color: kHintColor,
                    ),
                  );
                } else {
                  return const Text('Something went wrong.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
