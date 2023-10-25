import '../controller/page_forumtwo_controller.dart';
import 'package:get/get.dart';

/// A binding class for the PageForumtwoScreen.
///
/// This class ensures that the PageForumtwoController is created when the
/// PageForumtwoScreen is first loaded.
class PageForumtwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PageForumtwoController());
  }
}
