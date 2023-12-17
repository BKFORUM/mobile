import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/apiClient/profile_api.dart';
import 'package:bkforum/presentation/page_event_screen/binding/page_event_binding.dart';
import 'package:bkforum/presentation/page_event_screen/page_event_screen.dart';
import 'package:bkforum/presentation/page_setting_screen/models/page_setting_model.dart';

import '../data/models/profile_model.dart';
import '../presentation/page_friend_screen/page_friend_home.dart';
import '../presentation/page_profile_screen/page_profile_screen.dart';

/// A controller class for the PageSettingScreen.
///
/// This class manages the state of the PageSettingScreen, including the
/// current pageSettingModelObj
class PageSettingController extends GetxController {
  Rx<PageSettingModel> pageSettingModelObj = PageSettingModel().obs;
  Profile? fetchedProfile;
  openProfile(){
    ProfileApi().fetchProfile('').then((profile) {
      fetchedProfile = Profile(
          id: profile.id,
          fullName: profile.fullName,
          avatarUrl: profile.avatarUrl,
          email: profile.email,
          address: profile.address,
          faculty: profile.faculty,
          type: profile.type,
          forums: profile.forums
      );
      // print(fetchedProfile?.id);
    }).catchError((error) {
      print('Error: $error');
    });
  }
  onTapCheckProfile(Profile fetchedProfile) {
    openProfile();
    Get.to(() => PageProfileScreen(fetchedProfile),
        transition: Transition.rightToLeft);
  }

  onTapOpenFriendPage() {
    Get.toNamed(
      AppRoutes.pageFriendsScreen
    );
  }

  void onTapOpenEventPage() {
    Get.to(() => PageEventScreen(),
        transition: Transition.rightToLeft,
      binding: PageEventBinding()
    );
  }
}
