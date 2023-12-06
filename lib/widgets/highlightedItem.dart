import 'package:bkforum/core/app_export.dart';
import 'package:flutter/material.dart';

class HighlightedItem extends StatelessWidget {
  final Widget child;

  HighlightedItem({required this.child});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.adaptSize),
        padding: EdgeInsets.symmetric(vertical: 8.adaptSize, horizontal: 12.adaptSize),
        decoration: BoxDecoration(
          // color: Colors.blue.shade100,
          borderRadius: BorderRadiusGeometry.lerp(
            BorderRadius.circular(10),
            BorderRadius.circular(20),
            0.5,
          ),
        ),
        child: child,
      ),
    );
  }
}