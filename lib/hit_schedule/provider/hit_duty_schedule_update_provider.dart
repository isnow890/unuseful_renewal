import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/model/response_model.dart';
import 'package:unuseful/hit_schedule/model/hit_duty_schedule_update_model.dart';
import 'package:unuseful/hit_schedule/repository/hit_schedule_repository.dart';

final hitDutyScheduleUpdateFamilyProvider = StateNotifierProvider.family<
    HitDutyScheduleUpdateNotifier,
    ResponseModelBase?,
    HitDutyScheduleUpdateModel>(
  (ref, param) {
    final repository = ref.watch(hitScheduleRepositoryProvider);
    final notifier =
        HitDutyScheduleUpdateNotifier(repository: repository, param: param);
    return notifier;
  },
);

class HitDutyScheduleUpdateNotifier extends StateNotifier<ResponseModelBase?> {
  final HitScheduleRepository repository;
  final HitDutyScheduleUpdateModel param;

  HitDutyScheduleUpdateNotifier({required this.repository, required this.param})
      : super(ResponseModelLoading()) {
    updateDuty();
  }

  Future<ResponseModelBase?> updateDuty() async {
    try {
      state = ResponseModelLoading();
      final resp = await repository.updateDuty(body: param);
      state = resp;
      return resp;
    } catch (e) {
      print(e.toString());
      state = ResponseModelError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }
}
