import '../../../controller/page_forumone_controller.dart';
import 'package:get/get.dart';

/// A binding class for the PageForumoneScreen.
///
/// This class ensures that the PageForumoneController is created when the
/// PageForumoneScreen is first loaded.
class PageForumoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PageForumoneController());
  }
}
