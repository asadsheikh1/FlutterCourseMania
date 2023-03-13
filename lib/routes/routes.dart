import 'package:course_mania/screens/add_new_playlist_screen.dart';
import 'package:course_mania/screens/edit_profile_screen.dart';
import 'package:course_mania/screens/image_viewer_screen.dart';
import 'package:course_mania/screens/settings_screen.dart';
import 'package:course_mania/screens/splash_screen.dart';
import 'package:course_mania/screens/video_player_screen.dart';
import 'package:flutter/material.dart';

import 'package:course_mania/screens/chat_screen.dart';
import 'package:course_mania/screens/checkout_screen.dart';
import 'package:course_mania/screens/video_detail_screen.dart';
import 'package:course_mania/screens/order_screen.dart';
import 'package:course_mania/screens/payment_successful_screen.dart';
import 'package:course_mania/screens/profile_screen.dart';
import 'package:course_mania/screens/forgot_password_screen.dart';
import 'package:course_mania/screens/home_screen.dart';
import 'package:course_mania/screens/notification_permission_screen.dart';
import 'package:course_mania/screens/onboard_screen.dart';
import 'package:course_mania/screens/phone_authentication_screen.dart';
import 'package:course_mania/screens/sign_in_screen.dart';
import 'package:course_mania/screens/sign_up_screen.dart';
import 'package:course_mania/screens/video_screen.dart';
import 'package:course_mania/screens/tabs_screen.dart';
import 'package:course_mania/screens/wishlist_screen.dart';

class PageRoutes {
  Map<String, WidgetBuilder> routes() {
    return {
      OnBoardScreen.routeName: (context) => const OnBoardScreen(),
      SplashScreen.routeName: (context) => const SplashScreen(),
      SignInScreen.routeName: (context) => const SignInScreen(),
      SignUpScreen.routeName: (context) => const SignUpScreen(),
      ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
      PhoneAuthenticationScreen.routeName: (context) =>
          const PhoneAuthenticationScreen(),
      NotificationPermissionScreen.routeName: (context) =>
          const NotificationPermissionScreen(),
      TabsScreen.routeName: (context) => const TabsScreen(),
      SettingsScreen.routeName: (context) => const SettingsScreen(),
      HomeScreen.routeName: (context) => const HomeScreen(),
      VideoScreen.routeName: (context) => const VideoScreen(),
      AddNewPlaylistScreen.routeName: (context) => const AddNewPlaylistScreen(),
      WishlistScreen.routeName: (context) => const WishlistScreen(),
      ChatScreen.routeName: (context) => const ChatScreen(),
      ProfileScreen.routeName: (context) => const ProfileScreen(),
      EditProfileScreen.routeName: (context) => const EditProfileScreen(),
      VideoDetailScreen.routeName: (context) => const VideoDetailScreen(),
      VideoPlayerScreen.routeName: (context) => const VideoPlayerScreen(),
      ImageViewerScreen.routeName: (context) => const ImageViewerScreen(),
      OrderScreen.routeName: (context) => const OrderScreen(),
      CheckoutScreen.routeName: (context) => const CheckoutScreen(),
      PaymentSuccessfullScreen.routeName: (context) =>
          const PaymentSuccessfullScreen(),
    };
  }
}
