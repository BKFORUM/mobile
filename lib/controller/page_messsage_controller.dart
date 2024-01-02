import 'dart:io';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/apiClient/conversation_api_client.dart';
import 'package:bkforum/data/apiClient/upload_image.dart';
import 'package:bkforum/data/apiClient/user_api_client.dart';
import 'package:bkforum/data/models/data_prop/conversation.dart';
import 'package:bkforum/data/models/data_prop/document.dart';
import 'package:bkforum/data/models/data_prop/on_message.dart';
import 'package:bkforum/data/models/user_model.dart';
import 'package:bkforum/data/socket/socket.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageMessageController extends GetxController {
  ConversationAPIClient conversationAPIClient = ConversationAPIClient();
  UserApiClient apiUserClient = UserApiClient();
  Rx<List<Conversation>> conversations = Rx(<Conversation>[].obs);
  //Rx<List<Message>> messages = Rx(<Message>[].obs);
  Rx<List<User>> users = Rx(<User>[].obs);

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
    receiveNewMessage(msg);
  }

  Future<void> receiveNewMessage(OnMessage msg) async {
    int index =
        conversations.value.indexWhere((element) => element.id == msg.conversationId);
    Conversation conversation = conversations.value.removeAt(index);
    // Update
    conversation.lastMessage = LastMessage(
      content: msg.content,
      createdAt: msg.createdAt,
      updatedAt: msg.updatedAt,
      type: msg.type,
    );
    conversation.isRead = false;
    conversations.value.insert(0, conversation);
  }

  Future<void> getAllConversation() async {
    List<Conversation> list =
        await conversationAPIClient.getConversation(skip: 0, take: 100);
    conversations.value.assignAll(list);
  }

  Future<void> geAllUser() async {
    List<User> list = await apiUserClient.getUsers(skip: 0, take: 1000);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id') ?? '';
    // ignore: unrelated_type_equality_checks
    list.removeWhere((element) => element.id == id.toString());
    users.value.assignAll(list);
  }

  Future<void> addConversation(
      String name, String fileImage, List<String> userIds) async {
    Conversation conversation = await conversationAPIClient.createConversation(
      name: name,
      imagelink: fileImage,
      userIds: userIds.toList(),
    );
    this.conversations.value.insert(0, conversation);
  }

  Future<String> getImageUrl(File x) async {
    PostDocument temp = await uploadImage(x);
    return temp.fileUrl.toString();
  }
}
