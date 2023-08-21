import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unuseful/theme/component/calendar/calendar_builder.dart';
import 'package:unuseful/src/hit_schedule/model/hit_schedule_for_event_model.dart';
import 'package:unuseful/theme/component/calendar/range_calendar_builder.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';
import 'package:unuseful/theme/res/layout.dart';

typedef OnPageChanged = void Function(DateTime focusedDay);

class CustomCalendar extends ConsumerWidget {
  final bool? daySelect;
  final DateTime? selectedDay;
  final DateTime focusedDay;
  final OnDaySelected? onDaySelected;
  final OnPageChanged? onPageChanged;
  final bool shouldFillViewport;
  final CalendarStyle? calendarStyle;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final RangeSelectionMode? rangeSelected;
  final OnRangeSelected? onRangeSelected;

  final LinkedHashMap<DateTime?, HitScheduleForEventListModel>? events;

  final DayBuilder? dowBuilder;
  final DayBuilder? headerTitleBuilder;
  final FocusedDayBuilder? todayBuilder;
  final FocusedDayBuilder? selectedBuilder;
  final FocusedDayBuilder? defaultBuilder;

  final FocusedDayBuilder? rangeStartBuilder;
  final FocusedDayBuilder? rangeEndBuilder;

  final Widget? Function(
      BuildContext context, DateTime day, List<dynamic> events)? markerBuilder;

  CustomCalendar({

    this.daySelect=false,
    this.rangeStartBuilder,
    this.rangeEndBuilder,
    this.rangeSelected,
    this.rangeStart,
    this.rangeEnd,
    required this.shouldFillViewport,
    required this.calendarStyle,
    required this.onPageChanged,
    required this.events,
    this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
    this.onRangeSelected,
    this.selectedBuilder,
    this.defaultBuilder,
    this.dowBuilder,
    this.headerTitleBuilder,
    this.todayBuilder,
    this.markerBuilder,
    Key? key})
      : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    final defaultBoxDeco = BoxDecoration(
      color: theme.color.hintContainer,
      //테두리 깍기
      borderRadius: BorderRadius.circular(6.0),
    );
    return TableCalendar(
      // holidayPredicate: (day) {
      //   return true;
      // },

      onRangeSelected: onRangeSelected,
      rangeSelectionMode: rangeSelected ?? RangeSelectionMode.toggledOff,
      rangeStartDay: rangeStart,
      rangeEndDay: rangeEnd,
      shouldFillViewport: shouldFillViewport,
      daysOfWeekHeight: 20,
      locale: 'ko_KR',
      focusedDay: focusedDay,
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      headerStyle: HeaderStyle(
        headerPadding: EdgeInsets.all(0),
        formatButtonVisible: false,
        titleCentered: true, //March 2023 가운데 정렬
        // 헤더 사이즈 변경
        titleTextStyle: theme.typo.headline6,
      ),
      onPageChanged: onPageChanged,
      calendarStyle: calendarStyle ?? const CalendarStyle(),

      //selectedDay - 동그라미 쳐 놓은 날짜
      //focusedday - 보고 있는 월
      //onDaySelected - 날자를 선택했을때
      onDaySelected: onDaySelected,
      selectedDayPredicate: (DateTime date) {
        if (selectedDay == null) {
          return false;
        }
        //DateTime date는 현재 selectedDayPredicate가 체크하고 있는 날짜. (전체 날짜 다 선택함.)
        //return true를 하면 전체 날짜가 선택되므로
        return date.year == selectedDay!.year &&
            date.month == selectedDay!.month &&
            date.day == selectedDay!.day;
      },
      // rangeStartDecoration: BoxDecoration(
      //   color: theme.color.primary,
      //   shape: BoxShape.circle,
      // ),
      // rangeEndDecoration: BoxDecoration(
      //   color: theme.color.primary,
      //   shape: BoxShape.circle,
      // ),

      calendarBuilders: CalendarBuilders(
        rangeStartBuilder: (context, day, focusedDay) =>
            RangeCalendarBuilder(
              decoration: BoxDecoration(
                color: theme.color.primary,
                //테두리 깍기
                shape: BoxShape.circle,

              ),
              textColor: theme.color.onPrimary,
              day: day,
              focusedDay: focusedDay,
            ),
        rangeEndBuilder: (context, day, focusedDay) =>
            RangeCalendarBuilder(
              decoration: BoxDecoration(
                color: theme.color.primary,
                //테두리 깍기
                shape: BoxShape.circle,

              ),
              textColor: theme.color.onPrimary,
              day: day,
              focusedDay: focusedDay,
            ),
        withinRangeBuilder: (context, day, isWithinRange) {


        },
        headerTitleBuilder: headerTitleBuilder ?? (context, day) {},
        dowBuilder: dowBuilder ??
                (context, day) {
              late String dayToKorean;
              TextStyle textStyleType = theme.typo.subtitle2;
              switch (day.weekday) {
                case DateTime.sunday:
                  dayToKorean = '일';
                  textStyleType =
                      theme.typo.subtitle1.copyWith(color: Colors.red);
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
                  textStyleType = theme.typo.subtitle1.copyWith(
                    color: Colors.blue,
                  );
                  break;
              }

              return Center(
                child: Text(
                  dayToKorean,
                  style: textStyleType.copyWith(
                    fontSize: context.layout(14.0, tablet: 18, desktop: 18),
                  ),
                ),
              );
            },
        todayBuilder: todayBuilder ??
                (context, day, focusedDay) =>
                CalendarBuilder(
                  decoration: defaultBoxDeco,
                  textColor: theme.color.tertiary,
                  day: day,
                  focusedDay: focusedDay,
                ),
        selectedBuilder: selectedBuilder ??
                (context, day, focusedDay) =>
                CalendarBuilder(
                  decoration: defaultBoxDeco.copyWith(
                      border: Border.all(color: theme.color.primary, width: 2)),
                  textColor: theme.color.primary,
                  day: day,
                  focusedDay: focusedDay,
                ),
        defaultBuilder: defaultBuilder ??
                (context, day, focusedDay) {
              var textColor = theme.color.text;

              if (day.weekday == DateTime.saturday) {
                textColor = Colors.blue;
              } else if (day.weekday == DateTime.sunday) {
                textColor = Colors.red;
              }

              if (daySelect==true)
                {
                  return RangeCalendarBuilder(
                    decoration: defaultBoxDeco.copyWith(
                        border: Border.all(color: Colors.transparent, width: 2)),
                    day: day,
                    focusedDay: focusedDay,
                    textColor: textColor,
                  );
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
        markerBuilder: markerBuilder,
      ),
    );
  }
}
