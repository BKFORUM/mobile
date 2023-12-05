import 'package:bkforum/controller/page_message_detail_controller.dart';
import 'package:get/get.dart';

/// A binding class for the PageMessageScreen.
///
/// This class ensures that the PageMessageController is created when the
/// PageMessageScreen is first loaded.
class PageMessageDetailBinding extends Bindings {
  String id;
  PageMessageDetailBinding({required this.id});

  @override
  void dependencies() {
    Get.lazyPut(() => PageMessageDetailController(id: id));
  }
}
