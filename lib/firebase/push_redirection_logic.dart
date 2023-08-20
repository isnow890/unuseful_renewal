import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/src/common/provider/drawer_selector_provider.dart';
import 'package:unuseful/firebase/provider/fcm_router_provider.dart';
import 'package:unuseful/router/provider/go_router.dart';
import 'package:unuseful/src/hit_schedule/provider/hit_schedule_provider.dart';
import 'package:unuseful/src/hit_schedule/provider/hit_schedule_selected_day_provider.dart';
import 'package:unuseful/src/hit_schedule/view/hit_schedule_main_screen.dart';

routerLogicForegroundHitDutyAlarmWidgetRef1(WidgetRef ref) {
  final fromAlarm = ref.read(fcmRouterProvider);

  if (fromAlarm.page == 'hitSchedule1') {
    if (fromAlarm.action == 'selectDay') {
      ref.read(hitScheduleSelectedDayProvider.notifier).update(
            (state) => DateTime(
              int.parse(fromAlarm.param.substring(0, 4)),
              int.parse(fromAlarm.param.substring(5, 7)),
              int.parse(
                fromAlarm.param.substring(8, 10),
              ),
            ),
          );
      // ref
      //     .read(drawerSelectProvider.notifier)
      //     .update((state) => HitScheduleMainScreen.routeName);
      ref.read(hitScheduleNotifierProvider.notifier).getHitSchedule(false);

      var context2 =
          ref.read(goRouterProvider).routerDelegate.navigatorKey.currentContext;
      context2!.pushNamed(HitScheduleMainScreen.routeName,
          queryParameters: {'baseIndex': '0'});
    }
  }
}

routerLogicForegroundHitDutyAlarmRef1(Ref ref) {
  final fromAlarm = ref.read(fcmRouterProvider);

  if (fromAlarm.page == '') return '/';

  if (fromAlarm.page == 'hitSchedule1') {
    if (fromAlarm.action == 'selectDay') {
      ref.read(hitScheduleSelectedDayProvider.notifier).update(
            (state) => DateTime(
              int.parse(fromAlarm.param.substring(0, 4)),
              int.parse(fromAlarm.param.substring(5, 7)),
              int.parse(
                fromAlarm.param.substring(8, 10),
              ),
            ),
          );

      ref.read(hitScheduleNotifierProvider.notifier).getHitSchedule(false);

      // ref
      //     .read(drawerSelectProvider.notifier)
      //     .update((state) => HitScheduleMainScreen.routeName);

      return '/hitSchedule';
      // var context2 = ref
      //     .read(routerProvider)
      //     .routerDelegate
      //     .navigatorKey
      //     .currentContext;
      // context2!.pushNamed(HitScheduleMainScreen.routeName,
      //     queryParameters: {'baseIndex': '0'});
    }
  }
}
