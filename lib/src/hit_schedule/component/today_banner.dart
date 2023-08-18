import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/hit_schedule/model/hit_schedule_model.dart';
import 'package:unuseful/src/hit_schedule/provider/hit_schedule_provider.dart';
import 'package:unuseful/src/hit_schedule/provider/hit_schedule_selected_day_provider.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

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
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    final selectedDay = ref.watch(hitScheduleSelectedDayProvider);

    var defaultTextStyle = theme.typo.body1;

    if (selectedDay.weekday == DateTime.saturday) {
      defaultTextStyle = defaultTextStyle.copyWith(color: Colors.blue);
    } else if (selectedDay.weekday == DateTime.sunday) {
      defaultTextStyle = defaultTextStyle.copyWith(color: Colors.red);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: theme.color.hintContainer,
        ),
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
                style: defaultTextStyle,
              ),
              Text(
                '${count}개',
                style: defaultTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
