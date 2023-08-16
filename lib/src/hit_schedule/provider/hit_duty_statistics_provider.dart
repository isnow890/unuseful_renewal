import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/hit_schedule/model/hit_duty_statistics_model.dart';

import '../model/hit_schedule_log_model.dart';
import '../repository/hit_schedule_repository.dart';

final hitDutyStatisticsFamilyProvider = StateNotifierProvider.family<
    HitDutyStatisticsNotifier, HitDutyStatisticsModelBase?, String>(
  (ref, stfNum) {
    final repository = ref.watch(hitScheduleRepositoryProvider);
    final notifier =
        HitDutyStatisticsNotifier(repository: repository, stfNum: stfNum);
    return notifier;
  },
);

// Future<List<HitDutyLogListModel>> getDutyLog();

class HitDutyStatisticsNotifier
    extends StateNotifier<HitDutyStatisticsModelBase?> {
  final HitScheduleRepository repository;
  final String stfNum;

  HitDutyStatisticsNotifier({required this.repository, required this.stfNum})
      : super(HitDutyStatisticsModelLoading()) {
    getDutyLog();
  }

  Future<HitDutyStatisticsModelBase> getDutyLog() async {
    try {
      List<HitDutyStatisticsListModel> resp =
          await repository.getDutyStatistics(stfNum);
      state = HitDutyStatisticsModel(data: resp);
      return HitDutyStatisticsModel(data: resp);
    } catch (e) {
      print(e.toString());
      state = HitDutyStatisticsModelError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }
}
