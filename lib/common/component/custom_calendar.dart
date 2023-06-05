import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../const/colors.dart';

class CustomCalendar extends ConsumerWidget {
  final DateTime? selectedDay;
  final DateTime focusedDay;
  final OnDaySelected? onDaySelected;

  final defaultTextStyle = TextStyle(
    color: Colors.grey[600],
    fontWeight: FontWeight.w700,
  );

  final defaultBoxDeco = BoxDecoration(
    color: Colors.grey[200],
    //테두리 깍기
    borderRadius: BorderRadius.circular(6.0),
  );

   CustomCalendar({required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  TableCalendar(
      daysOfWeekHeight: 20,
      locale: 'ko_KR',
      focusedDay: focusedDay,
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true, //March 2023 가운데 정렬
        // 헤더 사이즈 변경
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      calendarStyle: CalendarStyle(
        //오늘날짜 highlighted 여부
        isTodayHighlighted: false,
        //날짜 컨테이너를 지정할 수 있는 기능
        //주중 스타일 설정
        defaultDecoration: defaultBoxDeco,
        //주말 스타일 설정
        weekendDecoration: defaultBoxDeco.copyWith(),
        //선택된 날짜 스타일 설정
        selectedDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
          //테두리 설정
          border: Border.all(
            width: 1,
            color: PRIMARY_COLOR,
          ),
        ),
        outsideDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        //주중 글자 스타일 설정
        defaultTextStyle: defaultTextStyle,
        //주말 글자 스타일
        weekendTextStyle: defaultTextStyle,
        //선택 날짜 글자 스타일
        selectedTextStyle: defaultTextStyle.copyWith(
          color: PRIMARY_COLOR,
        ),
      ),
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

      // onPageChanged: (focusedDay) {
      //   // No need to call `setState()` here
      //   _focusedDay = focusedDay;
      // },
    );
  }
}
