import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

import '../../../colors.dart';

class ScheduleCard extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    var tmpColor = theme.color.primary;

    if (scheduleType == 'duty')
      tmpColor = Colors.orange;
    else if (scheduleType == 'tempDuty') tmpColor = Colors.redAccent;

    return Container(
      decoration: BoxDecoration(
        color: theme.color.hintContainer,
        border: Border.all(color: theme.color.inactive, width: 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                color: tmpColor,
                width: 5,
                height: double.infinity,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
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
              _RightInfo(
                scheduleType: scheduleType,
                color: tmpColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _RightInfo extends ConsumerWidget {
  final Color color;
  final String scheduleType;

  const _RightInfo({Key? key, required this.color, required this.scheduleType})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    var tmpType = '당직';

    if (scheduleType == 'schedule') {
      tmpType = '일정';
    } else if (scheduleType == 'tempDuty') {
      tmpType = ' 당직 예정';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(tmpType,
            style: theme.typo.subtitle1.copyWith(
              fontWeight: FontWeight.w500,
            )),
      ],
    );
  }
}

class _Date extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    return Row(
      children: [
        Text(
          DateFormat('yyyy-MM-dd').format(startDate),
          style: theme.typo.body2,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          startTime,
          style: theme.typo.body2,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '~',
          style: theme.typo.body2,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(DateFormat('yyyy-MM-dd').format(endDate), style: theme.typo.body2),
        const SizedBox(
          width: 5,
        ),
        Text(
          endTime,
          style: theme.typo.body2,
        ),
      ],
    );
  }
}

class _Content extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            (scheduleType == 'schedule' ? '' : '$stfNm ') + content,
            style: theme.typo.body1,
          ),
        ),
      ],
    );
  }
}

// class Category extends StatelessWidget {
//   final Color color;
//
//   const Category({required this.color, Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: color,
//         shape: BoxShape.circle,
//       ),
//       width: 16.0,
//       height: 16.0,
//     );
//   }
// }
