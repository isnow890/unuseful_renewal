import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/hit_schedule/model/hit_schedule_for_event_model.dart';
import 'package:unuseful/hit_schedule/repository/hit_schedule_repository.dart';


final hitSheduleForEventNotifierProvider =
StateNotifierProvider<HitSheduleForEventNotifier, HitScheduleForEventModelBase?>(
      (ref) {
    final repository = ref.watch(hitScheduleRepositoryProvider);
    final notifier =
    HitSheduleForEventNotifier(repository: repository);
    return notifier;
  },
);


class HitSheduleForEventNotifier
    extends StateNotifier<HitScheduleForEventModelBase?> {
  final HitScheduleRepository repository;

  HitSheduleForEventNotifier({required this.repository})
      : super(HitScheduleForEventModelLoading()) {
    getHitScheduleForEvent();
  }

  Future<HitScheduleForEventModelBase> getHitScheduleForEvent() async {
    try {
      List<HitScheduleForEventListModel> resp =
          await repository.getHitScheduleForEvent();
      state = HitScheduleForEventModel(data: resp);
      return HitScheduleForEventModel(data: resp);
    } catch (e) {
      print(e.toString());
      state = HitScheduleForEventModelError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }
}
