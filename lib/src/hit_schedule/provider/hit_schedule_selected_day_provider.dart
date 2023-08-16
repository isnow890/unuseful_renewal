import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final hitScheduleSelectedDayProvider =
    StateProvider<DateTime>((ref) {

      return DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        );
    });
