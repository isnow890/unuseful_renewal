import 'package:flutter/material.dart';
import 'package:unuseful/colors.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: PRIMARY_COLOR,
    );
  }
}
