import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/hit_schedule_log_model.dart';
import '../repository/hit_schedule_repository.dart';

final hitDutyLogNotifierProvider =
    StateNotifierProvider<HitDutyLogNotifier, HitDutyLogModelBase?>(
  (ref) {
    final repository = ref.watch(hitScheduleRepositoryProvider);
    final notifier = HitDutyLogNotifier(repository: repository);
    return notifier;
  },
);

class HitDutyLogNotifier extends StateNotifier<HitDutyLogModelBase?> {
  final HitScheduleRepository repository;

  HitDutyLogNotifier({required this.repository})
      : super(HitDutyLogModelLoading()) {
    getHitScheduleForEvent();
  }

  Future<HitDutyLogModelBase> getHitScheduleForEvent() async {
    try {
      List<HitDutyLogListModel> resp = await repository.getDutyLog();
      state = HitDutyLogModel(data: resp);
      return HitDutyLogModel(data: resp);
    } catch (e) {
      print(e.toString());
      state = HitDutyLogModelError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }
}
