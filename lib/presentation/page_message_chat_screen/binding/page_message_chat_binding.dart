import '../controller/page_message_chat_controller.dart';
import 'package:get/get.dart';

/// A binding class for the PageMessageChatScreen.
///
/// This class ensures that the PageMessageChatController is created when the
/// PageMessageChatScreen is first loaded.
class PageMessageChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PageMessageChatController());
  }
}
