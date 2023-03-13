import 'package:course_mania/constants/api.dart';
import 'package:course_mania/constants/component.dart';
import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/cubits/user_cubit.dart';
import 'package:course_mania/models/user_model.dart';
import 'package:course_mania/widgets/button.dart';
import 'package:course_mania/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  static const routeName = '/edit-profile';

  @override
  State<EditProfileScreen> createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController dobController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void edit(String dob, String location, String phone) async {
    try {
      Response response = await post(
        Uri.parse('http://127.0.0.1:5000/user/patch/$id'),
        body: {
          'dob': dob,
          'location': location,
          'phone': phone,
        },
      );
      if (response.statusCode == 201 || response.statusCode == 202) {
        clear();
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  void clear() {
    dobController.clear();
    locationController.clear();
    phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kBlackColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kTextColor),
        backgroundColor: kBlackColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: kTextStyle.copyWith(color: kHintColor),
        ),
      ),
      body: BlocBuilder<UserCubit, List<UserModel>>(
        builder: (context, userState) {
          if (userState.isEmpty) {
            return const CustomCircularProgressIndicator();
          }
          for (UserModel user in userState) {
            if (user.userId.toString() == id) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: kBlackColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20.0),
                              Hero(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Full Name:',
                                              style: kTextStyle.copyWith(
                                                color: kTextColor,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              user.userName.toString(),
                                              style: kTextStyle.copyWith(
                                                color: kHintColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Email:',
                                              style: kTextStyle.copyWith(
                                                color: kTextColor,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              user.email,
                                              style: kTextStyle.copyWith(
                                                color: kHintColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Phone:',
                                              style: kTextStyle.copyWith(
                                                color: kTextColor,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              user.phone != null
                                                  ? user.phone.toString()
                                                  : 'Not defined',
                                              style: kTextStyle.copyWith(
                                                color: kHintColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Date of Birth:',
                                              style: kTextStyle.copyWith(
                                                color: kTextColor,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              user.dob ?? 'Not defined',
                                              style: kTextStyle.copyWith(
                                                color: kHintColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Location:',
                                              style: kTextStyle.copyWith(
                                                color: kTextColor,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              user.location != null
                                                  ? user.location.toString()
                                                  : 'Not defined',
                                              style: kTextStyle.copyWith(
                                                color: kHintColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Subscriber count:',
                                              style: kTextStyle.copyWith(
                                                color: kTextColor,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              user.subscriberCount.toString(),
                                              style: kTextStyle.copyWith(
                                                color: kHintColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextFormField(
                                        controller: dobController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'Date of Birth',
                                          hintText: '2000-12-31',
                                          floatingLabelStyle:
                                              TextStyle(color: kWhiteColor),
                                          hintStyle:
                                              TextStyle(color: kTextColor),
                                          labelStyle:
                                              TextStyle(color: kTextColor),
                                          suffixIcon: Icon(
                                            Icons.date_range,
                                            color: kTextColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextFormField(
                                        controller: locationController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'Location',
                                          hintText: 'Karachi, Pakistan',
                                          floatingLabelStyle:
                                              TextStyle(color: kWhiteColor),
                                          hintStyle:
                                              TextStyle(color: kTextColor),
                                          labelStyle:
                                              TextStyle(color: kTextColor),
                                          suffixIcon: Icon(
                                            Icons.location_pin,
                                            color: kTextColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SizedBox(
                                        height: 60.0,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
                                                    .hasMatch(value)) {
                                              return "Enter your phone number";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: phoneController,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            labelText: 'Phone Number',
                                            hintText: '+92-333-1112001',
                                            floatingLabelStyle:
                                                TextStyle(color: kWhiteColor),
                                            hintStyle:
                                                TextStyle(color: kTextColor),
                                            labelStyle:
                                                TextStyle(color: kTextColor),
                                            suffixIcon: Icon(
                                              Icons.phone,
                                              color: kTextColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        alignment: WrapAlignment.center,
                                        direction: Axis.horizontal,
                                        spacing: 20.0,
                                        runSpacing: 4.0,
                                        children: const [],
                                      ),
                                    ),
                                    Button(
                                      buttontext: 'Save',
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          edit(
                                            dobController.text.toString(),
                                            locationController.text.toString(),
                                            phoneController.text.toString(),
                                          );

                                          context.read<UserCubit>().user;

                                          Fluttertoast.showToast(
                                            msg:
                                                "Information saved successfully",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: kBlackColor,
                                            textColor: kHintColor,
                                            fontSize: 16.0,
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}
