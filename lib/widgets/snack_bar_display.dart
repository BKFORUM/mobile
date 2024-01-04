import 'package:flutter/material.dart';

class SnackBarDisplay extends StatelessWidget {
  const SnackBarDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Displaying a SnackBar',
      home: Scaffold(
        backgroundColor: (Colors.grey),
        appBar: AppBar(
          title: const Text('Displaying a SnackBar'),
          backgroundColor: Colors.black12,
        ),
        body: Text("HELLO")
      ),
    );
  }
}