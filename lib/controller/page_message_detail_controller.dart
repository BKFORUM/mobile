import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/apiClient/conversation_api_client.dart';
import 'package:bkforum/data/models/data_prop/message.dart';

class PageMessageDetailController extends GetxController{
  ConversationAPIClient conversationAPIClient = ConversationAPIClient();
  final messages = <Message>[].obs;
  
  @override
  void onInit() async{
    super.onInit();
  }

  @override
  void onClose() async{
    super.onClose();
  }
  Future<void> getMessageInConversation(String id) async {
    List<Message> list = await conversationAPIClient.getMessagesInConversation(id: id, skip: 0, take: 100);
    messages.assignAll(list);
  }
}