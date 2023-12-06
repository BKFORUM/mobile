import 'package:bkforum/controller/page_message_detail_controller.dart';
import 'package:get/get.dart';

class PageMessageDetailBinding extends Bindings {
  PageMessageDetailBinding();

  @override
  void dependencies() {
    String temp = Get.parameters['id'] ?? '';
    Get.lazyPut(() => PageMessageDetailController(id: temp));
  }
}
