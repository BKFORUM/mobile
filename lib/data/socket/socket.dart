import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketIO {
  Future<IO.Socket> initSocket() async {
    String yourtoken =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyYzIzZTFlLTZhNjQtNGI1Ny04MTk0LTM1NDYzMDYzYjEyZiIsInNlc3Npb24iOiIkMmIkMTAkVEJQYS9FT0ZyQmh1Tm9RYWF1Ym5vZTZvY3FPLnJ6MlhLUFBLOWF0ZDdsbk9XWGlPWFN0MUsiLCJlbWFpbCI6IjEwMjIwMDE1NUBzdjEuZHV0LnVkbi52biIsImZ1bGxOYW1lIjoiTmd1eeG7hW4gVsSDbiBUaOG7i25oIiwicm9sZXMiOlsiVVNFUiJdLCJhdmF0YXJVcmwiOiJodHRwOi8vcmVzLmNsb3VkaW5hcnkuY29tL2R5N2hlNmdieS9pbWFnZS91cGxvYWQvdjE3MDE3ODgyNzMveHRycWdzZWhycndyMmF3Z2drdmQuanBnIiwiaWF0IjoxNzAyMTAxNzAzLCJleHAiOjE3MDIxMDg5MDN9.lmGu_tdb6ZAXsQV6FwGbc-hMjufc-dwIbV_fEERoryU";

    IO.Socket socket = IO.io(
        '52.139.152.154',
        OptionBuilder()
            .setExtraHeaders({'Authorization': 'Bearer $yourtoken'}) // optional
            .build());

    socket.on('connect', (_) {
      print('Socket connected');
    });

    socket.on('connect_error', (err) {
      print('Connection error: $err');
    });
    return socket;
  }

  // ignore: non_constant_identifier_names
  void ConnectSocketIO() async {
    // final preferences = await SharedPreferences.getInstance();
    // String yourtoken = preferences.getString('accessToken') ?? '';
    String yourtoken =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyYzIzZTFlLTZhNjQtNGI1Ny04MTk0LTM1NDYzMDYzYjEyZiIsInNlc3Npb24iOiIkMmIkMTAkdVR0NUJudnQueW1yeGg3L2ZFY2N6dXViVFVITm1UVmJweDFDeS8yeE9aT0VuVndDa1F2MkciLCJlbWFpbCI6IjEwMjIwMDE1NUBzdjEuZHV0LnVkbi52biIsImZ1bGxOYW1lIjoiTmd1eeG7hW4gVsSDbiBUaOG7i25oIiwicm9sZXMiOlsiVVNFUiJdLCJhdmF0YXJVcmwiOiJodHRwOi8vcmVzLmNsb3VkaW5hcnkuY29tL2R5N2hlNmdieS9pbWFnZS91cGxvYWQvdjE3MDE3ODgyNzMveHRycWdzZWhycndyMmF3Z2drdmQuanBnIiwiaWF0IjoxNzAyMTAzNTk1LCJleHAiOjE3MDIxMTA3OTV9.ID0WXiwlSgSbBINcJXqskkRKt_mLgtSg-KEg-JBRoyo";
    WebSocketChannel channel =
        IOWebSocketChannel.connect("ws://52.139.152.154/", headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $yourtoken'
    });
    channel.stream.listen(
      (dynamic message) {
        print('message $message');
      },
      onDone: () {
        print('ws channel closed');
      },
      onError: (error) {
        print('ws error $error');
      },
    );
  }
}
