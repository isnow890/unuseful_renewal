import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/hit_schedule/component/hit_schedule_calendar.dart';
import 'package:unuseful/src/hit_schedule/component/schedule_list.dart';
import 'package:unuseful/src/hit_schedule/component/today_banner.dart';
import 'package:unuseful/src/hit_schedule/provider/hit_schedule_for_event_provider.dart';
import 'package:unuseful/src/hit_schedule/provider/hit_schedule_selected_day_provider.dart';
import 'package:unuseful/theme/layout/default_layout.dart';

class HitScheduleScreen extends ConsumerStatefulWidget {
  const HitScheduleScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HitScheduleScreen> createState() => _HitScheduleScreenState();
}

class _HitScheduleScreenState extends ConsumerState<HitScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        canRefresh: true,
        onRefreshAndError: () async {
          ref.invalidate(hitScheduleSelectedDayProvider);
          ref.invalidate(hitSheduleForEventNotifierProvider);
        },
        child: const Column(
          children: [
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: HitScheduleCalendar(),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TodayBanner(),
            SizedBox(
              height: 5,
            ),
            SizedBox(height: 200, child: ScheduleList()),
          ],
        ));
  }
}
