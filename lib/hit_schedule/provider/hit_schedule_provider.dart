import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:unuseful/hit_schedule/model/hit_schedule_model.dart';
import 'package:unuseful/hit_schedule/repository/hit_schedule_repository.dart';

import 'hit_schedule_selected_day_provider.dart';

final hitScheduleFamilyProvider = Provider.family<HitScheduleModel?, DateTime>(
  (ref, selectedDay) {
    final state = ref.watch(hitScheduleNotifierProvider);

    if (state is! HitScheduleModel) return null;
    var returnedList = state.data
        .where((element) =>
            element.startDate.compareTo(selectedDay) >= 0 &&
            element.endDate.compareTo(selectedDay) <= 0)
        .toList();
  },
);

final hitScheduleNotifierProvider =
    StateNotifierProvider<HitScheduleNotifier, HitScheduleModelBase?>(
  (ref) {
    final selectedDay = ref.watch(hitScheduleSelectedDayProvider);
    final repository = ref.watch(hitScheduleRepositoryProvider);
    final notifier =
        HitScheduleNotifier(repository: repository, selectedDay: selectedDay);
    return notifier;
  },
);

class HitScheduleNotifier extends StateNotifier<HitScheduleModelBase?> {
  final HitScheduleRepository repository;
  final DateTime selectedDay;

  HitScheduleNotifier({required this.selectedDay, required this.repository})
      : super(HitScheduleModelLoading()) {
    getHitSchedule(false);
  }

  Future<HitScheduleModelBase> getHitSchedule(bool isAll) async {
    try {

      state = HitScheduleModelLoading();
      List<HitScheduleListModel> resp = await repository.getHitSchedule(DateFormat('yyyyMM').format(selectedDay));

      print('selectedDay');
      print(selectedDay);

      if (!isAll) {
        print('all 아님 실행');
        resp = resp
            .where((element) =>
        (element.startDate.isBefore(selectedDay) ||element.startDate.compareTo(selectedDay) == 0) &&
            (element.endDate.isAfter(selectedDay)|| element.endDate.compareTo(selectedDay) == 0))
            .toList();
      } else {
        print('all 실행');
      }
      state = HitScheduleModel(data: resp);

      return HitScheduleModel(data: resp);
    } catch (e) {
      print(e.toString());
      state = HitScheduleModelError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }
}
