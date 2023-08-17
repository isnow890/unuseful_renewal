import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/firebase/repository/firestore_repository.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/common/model/response_model.dart';
import 'package:unuseful/src/home/model/search_history_main_model.dart';
import 'package:unuseful/src/home/model/search_history_telephone_model.dart';

import '../../user/model/user_model.dart';
import '../../user/provider/user_me_provider.dart';

final telephoneHistoryNotfierProvider =
    StateNotifierProvider<TelephoneHistoryNotifier, ModelBase?>((ref) {
  final repository = ref.watch(firestorageRepositoryProvider);
  final notifier = TelephoneHistoryNotifier(ref: ref, repository: repository);
  return notifier;
});

class TelephoneHistoryNotifier extends StateNotifier<ModelBase?> {
  final Ref ref;

  final FirestoreRepository repository;

  TelephoneHistoryNotifier({required this.ref, required this.repository})
      : super(ModelBaseLoading()) {
    getTelephoneHistory();
  }

  Future<ModelBase?> getTelephoneHistory() async {
    try {
      state = ModelBaseLoading();

      final user = ref.read(userMeProvider.notifier).state;
      final convertedUser = user as UserModel;

      List<SearchHistoryModel> resp =
          await repository.getTelephoneHistory(convertedUser.sid!);
      state = SearchHistoryMainModel(history: resp);
      return SearchHistoryMainModel(history: resp);
    } catch (e) {
      print(e.toString());
      state = ModelBaseError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }

  Future<ResponseModel> saveTelephoneHistory(
      {required SearchHistoryModel body}) async {
    try {
      final user = ref.read(userMeProvider.notifier).state;
      final convertedUser = user as UserModel;

      final resp = await repository.saveTelephoneHistory(
          body: body, sid: convertedUser.sid!);

      return resp;
    } catch (e) {
      return ResponseModel(message: '에러가 발생하였습니다.', isSuccess: false);
    }
  }

  Future<ResponseModel> delTelephoneHistory(
      {required SearchHistoryModel body}) async {
    try {
      final user = ref.read(userMeProvider.notifier).state;
      final convertedUser = user as UserModel;
      final resp = await repository.delTelephoneHistory(
          sid: convertedUser.sid!, body: body);
      await getTelephoneHistory();
      return resp;
    } catch (e) {
      return ResponseModel(message: '에러가 발생하였습니다.', isSuccess: false);
    }
  }
}
