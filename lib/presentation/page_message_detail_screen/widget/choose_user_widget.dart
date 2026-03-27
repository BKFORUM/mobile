import 'package:bkforum/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:bkforum/data/models/user_model.dart';

// ignore: must_be_immutable
class ChooseUserWidget extends StatefulWidget {
  User user;
  dynamic Function(String content) callbackAdd;
  dynamic Function(String content) callbackDelete;
  ChooseUserWidget(
      {required this.user,
      required this.callbackAdd,
      required this.callbackDelete});

  @override
  ChooseUserState createState() => ChooseUserState(
      user: user, callbackAdd: callbackAdd, callbackDelete: callbackDelete);
}

class ChooseUserState extends State<ChooseUserWidget> {
  User user;
  dynamic Function(String content) callbackAdd;
  dynamic Function(String content) callbackDelete;
  ChooseUserState(
      {required this.user,
      required this.callbackAdd,
      required this.callbackDelete});
  final myController = TextEditingController();
  void goToUser() {}

  bool checkValue = false;

  void oncheckValueChanged(bool? newValue) => setState(() {
        checkValue = newValue!;
        if (checkValue) {
          callbackAdd(user.id.toString());
        } else {
          callbackDelete(user.id.toString());
        }
      });

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
                  image: NetworkImage(user.avatarUrl.toString()),
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: 150,
              child: Container(
                child: Text(
                  user.fullName.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.2175,
                    color: Color(0xff000000),
                  ),
                ),
              ),
            ),
            SizedBox(width: 100),
            Checkbox(
              value: checkValue,
              onChanged: oncheckValueChanged,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              activeColor: Color(0xff0001cb),
              checkColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
