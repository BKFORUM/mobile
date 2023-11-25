import 'package:bkforum/presentation/page_login_screen/page_login_screen.dart';
import 'package:bkforum/presentation/page_login_screen/binding/page_login_binding.dart';
import 'package:bkforum/presentation/page_feed_screen/page_feed_screen.dart';
import 'package:bkforum/presentation/page_feed_screen/binding/page_feed_binding.dart';

import 'package:bkforum/presentation/page_search_screen/page_search_screen.dart';
import 'package:bkforum/presentation/page_search_screen/binding/page_search_binding.dart';

import 'package:bkforum/presentation/page_forumone_screen/page_forumone_screen.dart';
import 'package:bkforum/presentation/page_forumone_screen/binding/page_forumone_binding.dart';

import 'package:bkforum/presentation/page_message_screen/page_message_screen.dart';
import 'package:bkforum/presentation/page_message_screen/binding/page_message_binding.dart';
import 'package:bkforum/presentation/page_message_chat_screen/page_message_chat_screen.dart';
import 'package:bkforum/presentation/page_message_chat_screen/binding/page_message_chat_binding.dart';
import 'package:bkforum/presentation/page_post_screen/page_post_screen.dart';
import 'package:bkforum/presentation/page_post_screen/binding/page_post_binding.dart';
import 'package:bkforum/presentation/page_notification_screen/page_notification_screen.dart';
import 'package:bkforum/presentation/page_notification_screen/binding/page_notification_binding.dart';
import 'package:bkforum/presentation/page_setting_screen/page_setting_screen.dart';
import 'package:bkforum/presentation/page_setting_screen/binding/page_setting_binding.dart';
import 'package:bkforum/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:bkforum/presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/apiClient/apiLogin.dart';

class AppRoutes {
  static const String pageLoginScreen = '/page_login_screen';

  static const String pageFeedScreen = '/page_feed_screen';

  static const String pageForumoneScreen = '/page_forumone_screen';

  static const String pageSearchSreen = '/page_search_screen';

  static const String pageForumtwoScreen = '/page_forumtwo_screen';

  static const String pageMessageScreen = '/page_message_screen';

  static const String pageMessageChatScreen = '/page_message_chat_screen';

  static const String pagePostScreen = '/page_post_screen';

  static const String pageNotificationScreen = '/page_notification_screen';

  static const String pageSettingScreen = '/page_setting_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static List<GetPage> pages = [
    GetPage(
      name: pageLoginScreen,
      page: () => PageLoginScreen(),
      bindings: [
        PageLoginBinding(),
      ],
    ),
    GetPage(
      name: pageFeedScreen,
      page: () => PageFeedScreen(),
      bindings: [
        PageFeedBinding(),
      ],
    ),
    GetPage(
      name: pageSearchSreen,
      page: () => PageSearchScreen(),
      bindings: [
        PageSearchBinding(),
      ],
    ),
    GetPage(
      name: pageForumoneScreen,
      page: () => PageForumoneScreen(),
      bindings: [
        PageForumoneBinding(),
      ],
    ),

    GetPage(
      name: pageMessageScreen,
      page: () => PageMessageScreen(),
      bindings: [
        PageMessageBinding(),
      ],
    ),
    GetPage(
      name: pageMessageChatScreen,
      page: () => PageMessageChatScreen(),
      bindings: [
        PageMessageChatBinding(),
      ],
    ),
    GetPage(
      name: pagePostScreen,
      page: () => PagePostScreen(),
      bindings: [
        PagePostBinding(),
      ],
    ),
    GetPage(
      name: pageNotificationScreen,
      page: () => PageNotificationScreen(),
      bindings: [
        PageNotificationBinding(),
      ],
    ),
    GetPage(
      name: pageSettingScreen,
      page: () => PageSettingScreen(),
      bindings: [
        PageSettingBinding(),
      ],
    ),
    GetPage(
      name: appNavigationScreen,
      page: () => AppNavigationScreen(),
      bindings: [
        AppNavigationBinding(),
      ],
    ),
    GetPage(
      name: initialRoute,
      page: () {
        return FutureBuilder<bool>(
          future: checkTokenAndNavigate(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              if (snapshot.hasData && snapshot.data!) {

                return PageFeedScreen();
              } else {
                return PageLoginScreen();
              }
            }
          },
        );
      },
      bindings: [
        PageLoginBinding(),
        PageFeedBinding()
      ],
    )
  ];
}

Future<bool> checkTokenAndNavigate() async {
  final preferences = await SharedPreferences.getInstance();
  final isLoggedIn = preferences.getBool('isLoggedIn') ?? false;
  final email = preferences.getString('email') ?? '';
  final password = preferences.getString('password') ?? '';
  if (isLoggedIn){
    LoginApiClient().login(email, password);
  }
  return isLoggedIn;
}
