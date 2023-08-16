import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/meal/model/meal_model.dart';
import 'package:unuseful/src/meal/repository/meal_repository.dart';

import '../../user/provider/gloabl_variable_provider.dart';

final mealFamilyProvider =
    StateNotifierProvider.family<MealNotifier, ModelBase?, String>(
  (ref, hspTpCd) {
    final repository = ref.watch(mealRepositoryProvider);
    final notifier = MealNotifier(repository: repository, hspTpCd: hspTpCd);
    return notifier;
  },
);


class MealNotifier extends StateNotifier<ModelBase?> {
  final MealRepository repository;
  final String hspTpCd;

  MealNotifier({required this.repository, required this.hspTpCd})
      : super(ModelBaseLoading()) {
    getMeal();
  }

  Future<ModelBase> getMeal() async {
    try {
      state = ModelBaseLoading();
      final List<MealModelList> resp = await repository.getMeal(hspTpCd);
      state = MealModel(data: resp);

      print(resp[0].title);

      return MealModel(data: resp);
    } catch (e) {
      print(e.toString());
      state = ModelBaseError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }
}
