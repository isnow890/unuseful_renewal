import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/common/model/response_model.dart';
import 'package:unuseful/src/hit_schedule/model/hit_duty_schedule_update_model.dart';
import 'package:unuseful/src/hit_schedule/repository/hit_schedule_repository.dart';
// final hitDutyScheduleUpdateFamilyProvider = StateNotifierProvider.family<
//     HitDutyScheduleUpdateNotifier,
//     ResponseModelBase?,
//     HitDutyScheduleUpdateModel>(
//   (ref, param) {
//     final repository = ref.watch(hitScheduleRepositoryProvider);
//     final notifier =
//         HitDutyScheduleUpdateNotifier(repository: repository, param: param);
//     return notifier;
//   },
// );

final hitDutyScheduleUpdateNotifierProvider =
    StateNotifierProvider<HitDutyScheduleUpdateNotifier, ModelBase?>(
        (ref) {
  final repository = ref.watch(hitScheduleRepositoryProvider);
  final notifier = HitDutyScheduleUpdateNotifier(repository: repository);
  return notifier;
});

class HitDutyScheduleUpdateNotifier extends StateNotifier<ModelBase?> {
  final HitScheduleRepository repository;

  HitDutyScheduleUpdateNotifier({required this.repository})
      : super(ModelBaseInit());

  void initialize() {
    state = ModelBaseInit();
  }

  Future<ModelBase?> updateDuty(
      HitDutyScheduleUpdateModel param) async {
    try {
      state = ModelBaseLoading();
      final resp = await repository.updateDuty(body: param);
      state = resp;
      return resp;
    } catch (e) {
      print(e.toString());
      state = ModelBaseError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }
}
