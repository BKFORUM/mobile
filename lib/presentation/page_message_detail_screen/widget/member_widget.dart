import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/data_prop/conversation.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MemberWidget extends StatefulWidget {
  UserConversation user;
  dynamic Function(dynamic content, dynamic id) callback;
  MemberWidget({required this.user, required this.callback});

  @override
  MemberState createState() => MemberState(user: user, callback: callback);
}

class MemberState extends State<MemberWidget> {
  UserConversation user;
  dynamic Function(dynamic content, dynamic id) callback;
  MemberState({required this.user, required this.callback});
  final myController = TextEditingController();
  void goToUser() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: goToUser,
      child: Container(
        padding: EdgeInsets.fromLTRB(
            13.adaptSize, 0.adaptSize, 0.adaptSize, 15.adaptSize),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(20.adaptSize),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // ellipse4bDd (64:376)
              margin: EdgeInsets.fromLTRB(
                  0.adaptSize, 0.adaptSize, 8.adaptSize, 1.adaptSize),
              width: 56.adaptSize,
              height: 56.adaptSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45.adaptSize),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(user.user!.avatarUrl.toString()),
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: 150,
              child: Container(
                  child: user.displayName == ''
                      ? Text(
                          user.user!.fullName.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            height: 1.2175,
                            color: Color(0xff000000),
                          ),
                        )
                      : Text(
                          user.displayName.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            height: 1.2175,
                            color: Color(0xff000000),
                          ),
                        )),
            ),
            SizedBox(width: 100),
            IconButton(
                onPressed: () => {showMyDialog(context)},
                icon: Icon(Icons.edit))
          ],
        ),
      ),
    );
  }

  Future<void> showMyDialog(BuildContext context) async {
    TextEditingController textFieldController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thay đổi biệt hiệu'),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: textFieldController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Nhập biệt hiệu',
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                textFieldController.dispose();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Thay đổi'),
              onPressed: () {
                if (textFieldController.text.isNotEmpty) {
                  callback(textFieldController.text, user.userId);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
