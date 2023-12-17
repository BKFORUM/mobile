
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/apiClient/conversation_api_client.dart';
import 'package:bkforum/data/models/data_prop/conversation.dart';
import 'package:bkforum/data/models/data_prop/message.dart';

class PageMessageController extends GetxController{
  ConversationAPIClient conversationAPIClient = ConversationAPIClient();
  final conversations = <Conversation>[].obs;
  final messages = <Message>[].obs;
  @override
  void onInit() async{
    super.onInit();
    await getAllConversation();
  }

  @override
  void onClose() async{
    super.onClose();
  }

  Future<void> getAllConversation() async {
    List<Conversation> list = await conversationAPIClient.getConversation(skip: 0, take: 100);
    conversations.assignAll(list);
  }

  Future<void> getMessageInConversation(String id) async {
    List<Message> list = await conversationAPIClient.getMessagesInConversation(id: id, skip: 0, take: 100);
    messages.assignAll(list);
  }
  
}