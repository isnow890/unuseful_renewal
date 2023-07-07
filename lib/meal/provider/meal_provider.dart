import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/secure_storage/secure_storage.dart';
import 'package:unuseful/meal/model/meal_model.dart';
import 'package:unuseful/meal/repository/meal_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../common/const/data.dart';
import '../../user/provider/login_variable_provider.dart';
import 'hsp_tp_cd_provider.dart';

final mealFamilyProvider =
    StateNotifierProvider.family<MealNotifier, MealModelBase?, String>(
  (ref, hspTpCd) {
    final repository = ref.watch(mealRepositoryProvider);
    final notifier = MealNotifier(repository: repository, hspTpCd: hspTpCd);
    return notifier;
  },
);

// final mealNotifierProvider =
//     StateNotifierProvider<MealNotifier, MealModelBase?>((ref) {
//   final repository = ref.watch(mealRepositoryProvider);
//   // final loginValue = ref.read(loginVariableStateProvider);

//   final notifier = MealNotifier(repository: repository);
//   return notifier;
// });

class MealNotifier extends StateNotifier<MealModelBase?> {
  final MealRepository repository;
  final String hspTpCd;

  MealNotifier({required this.repository, required this.hspTpCd})
      : super(MealModelLoading()) {
    getMeal();
  }

  Future<MealModelBase> getMeal() async {
    try {
      state = MealModelLoading();
      final List<MealModelList> resp = await repository.getMeal(hspTpCd);
      state = MealModel(data: resp);

      print(resp[0].title);

      return MealModel(data: resp);
    } catch (e) {
      print(e.toString());
      state = MealModelError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }
}
