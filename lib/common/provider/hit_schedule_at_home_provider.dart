import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/model/hit_schedule_at_home_model.dart';

import '../../user/model/user_model.dart';
import '../../user/provider/user_me_provider.dart';
import '../repository/home_repository.dart';

class HitScheduleAtHomeNotifier
    extends StateNotifier<HitScheduleAtHomeModelBase?> {
  final HomeRepository repository;
  final Ref ref;
  // final DateTime selectedDay;

  HitScheduleAtHomeNotifier({required this.ref, required this.repository})
      : super(HitScheduleAtHomeModelLoading()) {
    getHitScheduleAtHome();
  }

  Future<HitScheduleAtHomeModelBase> getHitScheduleAtHome() async {
    try {
      final user = ref.read(userMeProvider.notifier).state;
      final convertedUser = user as UserModel;
      state = HitScheduleAtHomeModelLoading();

      HitScheduleAtHomeModel resp =
          await repository.getHitScheduleAtHome(sid: convertedUser.sid!);
      state = resp;
      return resp;
    } catch (e) {
      print(e.toString());
      state = HitScheduleAtHomeModelError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }
}
