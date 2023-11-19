import 'package:bkforum/presentation/page_friends_screen/controller/page_friends_controller.dart';
import 'package:get/get.dart';

/// A binding class for the PageForumtwoScreen.
///
/// This class ensures that the PageForumtwoController is created when the
/// PageForumtwoScreen is first loaded.
class PageFriendsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PageFriendsController());
  }
}
