import '../../../controller/page_post_controller.dart';
import 'package:get/get.dart';

/// A binding class for the PagePostScreen.
///
/// This class ensures that the PagePostController is created when the
/// PagePostScreen is first loaded.
class PagePostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PagePostController());
  }
}
