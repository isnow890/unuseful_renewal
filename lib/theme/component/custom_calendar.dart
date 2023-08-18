import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unuseful/src/hit_schedule/model/hit_schedule_for_event_model.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

typedef OnPageChanged = void Function(DateTime focusedDay);

class CustomCalendar extends ConsumerWidget {
  final DateTime? selectedDay;
  final DateTime focusedDay;
  final OnDaySelected? onDaySelected;
  final OnPageChanged? onPageChanged;
  final CalendarBuilders? calendarBuilders;
  final bool shouldFillViewport;
  final CalendarStyle? calendarStyle;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final RangeSelectionMode? rangeSelected;
  final OnRangeSelected? onRangeSelected;

  final LinkedHashMap<DateTime?, HitScheduleForEventListModel>? events;

  final defaultTextStyle = TextStyle(
    fontSize: 11.0,
    color: Colors.grey[600],
    fontWeight: FontWeight.w700,
  );

  final defaultBoxDeco = BoxDecoration(
    color: Colors.grey[200],
    //테두리 깍기
    borderRadius: BorderRadius.circular(6.0),
  );

  CustomCalendar(
      {this.rangeSelected,
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
      this.calendarBuilders,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

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

      calendarBuilders: calendarBuilders ?? CalendarBuilders(),
    );
  }
}
