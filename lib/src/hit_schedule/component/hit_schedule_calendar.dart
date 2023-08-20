import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unuseful/src/hit_schedule/component/calendar_builder.dart';
import 'package:unuseful/src/hit_schedule/model/hit_schedule_for_event_model.dart';

import '../../../theme/component/custom_calendar.dart';
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
    final defaultBoxDeco = BoxDecoration(
      color: theme.color.hintContainer,
      //테두리 깍기
      borderRadius: BorderRadius.circular(6.0),
    );

    var eventsLinkedHashMap =
        LinkedHashMap<DateTime?, HitScheduleForEventListModel>(
            equals: isSameDay);
    final selectedDay = ref.watch(hitScheduleSelectedDayProvider);
    final global = ref.watch(globalVariableStateProvider);

    ref.watch(hitDutyCalendarChangeMonthProvider);

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
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (context, day) {},
        dowBuilder: (context, day) {
          late String dayToKorean;
          TextStyle textStyleType = theme.typo.subtitle2;

          switch (day.weekday) {
            case DateTime.sunday:
              dayToKorean = '일';

              textStyleType = theme.typo.subtitle1.copyWith(color: Colors.red);
              break;
            case DateTime.monday:
              dayToKorean = '월';

              break;
            case DateTime.tuesday:
              dayToKorean = '화';
              break;
            case DateTime.wednesday:
              dayToKorean = '수';
              break;
            case DateTime.thursday:
              dayToKorean = '목';
              break;
            case DateTime.friday:
              dayToKorean = '금';
              break;
            case DateTime.saturday:
              dayToKorean = '토';
              textStyleType = theme.typo.subtitle1.copyWith(color: Colors.blue);
              break;
          }

          return Center(
            child: Text(
              dayToKorean,
              style: textStyleType,
            ),
          );
        },
        todayBuilder: (context, day, focusedDay) => CalendarBuilder(
          decoration: defaultBoxDeco,
          textColor: theme.color.tertiary,
          day: day,
          focusedDay: focusedDay,
        ),
        selectedBuilder: (context, day, focusedDay) => CalendarBuilder(
          decoration: defaultBoxDeco.copyWith(
              border: Border.all(color: theme.color.primary, width: 2)),
          textColor: theme.color.primary,
          day: day,
          focusedDay: focusedDay,
        ),
        defaultBuilder: (context, day, focusedDay) {
          var defaultTextStyle = theme.typo.body1;

          var textColor = theme.color.text;

          if (day.weekday == DateTime.saturday) {
            textColor = Colors.blue;
          } else if (day.weekday == DateTime.sunday) {
            textColor = Colors.red;
          }

          return CalendarBuilder(
            decoration: defaultBoxDeco.copyWith(
                border: Border.all(color: Colors.transparent, width: 2)),
            day: day,
            focusedDay: focusedDay,
            textColor: textColor,
          );
        },
        holidayBuilder: (context, day, focusedDay) {
          return CalendarBuilder(
            decoration: defaultBoxDeco,
            day: day,
            focusedDay: focusedDay,
          );
        },
        markerBuilder: (context, date, eventss) {
          DateTime _date = DateTime(date.year, date.month, date.day);

          if (eventsLinkedHashMap[_date] != null) {
            if (isSameDay(_date,
                eventsLinkedHashMap[_date]!.scheduleDate ?? DateTime(2023))) {
              return Stack(children: [
                Positioned(
                    right: 0,
                    bottom: 1,
                    child: _buildEventsMarker(theme.color.primary,
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
                            fontSize: 10.0,
                            fontWeight: eventsLinkedHashMap[_date]!.morningNm ==
                                    global.stfNm
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: eventsLinkedHashMap[_date]!.morningNm ==
                                    global.stfNm
                                ? theme.color.tertiary
                                : theme.color.text),
                      ),
                      Text(eventsLinkedHashMap[_date]!.afternoonNm ?? '',
                          style: TextStyle(
                              fontSize: 10.0,
                              fontWeight:
                                  eventsLinkedHashMap[_date]!.afternoonNm ==
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
        },
      ),
    );
  }

  Widget _buildEventsMarker(Color color, int count) {
    return count == 0
        ? const SizedBox()
        : AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            width: 15.0,
            height: 15.0,
            child: Center(
              child: Text(
                '${count}',
                style: TextStyle().copyWith(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
  }
}
