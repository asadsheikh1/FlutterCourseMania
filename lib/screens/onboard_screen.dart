import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/screens/sign_in_screen.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});
  static const routeName = '/on-board';

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndexPage = 0;
  String buttonText = 'Next';
  double percent = 0.34;

  List<Map<String, dynamic>> sliderList = [
    {
      "icon": 'images/onboard1.png',
      "title": 'Welcome To Course Mania',
      "description":
          'Lorem ipsum dolor sit amet, consectetuer adipisci elit, sed diam nonummy nibh euismod tincidunt u laoreet dolore magna aliquam erat volutpat. Ut wi',
    },
    {
      "icon": 'images/onboard2.png',
      "title": 'Explore Your New Skill',
      "description":
          'Lorem ipsum dolor sit amet, consectetuer adipisci elit, sed diam nonummy nibh euismod tincidunt u laoreet dolore magna aliquam erat volutpat. Ut wi',
    },
    {
      "icon": 'images/onboard3.png',
      "title": 'Ready To Find A Course?',
      "description":
          'Lorem ipsum dolor sit amet, consectetuer adipisci elit, sed diam nonummy nibh euismod tincidunt u laoreet dolore magna aliquam erat volutpat. Ut wi',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kWhiteColor),
        backgroundColor: kBlackColor,
        elevation: 0.0,
        actions: [
          const SizedBox(width: 20.0),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(SignInScreen.routeName);
              },
              child: Text(
                'Skip',
                style: GoogleFonts.dmSans(
                  fontSize: 16.0,
                  color: kTextColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 30.0),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                height: 550,
                width: 340,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    PageView.builder(
                      itemCount: sliderList.length,
                      controller: pageController,
                      onPageChanged: (int index) => currentIndexPage = index,
                      itemBuilder: (_, index) {
                        return Column(
                          children: [
                            Image.asset(
                              sliderList[index]['icon'],
                              fit: BoxFit.fill,
                              height: 340,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                top: 15.0,
                                bottom: 15.0,
                              ),
                              child: Text(
                                sliderList[index]['title'],
                                style: GoogleFonts.jost(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: kWhiteColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: SizedBox(
                                child: Text(
                                  sliderList[index]['description'],
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                  style: GoogleFonts.jost(
                                    fontSize: 15.0,
                                    color: kTextColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            CircularPercentIndicator(
              radius: 50.0,
              lineWidth: 5.0,
              progressColor: kHintColor,
              percent: percent,
              animation: true,
              center: GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndexPage < 2
                        ? percent = percent + 0.33
                        : percent = 1.0;
                    currentIndexPage < 2
                        ? pageController.nextPage(
                            duration: const Duration(microseconds: 3000),
                            curve: Curves.bounceInOut)
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInScreen(),
                            ),
                          );
                  });
                },
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: kHintColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.keyboard_double_arrow_right_sharp,
                    color: kCardBackgroundColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
