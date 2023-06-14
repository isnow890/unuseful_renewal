import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unuseful/common/component/custom_calendar.dart';
import 'package:unuseful/common/component/custom_circular_progress_indicator.dart';
import 'package:unuseful/common/layout/default_layout.dart';
import 'package:unuseful/hit_schedule/component/schedule_card.dart';
import 'package:unuseful/hit_schedule/component/today_banner.dart';
import 'package:unuseful/hit_schedule/model/hit_schedule_for_event_model.dart';
import 'package:unuseful/hit_schedule/model/hit_schedule_model.dart';
import 'package:unuseful/hit_schedule/provider/hit_schedule_for_event_provider.dart';
import 'package:unuseful/hit_schedule/provider/hit_schedule_provider.dart';
import 'package:unuseful/hit_schedule/provider/hit_schedule_selected_day_provider.dart';

class HitScheduleScreen extends ConsumerStatefulWidget {
  static String get routeName => 'hitSchedule';

  const HitScheduleScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HitScheduleScreen> createState() => _HitScheduleScreenState();
}

class _HitScheduleScreenState extends ConsumerState<HitScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedDay = ref.watch(hitScheduleSelectedDayProvider);

    final event = ref.watch(hitSheduleForEventNotifierProvider);
    var eventList = HitScheduleForEventModel(data: null);
    var eventsLinkedHashMap =
        LinkedHashMap<DateTime?, HitScheduleForEventListModel>(
            equals: isSameDay);

    var map = <DateTime?, HitScheduleForEventListModel>{};

    if (event is HitScheduleForEventModel) {
      eventList = event;

      for (var i in eventList.data!) {
        map.addAll({i.scheduleDate: i});
      }
      eventsLinkedHashMap.addAll(map);
    }

    return DefaultLayout(
      title: Text('HitSchedule'),
      child: Column(
        children: [
          CustomCalendar(
            events: eventsLinkedHashMap,
            selectedDay: selectedDay,
            focusedDay: selectedDay,
            onDaySelected: (selectedDay, focusedDay) {
              ref
                  .read(hitScheduleSelectedDayProvider.notifier)
                  .update((state) => selectedDay);
            },
          ),
          SizedBox(
            height: 8,
          ),
          TodayBanner(),
          SizedBox(
            height: 8,
          ),
          Expanded(child: _ScheduleList()),
        ],
      ),
    );
  }
}

class _ScheduleList extends ConsumerWidget {
  const _ScheduleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(hitScheduleSelectedDayProvider);
    final state = ref.watch(hitScheduleNotifierProvider);

    if (state is HitScheduleModelError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            state.message,
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
              onPressed: () {
                ref
                    .read(hitScheduleNotifierProvider.notifier)
                    .getHitSchedule(false);
              },
              child: Text('다시 시도')),
        ],
      );
    }

    if (state is HitScheduleModelLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: CustomCircularProgressIndicator()),
        ],
      );
    }

    final cp = state as HitScheduleModel;
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == cp.data.length)
            return const SizedBox(
              height: 5,
            );

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ScheduleCard(
              startDate: state.data[index].startDate,
              endDate: state.data[index].endDate,
              startTime: state.data[index].startTime ?? '',
              endTime: state.data[index].endTime ?? '',
              content: state.data[index].scheduleName ?? '',
              stfNm: state.data[index].stfNm ?? '',
              scheduleType: state.data[index].scheduleType ?? '',
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 8,
          );
        },
        itemCount: cp.data.length + 1);
  }
}

// class Event {
//   final DateTime? date;
//
//   Event({required this.date});
// }
