import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unuseful/hit_schedule/model/hit_schedule_for_event_model.dart';
import 'package:unuseful/hit_schedule/provider/hit_duty_calendar_change_month_provider.dart';
import 'package:unuseful/user/model/user_model.dart';

import '../../user/provider/user_me_provider.dart';
import '../const/colors.dart';

typedef OnPageChanged = void Function(DateTime focusedDay);

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
    final user = ref.watch(userMeProvider.notifier).state as UserModel;
    // calendarBuilders: CalendarBuilders(
    //   dowBuilder: (context, day) {
    //     if (day.weekday == DateTime.sunday) {
    //       final text = DateFormat.E().format(day);
    //
    //       return Center(
    //         child: Text(
    //           text,
    //           style: TextStyle(color: Colors.red),
    //         ),
    //       );
    //     }
    //   },
    // ),

    return SizedBox(
      height: 100,
      child: TableCalendar(
        // holidayPredicate: (day) {
        //   return true;
        // },
        shouldFillViewport: true,
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
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        onPageChanged: onPageChanged,

        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          isTodayHighlighted: false,
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
          outsideBuilder: (context, day, focusedDay) => _CalendarBuilders(
            decoration: defaultBoxDeco.copyWith(
              color: Colors.white,
            ),
            textColor: Colors.grey[400],
            day: day,
            focusedDay: focusedDay,
          ),
          selectedBuilder: (context, day, focusedDay) => _CalendarBuilders(
            decoration: defaultBoxDeco.copyWith(
                color: Colors.white,
                border: Border.all(color: PRIMARY_COLOR, width: 1)),
            textColor: PRIMARY_COLOR,
            day: day,
            focusedDay: focusedDay,
          ),
          defaultBuilder: (context, day, focusedDay) => _CalendarBuilders(
              decoration: defaultBoxDeco,
              day: day,
              focusedDay: focusedDay,
              textColor: day.weekday == DateTime.sunday ||
                      day.weekday == DateTime.saturday
                  ? Colors.red
                  : Colors.black),

          holidayBuilder: (context, day, focusedDay) {
            return _CalendarBuilders(
              decoration: defaultBoxDeco,
              day: day,
              focusedDay: focusedDay,
            );
          },
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
                return Stack(children: [
                  Positioned(
                      right: -1,
                      bottom: -1,
                      child: _buildEventsMarker(events[_date]!.count)),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10.0),
                        Text(
                          events[_date]!.morningNm ?? '',
                          style: TextStyle(
                              fontSize: 10.0,
                              color: events[_date]!.morningNm == user.stfNm
                                  ? Colors.orange
                                  : Colors.black),
                        ),
                        Text(events[_date]!.afternoonNm ?? '',
                            style: TextStyle(
                                fontSize: 10.0,
                                color: events[_date]!.afternoonNm == user.stfNm
                                    ? Colors.orange
                                    : Colors.black)),
                        // Text(
                        //     events[_date]!.count == 0
                        //         ? ''
                        //         : ('일정:${events[_date]!.count}'),
                        //     style: TextStyle(fontSize: 9.0)),
                      ],
                    ),
                  ),
                ]
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

                    );
              }
            }
          },
        ),
      ),
    );
  }

  Widget _buildEventsMarker(int count) {
    return count == 0
        ? Text('')
        : AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration:
                BoxDecoration(shape: BoxShape.rectangle, color: PRIMARY_COLOR),
            width: 13.0,
            height: 13.0,
            child: Center(
              child: Text(
                '${count}',
                style: TextStyle().copyWith(
                  color: Colors.white,
                  fontSize: 9.0,
                ),
              ),
            ),
          );
  }
}

class _CalendarBuilders extends StatelessWidget {
  final DateTime day;
  final DateTime focusedDay;
  final Decoration decoration;
  final Color? textColor;

  const _CalendarBuilders(
      {Key? key,
      required this.day,
      required this.focusedDay,
      required this.decoration,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      child: Container(
        padding: EdgeInsets.only(top: 1, bottom: 1),
        width: MediaQuery.of(context).size.width,
        decoration: decoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              day.day.toString(),
              style: TextStyle(fontSize: 13, color: textColor ?? Colors.black),
            ),
            Expanded(child: Text("")),
            // Text(moneyString,
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: 12, color: nowIndexColor[900]),),
          ],
        ),
      ),
    );
  }
}
