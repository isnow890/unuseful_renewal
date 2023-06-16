import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/const/colors.dart';

class ScheduleCard extends StatelessWidget {
  final String startTime;
  final String endTime;
  final String content;

  final DateTime startDate;
  final DateTime endDate;

  final String stfNm;
  final String scheduleType;

  const ScheduleCard({
    Key? key,
    required this.startTime,
    required this.endTime,
    required this.content,
    required this.startDate,
    required this.endDate,
    required this.stfNm,
    required this.scheduleType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tmpColor = PRIMARY_COLOR;

    if (scheduleType == 'duty')
      tmpColor = Colors.orange;
    else if (scheduleType == 'tempDuty') tmpColor = Colors.redAccent;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: tmpColor,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: IntrinsicHeight(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Date(
                    startDate: startDate,
                    endDate: endDate,
                    endTime: endTime,
                    startTime: startTime,
                    color: tmpColor,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  _Content(
                    content: content,
                    scheduleType: scheduleType,
                    stfNm: stfNm,
                  ),
                ],
              ),
            ),
            Expanded(
              child: _RightInfo(
                scheduleType: scheduleType,
                color: tmpColor,
              ),
            )
          ],
        )

            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            //   children: [
            //     _Date(startDate: startDate, endDate: endDate),
            //     SizedBox(
            //       width: 16.0,
            //     ),
            //     _Content(
            //       content: content,
            //     ),
            //     // Category(color: color),
            //   ],
            // ),
            ),
      ),
    );
  }
}

class _RightInfo extends StatelessWidget {
  final Color color;
  final String scheduleType;

  const _RightInfo({Key? key, required this.color, required this.scheduleType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tmpType = '당직';

    if (scheduleType == 'schedule') {
      tmpType = '일정';
    } else if (scheduleType == 'tempDuty') {
      tmpType = ' 당직 예정';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          tmpType,
          style: TextStyle(
            fontSize: 11.0,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _Date extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final String startTime;
  final String endTime;
  final Color color;

  const _Date({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: color,
      fontSize: 12.0,
    );
    return Row(
      children: [
        Text(
          DateFormat('yyyy-MM-dd').format(startDate),
          style: textStyle,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          startTime,
          style: textStyle,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '~',
          style: textStyle,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(DateFormat('yyyy-MM-dd').format(endDate), style: textStyle),
        const SizedBox(
          width: 5,
        ),
        Text(
          endTime,
          style: textStyle,
        ),
      ],
    );
  }
}

//
// class _Date extends StatelessWidget {
//   final DateTime startDate;
//   final DateTime endDate;
//
//   const _Date({Key? key, required this.startDate, required this.endDate})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final textStyle = TextStyle(
//       fontWeight: FontWeight.w600,
//       color: PRIMARY_COLOR,
//       fontSize: 12.0,
//     );
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           DateFormat('yyyy-MM-dd').format(startDate),
//           style: textStyle,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               '~',
//               style: textStyle,
//             ),
//           ],
//         ),
//         Text(DateFormat('yyyy-MM-dd').format(endDate), style: textStyle),
//       ],
//     );
//   }
// }

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
  final String scheduleType;
  final String stfNm;

  const _Content({
    required this.content,
    Key? key,
    required this.scheduleType,
    required this.stfNm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child:
              Text((scheduleType == 'schedule' ? '' : '${stfNm} ') + content),
        ),
      ],
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
