// import 'package:course_mania/blocs/order/order_bloc.dart';
// import 'package:course_mania/constants/constant.dart';
// import 'package:flutter/material.dart';

// class OrderSummary extends StatelessWidget {
//   final OrderLoaded orders;

//   const OrderSummary({super.key, required this.orders});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         padding: const EdgeInsets.all(10.0),
//         decoration: BoxDecoration(
//           color: kHintColor.withOpacity(0.2),
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Order Summary',
//                 style: kTextStyle.copyWith(
//                   color: kHintColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Text(
//                     'Course:',
//                     style: kTextStyle.copyWith(color: kTextColor),
//                   ),
//                   const Spacer(),
//                   Text(
//                     '02',
//                     style: kTextStyle.copyWith(color: kTextColor),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Text(
//                     'Subtotal:',
//                     style: kTextStyle.copyWith(color: kTextColor),
//                   ),
//                   const Spacer(),
//                   Text(
//                     orders.order.subTotalString,
//                     style: kTextStyle.copyWith(color: kTextColor),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Text(
//                     'Total:',
//                     style: kTextStyle.copyWith(
//                         color: kHintColor, fontWeight: FontWeight.bold),
//                   ),
//                   const Spacer(),
//                   Text(
//                     '\$112.99',
//                     style: kTextStyle.copyWith(
//                         color: kHintColor, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
