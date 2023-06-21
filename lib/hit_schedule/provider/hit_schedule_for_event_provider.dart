import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/hit_schedule/model/hit_schedule_for_event_model.dart';
import 'package:unuseful/hit_schedule/repository/hit_schedule_repository.dart';

import 'hit_duty_calendar_change_month_provider.dart';

final hitSheduleForEventNotifierProvider = StateNotifierProvider<
    HitSheduleForEventNotifier, HitScheduleForEventModelBase?>(
  (ref) {
    final repository = ref.watch(hitScheduleRepositoryProvider);

    // final changeMonth = ref.watch(hitDutyCalendarChangeMonthProvider);
    final notifier = HitSheduleForEventNotifier(repository: repository, ref: ref);
    return notifier;
  },
);

class HitSheduleForEventNotifier
    extends StateNotifier<HitScheduleForEventModelBase?> {
  final HitScheduleRepository repository;
  final Ref ref;

  HitSheduleForEventNotifier(
      {required this.ref, required this.repository})
      : super(HitScheduleForEventModelLoading()) {
    getHitScheduleForEvent();
  }

  Future<HitScheduleForEventModelBase> getHitScheduleForEvent() async {
    try {

    final changeMonth = ref.read(hitDutyCalendarChangeMonthProvider);
      List<HitScheduleForEventListModel> resp =
          await repository.getHitScheduleForEvent(changeMonth);
      state = HitScheduleForEventModel(data: resp);
      return HitScheduleForEventModel(data: resp);
    } catch (e) {
      print(e.toString());
      state = HitScheduleForEventModelError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }
}
