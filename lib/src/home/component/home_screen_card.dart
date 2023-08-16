import 'package:flutter/material.dart';

class HomeScreenCard extends StatelessWidget {
  const HomeScreenCard({Key? key, required this.contentWidget})
      : super(key: key);
  final Widget contentWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(
          //모서리를 둥글게 하기 위해 사용
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: Colors.grey[200],
        elevation: 6.0, //그림자 깊이`
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: contentWidget,
        ),
      ),
    );
  }
}
