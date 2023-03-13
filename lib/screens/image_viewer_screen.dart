import 'package:course_mania/constants/api.dart';
import 'package:course_mania/constants/component.dart';
import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/cubits/user_cubit.dart';
import 'package:course_mania/models/user_model.dart';
import 'package:course_mania/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImageViewerScreen extends StatelessWidget {
  const ImageViewerScreen({super.key});
  static const routeName = '/image-viewer';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocBuilder<UserCubit, List<UserModel>>(
      builder: (context, userState) {
        if (userState.isEmpty) {
          return const CustomCircularProgressIndicator();
        }
        for (UserModel user in userState) {
          if (user.userId.toString() == id) {
            return Scaffold(
              backgroundColor: kBlackColor,
              appBar: AppBar(
                iconTheme: const IconThemeData(color: kPrimaryColor),
                backgroundColor: kBlackColor,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  'Profile',
                  style: kTextStyle.copyWith(color: kHintColor),
                ),
                leading: IconButton(
                  icon: const Icon(FontAwesomeIcons.arrowLeft),
                  color: kTextColor,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: SizedBox(
                height: size.height * 0.8,
                child: Hero(
                  tag: 'hero-tag',
                  child: InteractiveViewer(
                    panEnabled: true,
                    boundaryMargin: const EdgeInsets.all(80),
                    minScale: 1,
                    maxScale: 4,
                    child: user.avatar == null
                        ? Image.asset(
                            'images/profile1.jpg',
                          )
                        : Image.network(
                            Api().baseApi + user.avatar,
                          ),
                  ),
                ),
              ),
            );
          }
        }
        return Container();
      },
    );
  }
}
