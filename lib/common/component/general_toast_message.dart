import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Timer? _timer;

void showToast(
    {required String msg,
    Color? backgroundColor,
    double? fontSize,
    Color? textColor,
    Toast? toastLength}) {
  if (_timer?.isActive ?? false) _timer!.cancel();
  _timer = Timer(
    const Duration(milliseconds: 300),
    () {
      Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: backgroundColor ?? Colors.grey[700],
        fontSize: fontSize ?? 15,
        textColor: textColor ?? Colors.white,
        toastLength: toastLength ?? Toast.LENGTH_SHORT,
      );
    },
  );
}
