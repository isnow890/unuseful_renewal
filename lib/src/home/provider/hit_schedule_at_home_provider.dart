import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/common/model/hit_schedule_at_home_model.dart';
import 'package:unuseful/src/common/model/model_base.dart';

import '../../user/model/user_model.dart';
import '../../user/provider/user_me_provider.dart';
import '../repository/home_repository.dart';

class HitScheduleAtHomeNotifier
    extends StateNotifier<ModelBase?> {
  final HomeRepository repository;
  final Ref ref;
  // final DateTime selectedDay;

  HitScheduleAtHomeNotifier({required this.ref, required this.repository})
      : super(ModelBaseLoading()) {
    print('atHome1');

    getHitScheduleAtHome();
  }

  Future<ModelBase> getHitScheduleAtHome() async {
    try {
      final user = ref.read(userMeProvider.notifier).state;
      final convertedUser = user as UserModel;
      state = ModelBaseLoading();

      print('atHome');
      HitScheduleAtHomeModel resp =
          await repository.getHitScheduleAtHome(stfNm: convertedUser.sid!);
      state = resp;
      print('resp');

      print(resp);
      return resp;
    } catch (e) {
      print(e.toString());
      state = ModelBaseError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }
}
