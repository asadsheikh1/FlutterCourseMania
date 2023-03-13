import 'dart:async';
import 'dart:convert';

import 'package:course_mania/constants/component.dart';
import 'package:course_mania/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/screens/forgot_password_screen.dart';
import 'package:course_mania/screens/sign_up_screen.dart';
import 'package:course_mania/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static const routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String errorMessage = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordObscure = true;

  Future<int> signIn(String email, password) async {
    try {
      Response response = await post(
        Uri.parse('http://127.0.0.1:5000/user/login'),
        body: {
          'email': email,
          'user_password': password,
        },
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("user_id", body['user_id'].toString());
        cacheData();
        return body['user_id'];
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  @override
  void initState() {
    cacheData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isChecked = true;
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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                return "You've entered incorrect password";
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
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            direction: Axis.horizontal,
                            spacing: 20.0,
                            runSpacing: 4.0,
                            children: [
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                alignment: WrapAlignment.center,
                                direction: Axis.horizontal,
                                children: [
                                  Checkbox(
                                    value: isChecked,
                                    checkColor: kWhiteColor,
                                    fillColor:
                                        MaterialStateProperty.all(kHintColor),
                                    onChanged: (value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      'Keep me signed in',
                                      style: kTextStyle.copyWith(
                                          color: kHintColor),
                                    ),
                                  ),
                                ],
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     Navigator.of(context).pushReplacementNamed(
                              //         ForgotPasswordScreen.routeName);
                              //   },
                              //   child: Text(
                              //     'Forgot password?',
                              //     style: kTextStyle.copyWith(color: kHintColor),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Button(
                          buttontext: 'Sign In',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              int myId = await signIn(
                                emailController.text.toString(),
                                passwordController.text.toString(),
                              );

                              if (myId != 0) {
                                Fluttertoast.showToast(
                                  msg: "You're signed in",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: kBlackColor,
                                  textColor: kHintColor,
                                  fontSize: 16.0,
                                );

                                Navigator.of(context)
                                    .pushReplacementNamed(TabsScreen.routeName);
                              }
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
                        'Don\'t Have an Account? ',
                        style: kTextStyle.copyWith(
                            color: kHintColor, fontSize: 14.0),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(SignUpScreen.routeName);
                        },
                        child: Text(
                          'Register',
                          style: kTextStyle.copyWith(
                              color: kWhiteColor, fontSize: 14.0),
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

// import 'dart:async';

// import 'package:course_mania/constants/component.dart';
// import 'package:course_mania/screens/tabs_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'dart:convert';

// import 'package:email_validator/email_validator.dart';
// import 'package:course_mania/constants/constant.dart';
// import 'package:course_mania/screens/forgot_password_screen.dart';
// import 'package:course_mania/screens/sign_up_screen.dart';
// import 'package:course_mania/widgets/button.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({Key? key}) : super(key: key);
//   static const routeName = '/sign-in';

//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   String errorMessage = '';

//   Future<int> signIn(String email, password) async {
//     try {
//       Response response = await post(
//         Uri.parse('http://127.0.0.1:5000/user/login'),
//         body: {
//           'email': email,
//           'user_password': password,
//         },
//       );
//       if (response.statusCode == 200) {
//         final body = jsonDecode(response.body);
//         SharedPreferences pref = await SharedPreferences.getInstance();
//         pref.setString("user_id", body['user_id'].toString());

//         cacheData();
//         Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
//         return body['user_id'];
//       } else {
//         errorMessage = 'Could not authenticate you. Please try again later.';
//         return 0;
//       }
//     } catch (e) {
//       errorMessage = e.toString();
//       return 0;
//     }
//   }

//   String _errorMessage = '';
//   void validateEmail(String val) {
//     if (val.isEmpty) {
//       setState(() {
//         _errorMessage = "Email can't be empty";
//       });
//     } else if (!EmailValidator.validate(val, true)) {
//       setState(() {
//         _errorMessage = "Invalid email address";
//       });
//     } else {
//       setState(() {
//         _errorMessage = "";
//       });
//     }
//   }

//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     cacheData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isChecked = true;

//     return Scaffold(
//       backgroundColor: kBlackColor,
//       resizeToAvoidBottomInset: false,
//       body: Center(
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width - 40,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15.0),
//                     color: kBlackColor,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Hero(
//                           tag: 'logo',
//                           child: Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Image.asset(
//                               'images/logo-black.png',
//                               scale: 5,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: TextFormField(
//                             onChanged: (val) {
//                               validateEmail(val);
//                             },
//                             controller: emailController,
//                             keyboardType: TextInputType.emailAddress,
//                             decoration: InputDecoration(
//                               border: InputBorder.none,
//                               labelText: 'Email Address',
//                               hintText: 'example@example.com',
//                               floatingLabelStyle: TextStyle(color: kWhiteColor),
//                               hintStyle: TextStyle(color: kTextColor),
//                               labelStyle: TextStyle(color: kTextColor),
//                               suffixIcon: Icon(
//                                 Icons.email,
//                                 color: kTextColor,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: TextFormField(
//                             controller: passwordController,
//                             decoration: InputDecoration(
//                               border: InputBorder.none,
//                               labelText: 'Password',
//                               floatingLabelStyle: TextStyle(color: kWhiteColor),
//                               hintStyle: TextStyle(color: kTextColor),
//                               labelStyle: TextStyle(color: kTextColor),
//                               suffixIcon: Icon(
//                                 Icons.password,
//                                 color: kTextColor,
//                               ),
//                             ),
//                             obscureText: true,
//                             enableSuggestions: false,
//                             autocorrect: false,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             _errorMessage,
//                             style: kTextStyle.copyWith(
//                               color: Colors.red,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 10.0),
//                           child: Wrap(
//                             crossAxisAlignment: WrapCrossAlignment.center,
//                             alignment: WrapAlignment.center,
//                             direction: Axis.horizontal,
//                             spacing: 20.0,
//                             runSpacing: 4.0,
//                             children: [
//                               Wrap(
//                                 crossAxisAlignment: WrapCrossAlignment.center,
//                                 alignment: WrapAlignment.center,
//                                 direction: Axis.horizontal,
//                                 children: [
//                                   Checkbox(
//                                     value: isChecked,
//                                     checkColor: Colors.white,
//                                     fillColor:
//                                         MaterialStateProperty.all(kHintColor),
//                                     onChanged: (value) {
//                                       setState(() {
//                                         isChecked = value!;
//                                       });
//                                     },
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 10.0),
//                                     child: Text(
//                                       'Keep me Signed In',
//                                       style: kTextStyle.copyWith(
//                                           color: kHintColor),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.of(context).pushReplacementNamed(
//                                       ForgotPasswordScreen.routeName);
//                                 },
//                                 child: Text(
//                                   'Forgot Password?',
//                                   style: kTextStyle.copyWith(color: kHintColor),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Button(
//                           buttontext: 'Sign In',
//                           onPressed: () async {
//                             int myId = await signIn(
//                               emailController.text.toString(),
//                               passwordController.text.toString(),
//                             );
//                             print(myId);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Don\'t Have an Account? ',
//                         style: kTextStyle.copyWith(
//                             color: kHintColor, fontSize: 14.0),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context)
//                               .pushReplacementNamed(SignUpScreen.routeName);
//                         },
//                         child: Text(
//                           'Register',
//                           style: kTextStyle.copyWith(
//                               color: kWhiteColor, fontSize: 14.0),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
