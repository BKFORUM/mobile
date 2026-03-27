import 'package:bkforum/controller/page_message_detail_controller.dart';
import 'package:bkforum/data/models/data_prop/conversation.dart';
import 'package:get/get.dart';

class PageMessageDetailBinding extends Bindings {
  PageMessageDetailBinding();

  @override
  void dependencies() {
    final Conversation conversation = Get.arguments as Conversation;
    Get.lazyPut(() => PageMessageDetailController(conversation: conversation));
  }
}
