import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {

  final String title;
   TextTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
