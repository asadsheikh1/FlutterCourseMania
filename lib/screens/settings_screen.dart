import 'package:course_mania/config/app_config.dart';
import 'package:course_mania/cubits/language_cubit.dart';
import 'package:course_mania/cubits/theme_cubit.dart';
import 'package:course_mania/locale/locales.dart';
import 'package:course_mania/widgets/button.dart';
import 'package:flutter/material.dart';

import 'package:course_mania/constants/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeList {
  final String? title;
  final String? subtitle;

  ThemeList({this.title, this.subtitle});
}

class LanguageList {
  final String? title;

  LanguageList({this.title});
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  static const routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool sliderValue = false;
  late LanguageCubit _languageCubit;
  late ThemeCubit _themeCubit;
  String? selectedLocal;
  String? selectedTheme;

  @override
  void initState() {
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
    _themeCubit = BlocProvider.of<ThemeCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final List<ThemeList> themes = <ThemeList>[
      ThemeList(
        title: AppLocalizations.of(context)!.darkMode,
        subtitle: AppLocalizations.of(context)!.darkText,
      ),
      ThemeList(
        title: AppLocalizations.of(context)!.lightMode,
        subtitle: AppLocalizations.of(context)!.lightText,
      ),
    ];
    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
        backgroundColor: kBlackColor,
        title: Text(
          AppLocalizations.of(context)!.settings!,
          style: kTextStyle.copyWith(color: kHintColor),
        ),
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 30,
            color: kHintColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                height: 57.7,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.display!,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: kTextColor,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.08,
                        fontSize: 17),
                  ),
                ),
              ),
              BlocBuilder<ThemeCubit, ThemeData>(builder: (_, theme) {
                sliderValue = _themeCubit.isDark;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: ListTile(
                    title: Text(
                      locale.darkMode!,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 18.3,
                          color: Theme.of(context).secondaryHeaderColor,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      themes[1].subtitle!,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.blueGrey),
                    ),
                    trailing: Switch(
                      value: sliderValue,
                      onChanged: (value) => _themeCubit.setTheme(value),
                    ),
                  ),
                );
              }),
              Container(
                height: 58.0,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.selectLanguage!,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: kTextColor,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.08,
                          fontSize: 17,
                        ),
                  ),
                ),
              ),
              BlocBuilder<LanguageCubit, Locale>(
                builder: (context, currentLocale) {
                  selectedLocal ??= currentLocale.languageCode;
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: AppConfig.languagesSupported.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => RadioListTile(
                      value: AppConfig.languagesSupported.keys.elementAt(index),
                      groupValue: selectedLocal,
                      title: Text(
                        AppConfig
                            .languagesSupported[AppConfig
                                .languagesSupported.keys
                                .elementAt(index)]!
                            .name,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onChanged: (langCode) =>
                          setState(() => selectedLocal = langCode as String),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 100,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Button(
                  buttontext: 'Submit',
                  onPressed: () {
                    _languageCubit.setCurrentLanguage(selectedLocal!, true);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
