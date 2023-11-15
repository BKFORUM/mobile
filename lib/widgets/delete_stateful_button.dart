import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CancelButton extends StatefulWidget {
  final Function onPressed;

  CancelButton({required this.onPressed});

  @override
  _CancelButtonState createState() => _CancelButtonState();
}

class _CancelButtonState extends State<CancelButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isPressed = !isPressed;
        });
        widget.onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isPressed ? Colors.red.withOpacity(0.8) : Colors.transparent,
        ),
        padding: EdgeInsets.all(6),
        child: Icon(
          Icons.cancel,
          color: Colors.red,
        ),
      ),
    );
  }
}