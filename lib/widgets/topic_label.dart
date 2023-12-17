import 'package:bkforum/core/app_export.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class TopicLabel extends StatelessWidget {
  final String id;
  final String name;

  TopicLabel({required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.all(10.adaptSize),
      decoration: BoxDecoration(
          color: Color.fromRGBO(Random().nextInt(64)+64, Random().nextInt(64)+64,
              Random().nextInt(64)+64, 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.adaptSize))),
      child: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
      ),
    );
  }
}
