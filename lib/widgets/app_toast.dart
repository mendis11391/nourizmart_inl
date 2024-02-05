import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToast {
  static Future<void> show(
      String? message, Color bgColor, Color textColor) async {
    Fluttertoast.showToast(
        msg: message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor,
        textColor: textColor,
        fontSize: 16.0);
  }
}
