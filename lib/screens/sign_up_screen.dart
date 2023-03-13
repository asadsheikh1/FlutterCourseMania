import 'package:course_mania/cubits/user_cubit.dart';
import 'package:course_mania/models/user_model.dart';
import 'package:course_mania/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/screens/sign_in_screen.dart';
import 'package:course_mania/widgets/button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const routeName = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  void signUp(String name, String email, String phone, String password) async {
    try {
      Response response = await post(
        Uri.parse('http://127.0.0.1:5000/user/add'),
        body: {
          'user_name': name,
          'email': email,
          'phone': phone,
          'user_password': password,
        },
      );
      if (response.statusCode == 201) {
        clear();
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  void clear() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: kBlackColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'logo',
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              'images/logo-black.png',
                              scale: 5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                return "Enter your full name";
                              } else {
                                return null;
                              }
                            },
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Full Name',
                              hintText: 'John Smith',
                              floatingLabelStyle: TextStyle(color: kWhiteColor),
                              hintStyle: TextStyle(color: kTextColor),
                              labelStyle: TextStyle(color: kTextColor),
                              suffixIcon: Icon(
                                Icons.person,
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
                                hintStyle: TextStyle(color: kTextColor),
                                labelStyle: TextStyle(color: kTextColor),
                                suffixIcon: Icon(
                                  Icons.phone,
                                  color: kTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                      .hasMatch(value)) {
                                return "Use the standard username format, like name@example.com";
                              } else {
                                return null;
                              }
                            },
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Email Address',
                              hintText: 'example@example.com',
                              floatingLabelStyle: TextStyle(color: kWhiteColor),
                              hintStyle: TextStyle(color: kTextColor),
                              labelStyle: TextStyle(color: kTextColor),
                              suffixIcon: Icon(
                                Icons.email,
                                color: kTextColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter a password";
                              } else if (value.length < 6) {
                                return "Password should be more than 6 characters long";
                              } else {
                                return null;
                              }
                            },
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Password',
                              floatingLabelStyle: TextStyle(color: kWhiteColor),
                              hintStyle: TextStyle(color: kTextColor),
                              labelStyle: TextStyle(color: kTextColor),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passwordObscure = !passwordObscure;
                                  });
                                },
                                icon: Icon(
                                  passwordObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: kTextColor,
                                ),
                              ),
                            ),
                            obscureText: passwordObscure,
                            enableSuggestions: false,
                            autocorrect: false,
                          ),
                        ),
                        BlocBuilder<UserCubit, List<UserModel>>(
                          builder: (context, userState) {
                            if (userState.isEmpty) {
                              return const CustomCircularProgressIndicator();
                            } else {
                              return Button(
                                buttontext: 'Sign Up',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    signUp(
                                      nameController.text,
                                      emailController.text,
                                      phoneController.text,
                                      passwordController.text,
                                    );

                                    context.read<UserCubit>().user;

                                    Fluttertoast.showToast(
                                      msg: "Account created successfully",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: kBlackColor,
                                      textColor: kHintColor,
                                      fontSize: 16.0,
                                    );
                                  }
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already Have an Account? ',
                        style: kTextStyle.copyWith(
                            color: kHintColor, fontSize: 14.0),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(SignInScreen.routeName);
                        },
                        child: Text(
                          'Sign In',
                          style: kTextStyle.copyWith(
                            color: kWhiteColor,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
