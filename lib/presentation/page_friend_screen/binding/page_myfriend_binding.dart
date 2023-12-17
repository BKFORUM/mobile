import 'package:bkforum/controller/page_friend_controller.dart';
import 'package:bkforum/core/app_export.dart';

class PageMyFriendBinding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut(() => PageFriendController());
  }
}