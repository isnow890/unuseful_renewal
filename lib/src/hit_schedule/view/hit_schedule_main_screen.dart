import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/hit_schedule/view/hit_duty_log_screen.dart';
import 'package:unuseful/src/hit_schedule/view/hit_duty_statistics_screen.dart';
import 'package:unuseful/src/hit_schedule/view/hit_schedule_screen.dart';
import 'package:unuseful/src/hit_schedule/view/hit_schedule_setting_screen.dart';
import 'package:unuseful/theme/model/menu_model.dart';

import '../../../colors.dart';
import '../../../theme/layout/default_layout.dart';

class HitScheduleMainScreen extends ConsumerStatefulWidget {
  const HitScheduleMainScreen({required this.baseIndex, Key? key})
      : super(key: key);

  final int? baseIndex;

  static String get routeName => 'hitSchedule';

  @override
  ConsumerState<HitScheduleMainScreen> createState() =>
      _HitScheduleMainScreenState();
}

class _HitScheduleMainScreenState extends ConsumerState<HitScheduleMainScreen> {
  //나중에 입력이 됨. 그러므로 late 사용

  int index = 0;

  List<String> tabBarList = ['당직/일정', '당직통계', '당직변경로그'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabBarList.length,
      initialIndex: 0,
      child: DefaultLayout(
        appBarBottomList: tabBarList,
        title: MenuModel.getMenuInfo(HitScheduleMainScreen.routeName).menuName,
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            HitScheduleScreen(),
            HitDutyStatisticsScreen(),
            HitDutyLogScreen(),
          ],
        ),
      ),
    );
  }
}
