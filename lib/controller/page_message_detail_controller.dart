import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/apiClient/conversation_api_client.dart';
import 'package:bkforum/data/models/data_prop/conversation.dart';
import 'package:bkforum/data/models/data_prop/message.dart';
import 'package:bkforum/data/socket/socket.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageMessageDetailController extends GetxController{
  ConversationAPIClient conversationAPIClient = ConversationAPIClient();
  PageMessageDetailController({required this.conversation});
  final messages = <Message>[].obs;
  final Conversation conversation;
  String myId = '';
  
  @override
  void onInit() async{
    super.onInit();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    this.myId = preferences.getString('id') ?? '';
    getMessageInConversation();
    SocketIO().addCallBack("onMessage",((data) => callback(data)));
  }

  @override
  void onClose() async{
    super.onClose();
  }

  void callback (dynamic data){
    Message msg = Message.fromJson(data);
    print(msg.content);
    messages.insert(0, msg);
  }

  Future<void> getMessageInConversation() async {
    List<Message> list = await conversationAPIClient.getMessagesInConversation(id: conversation.id.toString(), skip: 0, take: 100);
    messages.assignAll(list);
  }

  Future<void> sendMessage(String content) async {
    Message msg = await conversationAPIClient.createMessageInConversation(id: conversation.id.toString(), content: content);
    //messages.insert(0, msg);
  }
}