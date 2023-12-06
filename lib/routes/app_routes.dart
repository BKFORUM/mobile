import 'package:bkforum/presentation/page_friend_screen/binding/page_myfriend_binding.dart';
import 'package:bkforum/presentation/page_friend_screen/page_friend_home.dart';
import 'package:bkforum/presentation/page_friend_screen/page_friend_request.dart';
import 'package:bkforum/presentation/page_friend_screen/page_friend_suggest.dart';
import 'package:bkforum/presentation/page_friend_screen/page_my_friend.dart';
import 'package:bkforum/presentation/page_login_screen/page_login_screen.dart';
import 'package:bkforum/presentation/page_login_screen/binding/page_login_binding.dart';
import 'package:bkforum/presentation/page_feed_screen/page_feed_screen.dart';
import 'package:bkforum/presentation/page_feed_screen/binding/page_feed_binding.dart';
import 'package:bkforum/presentation/page_message_detail_screen/binding/page_message_detail_binding.dart';
import 'package:bkforum/presentation/page_message_detail_screen/page_message_detail_screen.dart';

import 'package:bkforum/presentation/page_search_screen/page_search_screen.dart';
import 'package:bkforum/presentation/page_search_screen/binding/page_search_binding.dart';

import 'package:bkforum/presentation/page_forumone_screen/page_forumone_screen.dart';
import 'package:bkforum/presentation/page_forumone_screen/binding/page_forumone_binding.dart';

import 'package:bkforum/presentation/page_message_screen/page_message_screen.dart';
import 'package:bkforum/presentation/page_message_screen/binding/page_message_binding.dart';
import 'package:bkforum/presentation/page_post_screen/page_post_screen.dart';
import 'package:bkforum/presentation/page_post_screen/binding/page_post_binding.dart';
import 'package:bkforum/presentation/page_notification_screen/page_notification_screen.dart';
import 'package:bkforum/presentation/page_notification_screen/binding/page_notification_binding.dart';
import 'package:bkforum/presentation/page_setting_screen/page_setting_screen.dart';
import 'package:bkforum/presentation/page_setting_screen/binding/page_setting_binding.dart';
import 'package:bkforum/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:bkforum/presentation/app_navigation_screen/binding/app_navigation_binding.dart';
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

  static const String pageMessageDetailScreen = '/page_message_screen_detail';

  static const String pagePostScreen = '/page_post_screen';

  static const String pageNotificationScreen = '/page_notification_screen';

  static const String pageSettingScreen = '/page_setting_screen';

  static const String pageProfileScreen = '/page_profile_screen';

  static const String pageFriendsScreen = '/page_friends_screen';

  static const String pageFriendRequestScreen = '/page_friend_request_screen';

  static const String pageFriendSuggestScreen = '/page_friend_suggest_screen';

  static const String pageMyFriendScreen = '/page_my_friend_screen';

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
      name: pageMessageDetailScreen,
      page: () => PageMessageDetailScreen(),
      bindings: [
        PageMessageDetailBinding(),
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
      name: pageFriendsScreen,
      page: () => PageFriendsScreen(),
      bindings: [
        PageMyFriendBinding(),
      ],
    ),
     GetPage(
      name: pageFriendRequestScreen,
      page: () => PageFriendRequest(),
      bindings: [
        PageMyFriendBinding(),
      ],
    ),
     GetPage(
      name: pageFriendSuggestScreen,
      page: () => PageFriendSuggest(),
      bindings: [
        PageMyFriendBinding(),
      ],
    ),
     GetPage(
      name: pageMyFriendScreen,
      page: () => PageMyFriends(),
      bindings: [
        PageMyFriendBinding(),
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
      bindings: [PageLoginBinding(), PageFeedBinding()],
    )
  ];
}

Future<bool> checkTokenAndNavigate() async {
  final preferences = await SharedPreferences.getInstance();
  final isLoggedIn = preferences.getBool('isLoggedIn') ?? false;
  final refreshToken = preferences.getString('refreshToken') ?? '';
  if (isLoggedIn) LoginApiClient().refreshLogin(refreshToken);
  return isLoggedIn;
}
