
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/apiClient/conversation_api_client.dart';
import 'package:bkforum/data/models/data_prop/conversation.dart';

class PageMessageController extends GetxController{
  ConversationAPIClient conversationAPIClient = ConversationAPIClient();
  final conversations = <Conversation>[].obs;

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
}