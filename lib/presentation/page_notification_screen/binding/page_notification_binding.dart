import '../controller/page_notification_controller.dart';
import 'package:get/get.dart';

/// A binding class for the PageNotificationScreen.
///
/// This class ensures that the PageNotificationController is created when the
/// PageNotificationScreen is first loaded.
class PageNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PageNotificationController());
  }
}
