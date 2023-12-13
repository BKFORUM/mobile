import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketIO {
  Future<IO.Socket> initSocket() async {
    String yourtoken =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyYzIzZTFlLTZhNjQtNGI1Ny04MTk0LTM1NDYzMDYzYjEyZiIsInNlc3Npb24iOiIkMmIkMTAkN3cvRno5bi9OZDVKUUt4LkVaQjBmLm8yS1c2ZTNqa2NuZTRKemVVdEk3NHpoRjNBRnlyOUsiLCJlbWFpbCI6IjEwMjIwMDE1NUBzdjEuZHV0LnVkbi52biIsImZ1bGxOYW1lIjoiTmd1eeG7hW4gVsSDbiBUaOG7i25oIiwicm9sZXMiOlsiVVNFUiJdLCJhdmF0YXJVcmwiOiJodHRwOi8vcmVzLmNsb3VkaW5hcnkuY29tL2R5N2hlNmdieS9pbWFnZS91cGxvYWQvdjE3MDE3ODgyNzMveHRycWdzZWhycndyMmF3Z2drdmQuanBnIiwiaWF0IjoxNzAyMjk0NzcwLCJleHAiOjE3MDIzMDE5NzB9.D0dhhfwsyfNVLdypEMP0pHUdy2U7GfKx4vlvH83HAGA";

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
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyYzIzZTFlLTZhNjQtNGI1Ny04MTk0LTM1NDYzMDYzYjEyZiIsInNlc3Npb24iOiIkMmIkMTAkN3cvRno5bi9OZDVKUUt4LkVaQjBmLm8yS1c2ZTNqa2NuZTRKemVVdEk3NHpoRjNBRnlyOUsiLCJlbWFpbCI6IjEwMjIwMDE1NUBzdjEuZHV0LnVkbi52biIsImZ1bGxOYW1lIjoiTmd1eeG7hW4gVsSDbiBUaOG7i25oIiwicm9sZXMiOlsiVVNFUiJdLCJhdmF0YXJVcmwiOiJodHRwOi8vcmVzLmNsb3VkaW5hcnkuY29tL2R5N2hlNmdieS9pbWFnZS91cGxvYWQvdjE3MDE3ODgyNzMveHRycWdzZWhycndyMmF3Z2drdmQuanBnIiwiaWF0IjoxNzAyMjk0NzcwLCJleHAiOjE3MDIzMDE5NzB9.D0dhhfwsyfNVLdypEMP0pHUdy2U7GfKx4vlvH83HAGA";
    WebSocketChannel channel =
        IOWebSocketChannel.connect(Uri.parse("wss://52.139.152.154"), headers: {
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
    StreamBuilder(
      stream: channel.stream,
       builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Text('Connection closed.');
          }

          if (snapshot.hasData) {
            // Process the received data here
            return Text('Received: ${snapshot.data}');
          }

          return Text('Waiting for data...');
        },
    );
  }
}
