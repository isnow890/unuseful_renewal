import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/firebase/repository/firestore_repository.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/common/model/response_model.dart';
import 'package:unuseful/src/home/model/search_history_main_model.dart';
import 'package:unuseful/src/user/provider/gloabl_variable_provider.dart';

import '../../user/model/user_model.dart';
import '../../user/provider/user_me_provider.dart';

final specimenHistoryNotfierProvider = StateNotifierProvider<
    SpecimenHistoryNotifier, ModelBase?>((ref) {
  final repository = ref.watch(firestorageRepositoryProvider);
  final global = ref.watch(globalVariableStateProvider);
  final notifier = SpecimenHistoryNotifier(sid : global.sid!, repository: repository);
  return notifier;
});

class SpecimenHistoryNotifier
    extends StateNotifier<ModelBase?> {

  final FirestoreRepository repository;
final String sid;

  SpecimenHistoryNotifier({required this.sid, required this.repository})
      : super(ModelBaseLoading()) {
    getSpecimenHistory();
  }

  Future<ModelBase> getSpecimenHistory() async {
    try {
      state = ModelBaseLoading();


      List<SearchHistoryModel> resp =
          await repository.getSpecimenHistory(sid);
      state = SearchHistoryMainModel(history: resp);
      return SearchHistoryMainModel(history: resp);
    } catch (e) {
      print(e.toString());
      state = ModelBaseError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }

  Future<ResponseModel> saveSpecimenHistory(
      {required SearchHistoryModel body}) async {
    try {
      final resp = await repository.saveSpecimenHistory(
          body: body, sid: sid);


      return resp;
    } catch (e) {

      print(e);
      return ResponseModel(message: '에러가 발생하였습니다.', isSuccess: false);
    }
  }

  Future<ResponseModel> delSpecimenHistory(
      {required SearchHistoryModel body}) async {
    try {

      final resp = await repository.delSpecimenHistory(
          sid: sid, body: body);
      await getSpecimenHistory();
      return resp;
    } catch (e) {
      return ResponseModel(message: '에러가 발생하였습니다.', isSuccess: false);
    }
  }
}
