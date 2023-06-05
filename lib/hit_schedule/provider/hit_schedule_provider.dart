import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/hit_schedule/model/hit_schedule_model.dart';
import 'package:unuseful/hit_schedule/repository/hit_schedule_repository.dart';

class HitScheduleNotifier extends StateNotifier<HitScheduleModelBase?> {
  final HitScheduleRepository repository;

  HitScheduleNotifier({required this.repository})
      :super(HitScheduleModelLoading()) {
    getHitSchedule();
  }


  Future<HitScheduleModelBase> getHitSchedule() async {
    try {
      state = HitScheduleModelLoading();
      final List<HitScheduleListModel> resp = await repository.getHitSchedule();
      state = HitScheduleModel(data: resp);
      return HitScheduleModel(data: resp);
    } catch (e) {
      print(e.toString());
      state = HitScheduleModelError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }
}

