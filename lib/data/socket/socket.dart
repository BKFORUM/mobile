
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIO {
  static late IO.Socket socket;

  void initSocket() async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    Map<String, dynamic> extraHeaders = {
      'Authorization': 'Bearer $token',
    };
    socket = IO.io(
        "ws://52.139.152.154",
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setExtraHeaders(extraHeaders)
            .build());
    socket.onConnect((_) {
      print('Connect socket');
    });
    socket.onConnectError((data) => print(data));
  }

  void listenEvent() {
    socket.on("onMessage", (data) => print(data));
  }

  void addCallBack(String event, callback (dynamic data)){
    socket.on(event, (data) => callback(data));
  }
}
