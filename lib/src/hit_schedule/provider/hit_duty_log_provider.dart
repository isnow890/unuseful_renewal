import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/common/model/model_base.dart';

import '../model/hit_schedule_log_model.dart';
import '../repository/hit_schedule_repository.dart';

final hitDutyLogNotifierProvider =
    StateNotifierProvider.autoDispose<HitDutyLogNotifier, ModelBase?>(
  (ref) {
    final repository = ref.watch(hitScheduleRepositoryProvider);
    final notifier = HitDutyLogNotifier(repository: repository);
    return notifier;
  },
);

class HitDutyLogNotifier extends StateNotifier<ModelBase?> {
  final HitScheduleRepository repository;

  HitDutyLogNotifier({required this.repository}) : super(ModelBaseLoading()) {
    getDutyLog();
  }

  // Future<List<HitDutyLogListModel>> getDutyLog();

  Future<ModelBase> getDutyLog() async {
    try {
      state = ModelBaseLoading();

      List<HitDutyLogListModel> resp = await repository.getDutyLog();
      state = HitDutyLogModel(data: resp);
      return HitDutyLogModel(data: resp);
    } catch (e) {
      state = ModelBaseError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }
}
