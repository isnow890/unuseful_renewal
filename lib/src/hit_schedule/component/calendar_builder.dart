
import 'package:flutter/material.dart';

class CalendarBuilder extends StatelessWidget {
  final DateTime day;
  final DateTime focusedDay;
  final Decoration decoration;
  final Color? textColor;
  final FontWeight? fontWeight;

  const CalendarBuilder(
      {Key? key,
        required this.day,
        required this.focusedDay,
        required this.decoration,
        this.textColor,
        this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      child: Container(
        padding: EdgeInsets.only(top: 1, bottom: 1),
        width: MediaQuery.of(context).size.width,
        decoration: decoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              day.day.toString(),
              style: TextStyle(
                  fontSize: 13, color: textColor, fontWeight: fontWeight),
            ),
            Expanded(child: Text("")),
            // Text(moneyString,
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: 12, color: nowIndexColor[900]),),
          ],
        ),
      ),
    );
  }
}
