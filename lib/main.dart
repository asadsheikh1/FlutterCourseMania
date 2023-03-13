import 'package:course_mania/blocs/order/order_bloc.dart';
import 'package:course_mania/constants/component.dart';
import 'package:course_mania/cubits/language_cubit.dart';
import 'package:course_mania/cubits/playlist_cubit.dart';
import 'package:course_mania/cubits/subscription_cubit.dart';
import 'package:course_mania/cubits/theme_cubit.dart';
import 'package:course_mania/cubits/user_cubit.dart';
import 'package:course_mania/locale/locales.dart';
import 'package:course_mania/screens/onboard_screen.dart';
import 'package:course_mania/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/cubits/category_cubit.dart';
import 'package:course_mania/cubits/video_cubit.dart';
import 'package:course_mania/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );

  // print('User granted permission: ${settings.authorizationStatus}');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit()..getCurrentTheme(),
        ),
        BlocProvider<LanguageCubit>(
          create: (context) => LanguageCubit()..getCurrentLanguage(),
        ),
        BlocProvider(
          create: (context) => OrderBloc()..add(OrderStarted()),
        ),
        BlocProvider<UserCubit>(
          create: (context) => UserCubit()..user,
        ),
        BlocProvider<CategoryCubit>(
          create: (context) => CategoryCubit()..category,
        ),
        BlocProvider<VideoCubit>(
          create: (context) => VideoCubit()..video,
        ),
        BlocProvider<PlaylistCubit>(
          create: (context) => PlaylistCubit()..playlist,
        ),
        // BlocProvider<CommentCubit>(
        //   create: (context) => CommentCubit()..comment,
        // ),
        BlocProvider<SubscriptionCubit>(
          create: (context) => SubscriptionCubit()..subscription,
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (_, theme) => BlocBuilder<LanguageCubit, Locale>(
          builder: (_, locale) => MaterialApp(
            localizationsDelegates: const [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.getSupportedLocales(),
            locale: locale,
            // theme: theme,
            color: kPrimaryColor,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                },
              ),
              textTheme: Theme.of(context).textTheme.copyWith(
                    subtitle1: TextStyle(color: kWhiteColor),
                  ),
            ),
            title: 'Course Mania',
            initialRoute: initScreen == 0 || initScreen == null
                ? OnBoardScreen.routeName
                : SplashScreen.routeName,
            // initialRoute: TabsScreen.routeName,
            builder: EasyLoading.init(),
            routes: PageRoutes().routes(),
          ),
        ),
      ),
    );
  }
}
