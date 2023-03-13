import 'dart:io';

import 'package:course_mania/constants/api.dart';
import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/cubits/user_cubit.dart';
import 'package:course_mania/locale/locales.dart';
import 'package:course_mania/models/user_model.dart';
import 'package:course_mania/screens/add_new_playlist_screen.dart';
import 'package:course_mania/screens/checkout_screen.dart';
import 'package:course_mania/constants/component.dart';
import 'package:course_mania/screens/edit_profile_screen.dart';
import 'package:course_mania/screens/image_viewer_screen.dart';
import 'package:course_mania/screens/settings_screen.dart';
import 'package:course_mania/screens/sign_in_screen.dart';
import 'package:course_mania/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  uploadImage(String playlistName, File file) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("http://127.0.0.1:5000/playlist/1/upload/thumbnail"),
    );
    request.fields['thumbnail'] = "dummyImage";

    var picture = http.MultipartFile.fromBytes('thumbnail',
        (await rootBundle.load('images/instructor4.png')).buffer.asUint8List(),
        filename: 'instructor4.png');
    request.files.add(picture);
  }

  @override
  Widget build(BuildContext context) {
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
                automaticallyImplyLeading: false,
                iconTheme: const IconThemeData(color: kPrimaryColor),
                backgroundColor: kBlackColor,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  AppLocalizations.of(context)!.profile!,
                  style: kTextStyle.copyWith(color: kHintColor),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AddNewPlaylistScreen.routeName,
                    );
                  },
                  icon: const Icon(Icons.add),
                  color: kHintColor,
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        FontAwesomeIcons.solidBell,
                        color: kHintColor,
                      ),
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          ImageViewerScreen.routeName,
                        );
                      },
                      child: Hero(
                        tag: 'hero-tag',
                        child: user.avatar == null
                            ? CircleAvatar(
                                radius: 60.0,
                                backgroundColor: kTransparentColor,
                                backgroundImage: const AssetImage(
                                  'images/profile1.jpg',
                                ),
                              )
                            : CircleAvatar(
                                radius: 60.0,
                                backgroundColor: kTransparentColor,
                                backgroundImage: NetworkImage(
                                  Api().baseApi + user.avatar,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      user.userName.split(" ")[0],
                      style: kTextStyle.copyWith(
                        color: kHintColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.email,
                      style: kTextStyle.copyWith(
                        color: kTextColor,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      '${user.subscriberCount} ${AppLocalizations.of(context)!.subscribers!}',
                      style: kTextStyle.copyWith(
                        color: kHintColor,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ProfileOptions(
                      title: AppLocalizations.of(context)!.editProfile!,
                      icon: Icon(
                        Icons.edit,
                        color: kHintColor,
                      ),
                      pressed: () {
                        Navigator.of(context).pushNamed(
                          EditProfileScreen.routeName,
                        );
                      },
                    ),
                    ProfileOptions(
                      title: AppLocalizations.of(context)!.paymentDetails!,
                      icon: Icon(
                        Icons.payment,
                        color: kHintColor,
                      ),
                      pressed: () {
                        Navigator.of(context)
                            .pushNamed(CheckoutScreen.routeName);
                      },
                    ),
                    ProfileOptions(
                      title: AppLocalizations.of(context)!.notification!,
                      icon: Icon(
                        Icons.notification_add,
                        color: kHintColor,
                      ),
                      pressed: () {},
                    ),
                    ProfileOptions(
                      title: AppLocalizations.of(context)!.settings!,
                      icon: Icon(
                        Icons.settings,
                        color: kHintColor,
                      ),
                      pressed: () {
                        Navigator.of(context).pushNamed(
                          SettingsScreen.routeName,
                        );
                      },
                    ),
                    ProfileOptions(
                      title: AppLocalizations.of(context)!.logout!,
                      icon: Icon(
                        Icons.logout,
                        color: kHintColor,
                      ),
                      pressed: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.remove('user_id');

                        Navigator.of(context).pushNamedAndRemoveUntil(
                          SignInScreen.routeName,
                          (Route<dynamic> route) => false,
                        );

                        Fluttertoast.showToast(
                          msg: "Logged out successfully",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: kBlackColor,
                          textColor: kHintColor,
                          fontSize: 16.0,
                        );
                      },
                    ),
                  ],
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

class ProfileOptions extends StatelessWidget {
  final String title;
  final Icon icon;
  final VoidCallback pressed;

  const ProfileOptions({
    super.key,
    required this.title,
    required this.icon,
    required this.pressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: GestureDetector(
        onTap: pressed,
        child: Container(
          width: double.infinity,
          height: 60.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: kHintColor.withOpacity(0.2),
          ),
          child: Center(
            child: ListTile(
              leading: icon,
              title: Text(
                title,
                style: kTextStyle.copyWith(color: kHintColor),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: kHintColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
