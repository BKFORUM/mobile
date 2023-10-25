import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_message_chat_screen/models/page_message_chat_model.dart';

/// A controller class for the PageMessageChatScreen.
///
/// This class manages the state of the PageMessageChatScreen, including the
/// current pageMessageChatModelObj
class PageMessageChatController extends GetxController {
  Rx<PageMessageChatModel> pageMessageChatModelObj = PageMessageChatModel().obs;
}
