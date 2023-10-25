import '../controller/page_feed_controller.dart';
import 'package:get/get.dart';

/// A binding class for the PageFeedScreen.
///
/// This class ensures that the PageFeedController is created when the
/// PageFeedScreen is first loaded.
class PageFeedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PageFeedController());
  }
}
