import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/const/colors.dart';

class ScheduleCard extends StatelessWidget {
  final String startTime;
  final String endTime;
  final String content;

  final DateTime startDate;
  final DateTime endDate;

  const ScheduleCard({
    Key? key,
    required this.startTime,
    required this.endTime,
    required this.content,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: PRIMARY_COLOR,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Date(startDate: startDate, endDate: endDate),
              SizedBox(
                width: 16.0,
              ),
              _Content(
                content: content,
              ),
              // Category(color: color),
            ],
          ),
        ),
      ),
    );
  }
}

class _Date extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;

  const _Date({Key? key, required this.startDate, required this.endDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: PRIMARY_COLOR,
      fontSize: 12.0,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Text(
          DateFormat('yyyy-MM-dd').format(startDate),
          style: textStyle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '~',
              style: textStyle,
            ),
          ],
        ),
        Text(DateFormat('yyyy-MM-dd').format(endDate), style: textStyle),
      ],
    );
  }
}

class _Time extends StatelessWidget {
  final String startTime;
  final String endTime;

  const _Time({required this.startTime, required this.endTime, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: PRIMARY_COLOR,
      fontSize: 16.0,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${startTime.toString().padLeft(2, '0')}:00',
          style: textStyle,
        ),
        Text('${endTime.toString().padLeft(2, '0')}:00',
            style: textStyle.copyWith(fontSize: 10.0)),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final String content;

  const _Content({required this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Text(content),
      ),
    );
  }
}

class Category extends StatelessWidget {
  final Color color;

  const Category({required this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      width: 16.0,
      height: 16.0,
    );
  }
}
