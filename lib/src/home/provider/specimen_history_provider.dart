import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/firebase/repository/firestore_repository.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/common/model/response_model.dart';
import 'package:unuseful/src/home/model/search_history_main_model.dart';

import '../../user/model/user_model.dart';
import '../../user/provider/user_me_provider.dart';

final specimenHistoryNotfierProvider = StateNotifierProvider.autoDispose<
    SpecimenHistoryNotifier, ModelBase?>((ref) {
  final repository = ref.watch(firestorageRepositoryProvider);
  final notifier = SpecimenHistoryNotifier(ref: ref, repository: repository);
  return notifier;
});

class SpecimenHistoryNotifier
    extends StateNotifier<ModelBase?> {
  final Ref ref;

  final FirestoreRepository repository;

  SpecimenHistoryNotifier({required this.ref, required this.repository})
      : super(ModelBaseLoading()) {
    getSpecimenHistory();
  }

  Future<ModelBase> getSpecimenHistory() async {
    try {
      state = ModelBaseLoading();

      final user = ref.read(userMeProvider.notifier).state;
      final convertedUser = user as UserModel;

      List<SearchHistoryModel> resp =
          await repository.getSpecimenHistory(convertedUser.sid!);
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
      final user = ref.read(userMeProvider.notifier).state;
      final convertedUser = user as UserModel;

      final resp = await repository.saveSpecimenHistory(
          body: body, sid: convertedUser.sid!);

      print(resp);

      return resp;
    } catch (e) {

      print(e);
      return ResponseModel(message: '에러가 발생하였습니다.', isSuccess: false);
    }
  }

  Future<ResponseModel> delSpecimenHistory(
      {required SearchHistoryModel body}) async {
    try {
      final user = ref.read(userMeProvider.notifier).state;
      final convertedUser = user as UserModel;
      final resp = await repository.delSpecimenHistory(
          sid: convertedUser.sid!, body: body);
      await getSpecimenHistory();
      return resp;
    } catch (e) {
      return ResponseModel(message: '에러가 발생하였습니다.', isSuccess: false);
    }
  }
}
