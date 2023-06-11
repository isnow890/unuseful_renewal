import 'package:flutter_riverpod/flutter_riverpod.dart';

final hitScheduleSelectedDayProvider =
    StateProvider<DateTime>((ref) => DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ));
