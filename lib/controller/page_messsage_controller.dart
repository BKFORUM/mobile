import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/apiClient/conversation_api_client.dart';
import 'package:bkforum/data/models/data_prop/conversation.dart';
import 'package:bkforum/data/models/data_prop/message.dart';
import 'package:bkforum/data/models/data_prop/on_message.dart';
import 'package:bkforum/data/socket/socket.dart';

class PageMessageController extends GetxController{
  ConversationAPIClient conversationAPIClient = ConversationAPIClient();
  final conversations = <Conversation>[].obs;
  final messages = <Message>[].obs;
  Map<String, int> mapConversation = {};
  @override
  void onInit() async{
    super.onInit();
    await getAllConversation();
    for(int i =0; i< conversations.length; i++){
      print(conversations[i].lastMessage?.content.toString());
      mapConversation[conversations[i].id.toString()] = i; 
    }
    SocketIO().addCallBack("onMessage",((data) => callback(data)));
  }

  @override
  void onClose() async{
    super.onClose();
  }

  void callback (dynamic data){
    OnMessage msg = OnMessage.fromJson(data);
    int index = mapConversation[msg.conversationId.toString()] ?? 0;
    print(msg.content);
    conversations[index].lastMessage?.content = msg.content; 
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