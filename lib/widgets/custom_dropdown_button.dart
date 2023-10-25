import 'package:bkforum/core/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
// class DropdownMenuExample extends StatefulWidget {
//   DropdownMenuExample({
//     Key? key,
//
//     this.dropdownColor,
//     this.padding,
//     this.style,
//     this.focusColor,
//     this.borderRadius,
//   }) : super(
//           key: key,
//         );
//
//   final Color? dropdownColor;
//   final EdgeInsetsGeometry? padding;
//   final TextStyle? style;
//   final Color? focusColor;
//   final BorderRadius? borderRadius;
//
//   @override
//   State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
//
// }
class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({
    Key? key,

    this.dropdownColor,
    this.padding,
    this.style,
    this.focusColor,
    this.borderRadius,
    this.hint,
  }): super(
    key: key,
  );
  final Color? dropdownColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final Color? focusColor;
  final BorderRadius? borderRadius;
  final Widget? hint;
  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 8,
      style: CustomTextStyles.titleMediumHelvetica18,
      dropdownColor: widget.dropdownColor,
      padding: EdgeInsets.fromLTRB(3.h, 2.v, 3 .h, 2.v),
      focusColor: CupertinoColors.opaqueSeparator,
      borderRadius: BorderRadiusStyle.circleBorder20,
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}