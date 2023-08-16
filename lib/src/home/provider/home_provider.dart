import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/home/repository/home_repository.dart';

import '../../user/model/user_model.dart';
import '../../user/provider/user_me_provider.dart';
import '../../common/model/hit_schedule_at_home_model.dart';

final homeNotifierProvider =
    StateNotifierProvider<HomeNotifier, ModelBase?>((ref) {
  final repository = ref.watch(homeRepositoryProvider);
  final notifier = HomeNotifier(repository: repository, ref: ref);
  return notifier;
});

class HomeNotifier extends StateNotifier<ModelBase?> {
  final HomeRepository repository;
  Ref ref;

  HomeNotifier({
    required this.repository,
    required this.ref,
  }) : super(ModelBaseLoading()) {
    getHitScheduleAtHome();
  }

  Future<ModelBase> getHitScheduleAtHome() async {
    try {
      final user = ref.read(userMeProvider.notifier).state;
      final convertedUser = user as UserModel;

      print(convertedUser.sid);
      state = ModelBaseLoading();

      HitScheduleAtHomeModel resp =
          await repository.getHitScheduleAtHome(stfNm: convertedUser.stfNm!);
      state = resp;

      print(resp.scheduleList);
      print(resp.scheduleOfMineList);
      print(resp.threeDaysList);

      return resp;
    } catch (e) {
      state = ModelBaseError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }
}
