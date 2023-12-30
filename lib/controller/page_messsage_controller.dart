import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/apiClient/conversation_api_client.dart';
import 'package:bkforum/data/apiClient/user_api_client.dart';
import 'package:bkforum/data/models/data_prop/conversation.dart';
import 'package:bkforum/data/models/data_prop/message.dart';
import 'package:bkforum/data/models/data_prop/on_message.dart';
import 'package:bkforum/data/models/user_model.dart';
import 'package:bkforum/data/socket/socket.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageMessageController extends GetxController {
  ConversationAPIClient conversationAPIClient = ConversationAPIClient();
  UserApiClient apiUserClient = UserApiClient();
  final conversations = <Conversation>[].obs;
  final messages = <Message>[].obs;
  final users = <User>[].obs;

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
    Conversation conversation =  conversations.removeAt(index);
    // Update
    conversation.lastMessage = LastMessage(
      content: msg.content,
      createdAt: msg.createdAt,
      updatedAt: msg.updatedAt,
      type: msg.type,
    );
    conversation.isRead = false;
    conversations.insert(0, conversation);
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

  Future<void> geAllUser() async {
    List<User> list = await apiUserClient.getUsers(skip: 0, take: 1000);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id') ?? '';
    // ignore: unrelated_type_equality_checks
    list.removeWhere((element) => element.id == id.toString());
    users.assignAll(list);
  }

  Future<void> addConversation(
      String name, String imageLink, List<String> userIds) async {
    Conversation conversation = await conversationAPIClient.createConversation(
      name: name,
      imagelink: imageLink,
      userIds: userIds.toList(),
    );
    this.conversations.insert(0, conversation);
  }
}
