import 'package:course_mania/locale/locales.dart';
import 'package:course_mania/screens/chat_screen.dart';
import 'package:course_mania/screens/video_screen.dart';
import 'package:course_mania/screens/profile_screen.dart';
import 'package:course_mania/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/screens/home_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  static const routeName = '/tabs';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> pages = [
      {
        'page': const HomeScreen(),
        'title': AppLocalizations.of(context)!.homeText!,
        'icon': Icons.home_outlined,
      },
      {
        'page': const VideoScreen(),
        'title': AppLocalizations.of(context)!.course!,
        'icon': Icons.library_books_outlined,
      },
      {
        'page': const WishlistScreen(),
        'title': AppLocalizations.of(context)!.wishlist!,
        'icon': Icons.favorite_outline,
      },
      {
        'page': const ChatScreen(),
        'title': AppLocalizations.of(context)!.chat!,
        'icon': Icons.chat_outlined,
      },
      {
        'page': const ProfileScreen(),
        'title': AppLocalizations.of(context)!.profile!,
        'icon': Icons.person_outline,
      },
    ];
    return Scaffold(
      backgroundColor: kBlackColor,
      body: pages[_selectedPageIndex]['page'],
      bottomNavigationBar: Container(
        color: kBlackColor,
        child: Container(
          decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            child: GNav(
              selectedIndex: _selectedPageIndex,
              onTabChange: _selectPage,
              rippleColor: kHintColor.withOpacity(0.4),
              gap: 8,
              backgroundColor: kPrimaryColor,
              color: kHintColor,
              activeColor: kHintColor,
              tabBackgroundColor: kHintColor.withOpacity(0.2),
              padding: const EdgeInsets.all(16),
              tabs: [
                GButton(
                  icon: pages[0]['icon'],
                  text: pages[_selectedPageIndex]['title'],
                ),
                GButton(
                  icon: pages[1]['icon'],
                  text: pages[_selectedPageIndex]['title'],
                ),
                GButton(
                  icon: pages[2]['icon'],
                  text: pages[_selectedPageIndex]['title'],
                ),
                GButton(
                  icon: pages[3]['icon'],
                  text: pages[_selectedPageIndex]['title'],
                ),
                GButton(
                  icon: pages[4]['icon'],
                  text: pages[_selectedPageIndex]['title'],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
