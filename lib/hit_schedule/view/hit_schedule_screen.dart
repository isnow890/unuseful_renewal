import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/layout/default_layout.dart';

class HitScheduleScreen extends ConsumerStatefulWidget {
  static String get routeName => 'hitSchedule';
  const HitScheduleScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HitScheduleScreen> createState() => _HitScheduleScreenState();
}


class _HitScheduleScreenState extends ConsumerState<HitScheduleScreen> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: Text('HitSchedule'),
      child: Center(
        child: Text('HitScheduleScreen'),
      ),
    );
  }
}
