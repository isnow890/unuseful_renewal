import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final hitDutyCalendarChangeMonthProvider =
    StateProvider((ref) => DateFormat('yyyyMM').format(DateTime.now()));
