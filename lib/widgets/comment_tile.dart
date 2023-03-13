// import 'package:course_mania/constants/constant.dart';
// import 'package:course_mania/cubits/user_cubit.dart';
// import 'package:course_mania/models/comment_model.dart';
// import 'package:course_mania/models/user_model.dart';
// import 'package:course_mania/widgets/custom_circular_progress_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CommentTile extends StatelessWidget {
//   final CommentModel comment;
//   final int index;

//   const CommentTile({
//     super.key,
//     required this.comment,
//     required this.index,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<UserCubit, List<UserModel>>(
//       builder: (context, userState) {
//         if (userState.isEmpty) {
//           return const CustomCircularProgressIndicator();
//         }
//         return Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               color: kHintColor.withOpacity(0.2),
//             ),
//             child: ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: kHintColor.withOpacity(0.2),
//                 child: Center(
//                   child: Text(
//                     'A',
//                     style: kTextStyle.copyWith(
//                       color: kHintColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               title: Text('Asad'),
//               subtitle: Text(
//                 comment.commentDescription,
//                 style: kTextStyle.copyWith(color: kHintColor),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
