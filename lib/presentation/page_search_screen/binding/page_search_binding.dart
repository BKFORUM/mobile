import '../controller/page_search_controller.dart';
import 'package:get/get.dart';

/// A binding class for the PageSearchScreen.
///
/// This class ensures that the PageSearchController is created when the
/// PageSearchScreen is first loaded.
class PageSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PageSearchController());
  }
}