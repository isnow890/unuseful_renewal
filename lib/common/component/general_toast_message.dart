import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(
    {required String msg,
    Color? backgroundColor,
    double? fontSize,
    Color? textColor,
    Toast? toastLength}) {
  Fluttertoast.showToast(
    msg: msg,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: backgroundColor ?? Colors.grey[700],
    fontSize: fontSize ?? 15,
    textColor: textColor ?? Colors.white,
    toastLength: toastLength ?? Toast.LENGTH_SHORT,
  );
}
