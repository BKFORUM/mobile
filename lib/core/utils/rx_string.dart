import 'package:bkforum/core/app_export.dart';

// ignore: non_constant_identifier_names
Rx<String>? PointerToRx (dynamic s){
  if(s==null) {
    return null;
  }
  return Rx(s);
}