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
  List<UserConversation> listUser = <UserConversation>[].obs;
  String myId = '';
  
  @override
  void onInit() async{
    super.onInit();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    this.myId = preferences.getString('id') ?? '';
    getMessageInConversation();
    initListUser();
    SocketIO.socket.on("onMessage", callback);
  }

  @override
  void onClose() async{
    SocketIO.socket.off("onMessage", callback);
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
    await conversationAPIClient.createMessageInConversation(id: conversation.id.toString(), content: content);
    //messages.insert(0, msg);
  }

  Future<void> changeDisplayName(String content, String userID) async {
    await conversationAPIClient.changeDisplayName(
      conversationID: conversation.id.toString(), 
      userID: userID, 
      content: content
    );
    int index = listUser.indexWhere((element) => element.userId == userID);
    UserConversation user = listUser.elementAt(index);
    user.displayName = content;
    listUser[index] = user;
  }

  void initListUser(){
    if(conversation.users != null) {
      for(int i=0; i<conversation.users!.length; i++){
        UserConversation temp = conversation.users![i];
        listUser.add(temp);
      }
    }
  }
}