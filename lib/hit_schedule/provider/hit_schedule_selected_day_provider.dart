import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:unuseful/hit_schedule/provider/hit_duty_calendar_change_month_provider.dart';

final hitScheduleSelectedDayProvider =
    StateProvider<DateTime>((ref) {

      return DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        );
    });
