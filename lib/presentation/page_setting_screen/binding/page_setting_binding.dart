import '../controller/page_setting_controller.dart';
import 'package:get/get.dart';

/// A binding class for the PageSettingScreen.
///
/// This class ensures that the PageSettingController is created when the
/// PageSettingScreen is first loaded.
class PageSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PageSettingController());
  }
}
