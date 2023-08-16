import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/common/layout/default_layout.dart';
import 'package:unuseful/src/hit_schedule/view/hit_duty_log_screen.dart';
import 'package:unuseful/src/hit_schedule/view/hit_duty_statistics_screen.dart';
import 'package:unuseful/src/hit_schedule/view/hit_schedule_screen.dart';
import 'package:unuseful/src/hit_schedule/view/hit_schedule_setting_screen.dart';

import '../../../colors.dart';

class HitScheduleMainScreen extends ConsumerStatefulWidget {
  const HitScheduleMainScreen({required this.baseIndex, Key? key})
      : super(key: key);

  final int? baseIndex;
  static String get routeName => 'hitSchedule';

  @override
  ConsumerState<HitScheduleMainScreen> createState() =>
      _HitScheduleMainScreenState();
}

class _HitScheduleMainScreenState extends ConsumerState<HitScheduleMainScreen>
    with SingleTickerProviderStateMixin {
  //나중에 입력이 됨. 그러므로 late 사용
  late TabController controller;
  int index =  0;

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabListener);
    //일정
    //통계
    //로그

    //설정
    // TODO: implement initState
    super.initState();
    index = widget.baseIndex ?? 0;


  }

  void tabListener() {
    setState(() => index = controller.index);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: Text('schedule'),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (int value) {
          index = value;
          controller.animateTo(value);
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'schedule'),
          BottomNavigationBarItem(
              icon: Icon(Icons.auto_graph_outlined), label: 'statistics'),
          BottomNavigationBarItem(icon: Icon(Icons.find_in_page), label: 'log'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'settings'),
        ],
      ),
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: <Widget>[
          HitScheduleScreen(),
          HitDutyStatisticsScreen(),
          HitDutyLogScreen(),
          HitScheduleSettingScreen(),
        ],
      ),
    );
  }
}
