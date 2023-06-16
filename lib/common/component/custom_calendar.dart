import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unuseful/hit_schedule/model/hit_schedule_for_event_model.dart';
import 'package:unuseful/hit_schedule/provider/hit_duty_calendar_change_month_provider.dart';

import '../const/colors.dart';

typedef OnPageChanged = void Function (DateTime focusedDay);



class CustomCalendar extends ConsumerWidget {
  final DateTime? selectedDay;
  final DateTime focusedDay;
  final OnDaySelected? onDaySelected;
  final OnPageChanged onPageChanged;

  final LinkedHashMap<DateTime?, HitScheduleForEventListModel> events;
  List<String> days = ['_', '월', '화', '수', '목', '금', '토', '일'];

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
      {required this.onPageChanged,
        required this.events,
      required this.selectedDay,
      required this.focusedDay,
      required this.onDaySelected,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // ref.watch(hitDutyCalendarChangeMonthProvider);
    return SizedBox(
      height: 100,
      child: TableCalendar(

        shouldFillViewport: true,
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
        onPageChanged: onPageChanged,
        // onPageChanged: (date) {
        //   ref
        //       .read(hitDutyCalendarChangeMonthProvider.notifier)
        //       .update((state) => DateFormat('yyyyMM').format(date));
        // },
        calendarStyle: CalendarStyle(
          cellAlignment: Alignment.topCenter,
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

          disabledTextStyle: const TextStyle(color: Colors.red),

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

        calendarBuilders: CalendarBuilders(
          // defaultBuilder: (context, day, focusedDay){
          //
          //   return Container(
          //     padding: EdgeInsets.all(3),
          //     child: Container(
          //       padding: EdgeInsets.only(top: 3, bottom: 3),
          //       width: MediaQuery.of(context).size.width,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.all(Radius.circular(7)),
          //         color: PRIMARY_COLOR,
          //       ),
          //       child: Column(mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(day.day.toString(), style: TextStyle(fontSize: 12),),
          //           Expanded(child: Text("")),
          //           // Text(moneyString,
          //           //   textAlign: TextAlign.center,
          //           //   style: TextStyle(fontSize: 12, color: nowIndexColor[900]),),
          //         ],
          //       ),
          //     ),
          //   );
          // },

          markerBuilder: (context, date, eventss) {
            DateTime _date = DateTime(date.year, date.month, date.day);

            if (events[_date] != null) {
              if (isSameDay(
                  _date, events[_date]!.scheduleDate ?? DateTime(2023))) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 10.0),

                    Text(
                      events[_date]!.morningNm??'',
                      style: TextStyle(fontSize: 9.0),
                    ),
                    Text(events[_date]!.afternoonNm??'', style: TextStyle(fontSize: 9.0)),
                    Text(events[_date]!.count ==0 ? '' : ('일정:${events[_date]!.count}'),
                        style: TextStyle(fontSize: 9.0)),

                    // Stack(children: [
                    //   Container(
                    //     width: 10,
                    //     padding: const EdgeInsets.only(bottom: 4),
                    //     decoration: const BoxDecoration(
                    //       color: PRIMARY_COLOR,
                    //       shape: BoxShape.circle,
                    //     ),
                    //   ),
                    //   // Text(events[_date]!.count.toString()),
                    // ]),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
