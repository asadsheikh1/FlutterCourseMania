import 'package:course_mania/constants/constant.dart';
import 'package:course_mania/locale/locales.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const routeName = '/chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlackColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: kTextColor),
          backgroundColor: kBlackColor,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.chat!,
            style: kTextStyle.copyWith(color: kHintColor),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chat),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  tileColor: kHintColor.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  title: Text(
                    'Ali Muhammad',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kHintColor,
                    ),
                  ),
                  subtitle: Text(
                    'Can you send me DM project?',
                    style: TextStyle(
                      color: kTextColor,
                    ),
                  ),
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: kTransparentColor,
                    backgroundImage: const AssetImage('images/profile1.jpg'),
                  ),
                  trailing: Text(
                    '10.00 AM',
                    style: TextStyle(
                      color: kTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
