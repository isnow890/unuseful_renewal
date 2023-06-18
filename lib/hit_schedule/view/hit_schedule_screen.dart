import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unuseful/common/component/custom_calendar.dart';
import 'package:unuseful/common/component/custom_circular_progress_indicator.dart';
import 'package:unuseful/hit_schedule/component/schedule_bottom_sheet.dart';
import 'package:unuseful/hit_schedule/component/schedule_card.dart';
import 'package:unuseful/hit_schedule/component/today_banner.dart';
import 'package:unuseful/hit_schedule/model/hit_schedule_for_event_model.dart';
import 'package:unuseful/hit_schedule/model/hit_schedule_model.dart';
import 'package:unuseful/hit_schedule/provider/hit_my_duty_provider.dart';
import 'package:unuseful/hit_schedule/provider/hit_schedule_for_event_provider.dart';
import 'package:unuseful/hit_schedule/provider/hit_schedule_provider.dart';
import 'package:unuseful/hit_schedule/provider/hit_schedule_selected_day_provider.dart';
import 'package:unuseful/user/provider/login_variable_provider.dart';

import '../../common/const/colors.dart';
import '../../user/model/user_model.dart';
import '../../user/provider/user_me_provider.dart';
import '../provider/hit_duty_calendar_change_month_provider.dart';
import '../provider/hit_my_duty_selected_schedule_provider.dart';

class HitScheduleScreen extends ConsumerStatefulWidget {

  const HitScheduleScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HitScheduleScreen> createState() => _HitScheduleScreenState();
}

class _HitScheduleScreenState extends ConsumerState<HitScheduleScreen> {
  @override
  Widget build(BuildContext context) {



    final defaultBoxDeco = BoxDecoration(
      color: Colors.grey[200],
      //테두리 깍기
      borderRadius: BorderRadius.circular(6.0),
    );

    ref.watch(hitDutyCalendarChangeMonthProvider);
    final user = ref.watch(userMeProvider.notifier).state as UserModel;
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

    return Column(
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: CustomCalendar(
            shouldFillViewport: true,
            calendarStyle : CalendarStyle(
              outsideDaysVisible: false,
              isTodayHighlighted: false,
            ),
            onPageChanged: (DateTime month) {
              ref
                  .read(hitScheduleSelectedDayProvider.notifier)
                  .update((state) => month);
              ref
                  .read(hitDutyCalendarChangeMonthProvider.notifier)
                  .update((state) => DateFormat('yyyyMM').format(month));
            },
            events: eventsLinkedHashMap,
            selectedDay: selectedDay,
            focusedDay: selectedDay,
            onDaySelected: (selectedDay, focusedDay) {
              ref
                  .read(hitScheduleSelectedDayProvider.notifier)
                  .update((state) => selectedDay);
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

              markerBuilder: (context, date, eventss) {
                DateTime _date = DateTime(date.year, date.month, date.day);

                if (eventsLinkedHashMap[_date] != null) {
                  if (isSameDay(
                      _date, eventsLinkedHashMap[_date]!.scheduleDate ?? DateTime(2023))) {
                    return Stack(children: [
                      Positioned(
                          right: -1,
                          bottom: -1,
                          child: _buildEventsMarker(eventsLinkedHashMap[_date]!.count)),
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
                                  color: eventsLinkedHashMap[_date]!.morningNm == user.stfNm
                                      ? Colors.orange
                                      : Colors.black),
                            ),
                            Text(eventsLinkedHashMap[_date]!.afternoonNm ?? '',
                                style: TextStyle(
                                    fontSize: 10.0,
                                    color: eventsLinkedHashMap[_date]!.afternoonNm == user.stfNm
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
        ),
        SizedBox(
          height: 5,
        ),
        TodayBanner(),
        SizedBox(
          height: 5,
        ),
        SizedBox(height: 200, child: _ScheduleList()),
      ],
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

class _ScheduleList extends ConsumerWidget {
  const _ScheduleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(hitScheduleSelectedDayProvider);
    final state = ref.watch(hitScheduleNotifierProvider);
    final user = ref.watch(userMeProvider.notifier).state;
    var stfNum = (user as UserModel).hitDutyYn;
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
        children: const [
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
            child: GestureDetector(
              onTap: () {
                if (state.data[index].scheduleType == 'duty') {
                  ref.refresh(hitMyDutySelectedScheduleProvider);
                  ref
                      .read(hitMyDutyFamilyProvider(stfNum!).notifier)
                      .getDutyOfMine();

                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) {
                        return ScheduleBottomSheet(
                            dutyTypeCode: state.data[index].dutyTypeCode!,
                            dutyDate: state.data[index].startDate,
                            dutyName: state.data[index].scheduleName!,
                            stfNm: state.data[index].stfNm!,
                            stfNum: stfNum!);
                      });
                }
              },
              child: ScheduleCard(
                startDate: state.data[index].startDate,
                endDate: state.data[index].endDate,
                startTime: state.data[index].startTime ?? '',
                endTime: state.data[index].endTime ?? '',
                content: state.data[index].scheduleName ?? '',
                stfNm: state.data[index].stfNm ?? '',
                scheduleType: state.data[index].scheduleType ?? '',
              ),
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