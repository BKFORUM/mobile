import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/apiClient/conversation_api_client.dart';
import 'package:bkforum/data/apiClient/user_api_client.dart';
import 'package:bkforum/data/models/data_prop/conversation.dart';
import 'package:bkforum/data/models/data_prop/message.dart';
import 'package:bkforum/data/models/user_model.dart';
import 'package:bkforum/data/socket/socket.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageMessageDetailController extends GetxController{
  ConversationAPIClient conversationAPIClient = ConversationAPIClient();
  UserApiClient apiUserClient = UserApiClient();

  PageMessageDetailController({required this.conversation});
  final messages = <Message>[].obs;
  final Conversation conversation;
  List<UserConversation> listUser = <UserConversation>[].obs;
  List<User> listUserOutsideOfForum = <User>[].obs;

  String myId = '';
  
  @override
  void onInit() async{
    super.onInit();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    this.myId = preferences.getString('id') ?? '';
    getMessageInConversation();
    getUsersInConversation();
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

  Future<void> getUsersOutsideOfForum() async {
    await getUsersInConversation();
    List<User> list = await apiUserClient.getUsers(take: 100000);
    List<String> listID = list.map((e) => e.id.toString()).toList();
    for(UserConversation u in listUser){
      if(listID.contains(u.user?.id.toString())){
        // ignore: unrelated_type_equality_checks
        list.removeWhere((element) => element.id == u.user?.id.toString());
      }
    }
    this.listUserOutsideOfForum.assignAll(list);
  }

  Future<void> addUsersToConversation(List<String> userIds) async {
    await conversationAPIClient.addUsersToConversation(
      conversationID: conversation.id.toString(), 
      userIDs: userIds
    );
    List<User> listTemp = this.listUserOutsideOfForum;
    listTemp.removeWhere((element) => userIds.contains(element.id.toString()));
    listUserOutsideOfForum.assignAll(listTemp);
  }

  Future<void> getUsersInConversation() async {
    List<UserConversation> list = await conversationAPIClient.getUsersInConversation(
      conversationID: conversation.id.toString()
    );
    listUser.assignAll(list);
  }
}