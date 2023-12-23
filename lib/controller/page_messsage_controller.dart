import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/apiClient/conversation_api_client.dart';
import 'package:bkforum/data/models/data_prop/conversation.dart';
import 'package:bkforum/data/models/data_prop/message.dart';
import 'package:bkforum/data/models/data_prop/on_message.dart';
import 'package:bkforum/data/socket/socket.dart';

class PageMessageController extends GetxController {
  ConversationAPIClient conversationAPIClient = ConversationAPIClient();
  final conversations = <Conversation>[].obs;
  final messages = <Message>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getAllConversation();
    SocketIO.socket.on("onMessage", ((data) => callback(data)));
  }

  @override
  void onClose() async {
    SocketIO.socket.off("onMessage", ((data) => callback(data)));
    super.onClose();
  }

  Future<void> callback(dynamic data) async {
    OnMessage msg = OnMessage.fromJson(data);
    //int index = mapConversation[msg.conversationId.toString()] ?? 0;
    await receiveNewMessage(msg);
  }

  Future<void> receiveNewMessage(OnMessage msg) async {
    int index = conversations.indexWhere((element) => element.id == msg.conversationId);
    Conversation conversation = conversations[index];
    conversations.remove(conversation);
    update(conversations);
    conversation.lastMessage = LastMessage(
      content: msg.content,
      createdAt: msg.createdAt,
      updatedAt: msg.updatedAt,
      type: msg.type,
    );
    conversation.isRead = false;
    conversations.insert(0,conversation);
    update(conversations);
  }

  Future<void> getAllConversation() async {
    List<Conversation> list =
        await conversationAPIClient.getConversation(skip: 0, take: 100);
    conversations.assignAll(list);
  }

  Future<void> getMessageInConversation(String id) async {
    List<Message> list = await conversationAPIClient.getMessagesInConversation(
        id: id, skip: 0, take: 100);
    messages.assignAll(list);
  }
}
