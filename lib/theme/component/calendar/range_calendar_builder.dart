import 'package:flutter/material.dart';
import 'package:unuseful/theme/res/layout.dart';

class RangeCalendarBuilder extends StatelessWidget {
  final DateTime day;
  final DateTime focusedDay;
  final Decoration decoration;
  final Color? textColor;
  final FontWeight? fontWeight;

  const RangeCalendarBuilder(
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
      width: 30,
      decoration: decoration,
      child:
          Center(
            child: Text(
              day.day.toString(),
              style: TextStyle(
                  fontSize: context.layout(15.0, tablet: 18, desktop: 18),
                  color: textColor,
                  fontWeight: fontWeight),
            ),
          ),
      );
  }
}
