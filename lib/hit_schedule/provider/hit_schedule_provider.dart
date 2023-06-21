import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:unuseful/hit_schedule/model/hit_schedule_model.dart';
import 'package:unuseful/hit_schedule/repository/hit_schedule_repository.dart';

import 'hit_schedule_selected_day_provider.dart';


final hitScheduleNotifierProvider =
    StateNotifierProvider<HitScheduleNotifier, HitScheduleModelBase?>(
  (ref) {
    // final selectedDay = ref.watch(hitScheduleSelectedDayProvider);
    final repository = ref.watch(hitScheduleRepositoryProvider);
    final notifier =
        HitScheduleNotifier(repository: repository, ref:ref);
    return notifier;
  },
);

class HitScheduleNotifier extends StateNotifier<HitScheduleModelBase?> {
  final HitScheduleRepository repository;
  final Ref ref;
  // final DateTime selectedDay;

  HitScheduleNotifier({required this.ref, required this.repository})
      : super(HitScheduleModelLoading()) {
    getHitSchedule(false);
  }

  Future<HitScheduleModelBase> getHitSchedule(bool isAll) async {
    try {

      final selectedDay = ref.read(hitScheduleSelectedDayProvider);
      state = HitScheduleModelLoading();
      List<HitScheduleListModel> resp = await repository.getHitSchedule(DateFormat('yyyyMM').format(selectedDay));

      print('selectedDay');
      print(selectedDay);

      if (!isAll) {
        print('all 아님 실행');
        resp = resp
            .where((element) =>
        (element.startDate.isBefore(DateTime(selectedDay.year, selectedDay.month, selectedDay.day) ) ||element.startDate.compareTo(DateTime(selectedDay.year, selectedDay.month, selectedDay.day)) == 0) &&
            (element.endDate.isAfter(DateTime(selectedDay.year, selectedDay.month, selectedDay.day))|| element.endDate.compareTo(DateTime(selectedDay.year, selectedDay.month, selectedDay.day)) == 0))
            .toList();
      } else {
        print('all 실행');
      }
      state = HitScheduleModel(data: resp);

      // print((state as HitScheduleModel).data[0].stfNm);

      return HitScheduleModel(data: resp);
    } catch (e) {
      print(e.toString());
      state = HitScheduleModelError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }
}
