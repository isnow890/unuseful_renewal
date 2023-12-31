import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unuseful/theme/component/calendar/calendar_builder.dart';
import 'package:unuseful/src/hit_schedule/model/hit_schedule_for_event_model.dart';
import 'package:unuseful/theme/res/layout.dart';

import '../../../theme/component/calendar/custom_calendar.dart';
import '../../../theme/provider/theme_provider.dart';
import '../../user/provider/gloabl_variable_provider.dart';
import '../provider/hit_duty_calendar_change_month_provider.dart';
import '../provider/hit_schedule_for_event_provider.dart';
import '../provider/hit_schedule_provider.dart';
import '../provider/hit_schedule_selected_day_provider.dart';

class HitScheduleCalendar extends ConsumerWidget {
  const HitScheduleCalendar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);


    var eventsLinkedHashMap =
        LinkedHashMap<DateTime?, HitScheduleForEventListModel>(
            equals: isSameDay);
    final selectedDay = ref.watch(hitScheduleSelectedDayProvider);
    final global = ref.watch(globalVariableStateProvider);


    final event = ref.watch(hitSheduleForEventNotifierProvider);
    var eventList = HitScheduleForEventModel(data: null);

    var map = <DateTime?, HitScheduleForEventListModel>{};

    if (event is HitScheduleForEventModel) {
      eventList = event;

      for (var i in eventList.data!) {
        map.addAll({i.scheduleDate: i});
      }
      eventsLinkedHashMap.addAll(map);
    }

    return CustomCalendar(
      shouldFillViewport: true,
      calendarStyle: const CalendarStyle(
        outsideDaysVisible: false,
        isTodayHighlighted: true,
      ),
      onPageChanged: (DateTime month) async {
        ref
            .read(hitScheduleSelectedDayProvider.notifier)
            .update((state) => month);
        ref
            .read(hitDutyCalendarChangeMonthProvider.notifier)
            .update((state) => DateFormat('yyyyMM').format(month));

        ref
            .read(hitSheduleForEventNotifierProvider.notifier)
            .getHitScheduleForEvent();

        ref.read(hitScheduleNotifierProvider.notifier).getHitSchedule(false);
      },
      events: eventsLinkedHashMap,
      selectedDay: selectedDay,
      focusedDay: selectedDay,
      onDaySelected: (selectedDay, focusedDay) async {
        ref
            .read(hitScheduleSelectedDayProvider.notifier)
            .update((state) => selectedDay);

        await ref
            .read(hitScheduleNotifierProvider.notifier)
            .getHitSchedule(false);
      },
      markerBuilder: (context, date, events) {
        return _markerBuilderHelper(
            context, date, events, eventsLinkedHashMap, global, theme);
      },
    );
  }

  _markerBuilderHelper(
      BuildContext context, date, events, eventsLinkedHashMap, global, theme) {
    DateTime _date = DateTime(date.year, date.month, date.day);

    if (eventsLinkedHashMap[_date] != null) {
      if (isSameDay(
          _date, eventsLinkedHashMap[_date]!.scheduleDate ?? DateTime(2023))) {
        return Stack(children: [
          Positioned(
              right: 0,
              bottom: 0,
              child: _buildEventsMarker(context, theme.color.primary,
                  eventsLinkedHashMap[_date]!.count)),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10.0),
                Text(
                  eventsLinkedHashMap[_date]!.morningNm ?? '',
                  style: TextStyle(
                      fontSize: context.layout(10.0, tablet: 18, desktop: 18),
                      fontWeight:
                          eventsLinkedHashMap[_date]!.morningNm == global.stfNm
                              ? FontWeight.bold
                              : FontWeight.normal,
                      color:
                          eventsLinkedHashMap[_date]!.morningNm == global.stfNm
                              ? theme.color.tertiary
                              : theme.color.text),
                ),
                Text(eventsLinkedHashMap[_date]!.afternoonNm ?? '',
                    style: TextStyle(
                        fontSize: context.layout(10.0, tablet: 18, desktop: 18),
                        fontWeight: eventsLinkedHashMap[_date]!.afternoonNm ==
                                global.stfNm
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: eventsLinkedHashMap[_date]!.afternoonNm ==
                                global.stfNm
                            ? theme.color.tertiary
                            : theme.color.text)),
              ],
            ),
          ),
        ]);
      }
    }
  }

  Widget _buildEventsMarker(BuildContext context, Color color, int count) {
    return count == 0
        ? const SizedBox()
        : AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            width: context.layout(15.0, tablet: 25, desktop: 25),
            height: context.layout(15.0, tablet: 25, desktop: 25),
            child: Center(
              child: Text(
                '${count}',
                style: TextStyle().copyWith(
                  color: Colors.white,
                  fontSize: context.layout(10.0, tablet: 18, desktop: 18),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
  }
}
