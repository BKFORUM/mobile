import '../controller/page_message_controller.dart';
import 'package:get/get.dart';

/// A binding class for the PageMessageScreen.
///
/// This class ensures that the PageMessageController is created when the
/// PageMessageScreen is first loaded.
class PageMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PageMessageController());
  }
}
