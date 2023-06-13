// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:unuseful/hit_schedule/model/hit_duty_statistics_model.dart';
//
// import '../model/hit_schedule_log_model.dart';
// import '../repository/hit_schedule_repository.dart';
//
// final hitDutyLogNotifierProvider =
// StateNotifierProvider<HitDutyStatisticsNotifier, HitDutyLogModelBase?>(
//       (ref) {
//     final repository = ref.watch(hitScheduleRepositoryProvider);
//     final notifier = HitDutyStatisticsNotifier(repository: repository);
//     return notifier;
//   },
// );
//
// class HitDutyStatisticsNotifier extends StateNotifier<HitDutyStatisticsModelBase?> {
//   final HitScheduleRepository repository;
//
//   HitDutyStatisticsNotifier({required this.repository})
//       : super(HitDutyStatisticsModelLoading()) {
//     getHitScheduleForEvent();
//   }
//
//   Future<HitDutyLogModelBase> getHitScheduleForEvent() async {
//     try {
//       List<HitDutyStatisticsListModel> resp = await repository.getDutyStatistics();
//       state = HitDutyStatisticsModel(data: resp);
//       return HitDutyStatisticsModel(data: resp);
//     } catch (e) {
//       print(e.toString());
//       state = HitDutyLogModelError(message: '에러가 발생하였습니다.');
//       return Future.value(state);
//     }
//   }
// }
