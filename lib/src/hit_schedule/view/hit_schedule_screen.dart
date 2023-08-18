import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unuseful/src/hit_schedule/component/schedule_list.dart';
import 'package:unuseful/src/hit_schedule/component/today_banner.dart';
import 'package:unuseful/src/hit_schedule/model/hit_schedule_for_event_model.dart';
import 'package:unuseful/src/hit_schedule/provider/hit_schedule_for_event_provider.dart';
import 'package:unuseful/src/hit_schedule/provider/hit_schedule_provider.dart';
import 'package:unuseful/src/hit_schedule/provider/hit_schedule_selected_day_provider.dart';
import 'package:unuseful/src/user/provider/gloabl_variable_provider.dart';
import 'package:unuseful/theme/component/custom_calendar.dart';
import 'package:unuseful/theme/layout/default_layout.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

import '../../../colors.dart';
import '../provider/hit_duty_calendar_change_month_provider.dart';

class HitScheduleScreen extends ConsumerStatefulWidget {
  const HitScheduleScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HitScheduleScreen> createState() => _HitScheduleScreenState();
}

class _HitScheduleScreenState extends ConsumerState<HitScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeServiceProvider);
    final defaultBoxDeco = BoxDecoration(
      color: theme.color.hintContainer,
      //테두리 깍기
      borderRadius: BorderRadius.circular(6.0),
    );

    ref.watch(hitDutyCalendarChangeMonthProvider);
    final global = ref.watch(globalVariableStateProvider);
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
      canRefresh: true,
      onRefreshAndError : ()async{
        ref.refresh(hitScheduleSelectedDayProvider);
        ref.refresh(hitSheduleForEventNotifierProvider);

      },
        child: Column(
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: CustomCalendar(
              shouldFillViewport: true,
              calendarStyle: CalendarStyle(
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

                ref
                    .read(hitScheduleNotifierProvider.notifier)
                    .getHitSchedule(false);
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
                      textStyleType =
                          theme.typo.subtitle1.copyWith(color: Colors.blue);
                      break;
                  }

                  return Center(
                    child: Text(
                      dayToKorean,
                      style: textStyleType,
                    ),
                  );
                },
                todayBuilder: (context, day, focusedDay) => _CalendarBuilders(
                  decoration: defaultBoxDeco,
                  textColor: theme.color.tertiary,
                  day: day,
                  focusedDay: focusedDay,
                ),
                selectedBuilder: (context, day, focusedDay) =>
                    _CalendarBuilders(
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

                  return _CalendarBuilders(
                    decoration: defaultBoxDeco.copyWith(
                        border:
                            Border.all(color: Colors.transparent, width: 2)),
                    day: day,
                    focusedDay: focusedDay,
                    textColor: textColor,
                  );
                },
                holidayBuilder: (context, day, focusedDay) {
                  return _CalendarBuilders(
                    decoration: defaultBoxDeco,
                    day: day,
                    focusedDay: focusedDay,
                  );
                },
                markerBuilder: (context, date, eventss) {
                  DateTime _date = DateTime(date.year, date.month, date.day);

                  if (eventsLinkedHashMap[_date] != null) {
                    if (isSameDay(
                        _date,
                        eventsLinkedHashMap[_date]!.scheduleDate ??
                            DateTime(2023))) {
                      return Stack(children: [
                        Positioned(
                            right: 0,
                            bottom: 1,
                            child: _buildEventsMarker(
                              theme.color.primary,
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
                                    fontWeight:
                                        eventsLinkedHashMap[_date]!.morningNm ==
                                                global.stfNm
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                    color:
                                        eventsLinkedHashMap[_date]!.morningNm ==
                                            global.stfNm
                                            ? theme.color.tertiary
                                            : theme.color.text),
                              ),
                              Text(
                                  eventsLinkedHashMap[_date]!.afternoonNm ?? '',
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: eventsLinkedHashMap[_date]!
                                                  .afternoonNm ==
                                          global.stfNm
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: eventsLinkedHashMap[_date]!
                                                  .afternoonNm ==
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
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const TodayBanner(),
        const SizedBox(
          height: 5,
        ),
        const SizedBox(height: 200, child: ScheduleList()),
      ],
    ));
  }

  Widget _buildEventsMarker(Color color , int count) {
    return count == 0
        ? Text('')
        : AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: color),
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

class _CalendarBuilders extends StatelessWidget {
  final DateTime day;
  final DateTime focusedDay;
  final Decoration decoration;
  final Color? textColor;
  final FontWeight? fontWeight;

  const _CalendarBuilders(
      {Key? key,
      required this.day,
      required this.focusedDay,
      required this.decoration,
      this.textColor,
      this.fontWeight})
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
              style: TextStyle(
                  fontSize: 13, color: textColor, fontWeight: fontWeight),
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
