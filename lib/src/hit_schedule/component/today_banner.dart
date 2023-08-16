import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/hit_schedule/model/hit_schedule_model.dart';
import 'package:unuseful/src/hit_schedule/provider/hit_schedule_provider.dart';
import 'package:unuseful/src/hit_schedule/provider/hit_schedule_selected_day_provider.dart';

import '../../../colors.dart';

class TodayBanner extends ConsumerWidget {
  const TodayBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hitScheduleNotifierProvider);

    var tmpInt = 0;
    if (state is HitScheduleModelLoading || state is HitScheduleModelError) {
    } else {
      tmpInt = (state as HitScheduleModel).data.length;
    }
    return _TodayBanner(count: tmpInt);
  }
}

class _TodayBanner extends ConsumerWidget {
  int count;

  _TodayBanner({required this.count, Key? key}) : super(key: key);

  @override
  final textStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontSize: 13.0,
  );

  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(hitScheduleSelectedDayProvider);
    return Container(
      color: PRIMARY_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일',
              style: textStyle,
            ),
            Text('${count}개',style: textStyle),
          ],
        ),
      ),
    );
  }
}
