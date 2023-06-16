import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/secure_storage/secure_storage.dart';
import 'package:unuseful/meal/model/meal_model.dart';
import 'package:unuseful/meal/repository/meal_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../common/const/data.dart';
import '../../user/provider/login_variable_provider.dart';
import 'hsp_tp_cd_provider.dart';

final mealNotifierProvider =
    StateNotifierProvider<MealNotifier, MealModelBase?>((ref) {
  final repository = ref.watch(mealRepositoryProvider);
  final hspTpCd = ref.watch(hspTpCdProvider);
  // final loginValue = ref.read(loginVariableStateProvider);

  final storage = ref.watch(secureStorageProvider);



  final notifier = MealNotifier(hspTpCd:  hspTpCd, repository: repository,storage: storage);
  return notifier;
});

class MealNotifier extends StateNotifier<MealModelBase?> {
  final MealRepository repository;
  final String hspTpCd;
  final FlutterSecureStorage storage;

  MealNotifier({required this.hspTpCd, required this.repository,required this.storage})
      : super(MealModelLoading()) {
    getMeal();
  }

  Future<MealModelBase> getMeal() async {
    try {
      final hspTpCd2 = await storage.read(key: CONST_HSP_TP_CD);
      state = MealModelLoading();
      final List<MealModelList> resp = await repository.getMeal(hspTpCd == ''? hspTpCd2!:hspTpCd);
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
