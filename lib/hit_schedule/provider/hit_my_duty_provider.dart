import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/hit_schedule/model/hit_my_duty_model.dart';
import 'package:unuseful/hit_schedule/repository/hit_schedule_repository.dart';

final hitMyDutyFamilyProvider = StateNotifierProvider.family<HitMyDutyNotifier,
    HitMyDutyModelBase?, String>((ref, stfNum) {
  final repository = ref.watch(hitScheduleRepositoryProvider);

  print('family 실행됨');
  final notifier = HitMyDutyNotifier(repository: repository, stfNum: stfNum);
  return notifier;
});

class HitMyDutyNotifier extends StateNotifier<HitMyDutyModelBase?> {
  final HitScheduleRepository repository;
  final String stfNum;

  HitMyDutyNotifier({required this.repository, required this.stfNum})
      : super(HitMyDutyModelLoading()) {
    getDutyOfMine();
  }

  Future<HitMyDutyModelBase> getDutyOfMine() async {
    try {

      print('getDutyOfMine 실행됨');

      List<HitMyDutyListModel> resp = await repository.getDutyOfMine(stfNum);
      state = HitMyDutyModel(data: resp);
      return HitMyDutyModel(data: resp);
    } catch (e) {
      print(e.toString());
      state = HitMyDutyModelError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }
}
