import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/model/response_model.dart';
import 'package:unuseful/common/model/search_history_telephone_model.dart';
import 'package:unuseful/common/repository/firestore_repository.dart';

import '../../user/model/user_model.dart';
import '../../user/provider/user_me_provider.dart';

final telephoneHistoryNotfierProvider = StateNotifierProvider<
    TelephoneHistoryNotifier, SearchHistoryTelephoneModelBase?>((ref) {
  final repository = ref.watch(firestorageRepositoryProvider);
  final notifier = TelephoneHistoryNotifier(ref: ref, repository: repository);
  return notifier;
});

class TelephoneHistoryNotifier
    extends StateNotifier<SearchHistoryTelephoneModelBase?> {
  final Ref ref;

  final FirestoreRepository repository;

  TelephoneHistoryNotifier({required this.ref, required this.repository})
      : super(SearchHistoryTelephoneModelLoading()) {
    getTelephoneHistory();
  }

  Future<SearchHistoryTelephoneModelBase> getTelephoneHistory() async {
    try {
      state = SearchHistoryTelephoneModelLoading();

      final user = ref.read(userMeProvider.notifier).state;
      final convertedUser = user as UserModel;

      List<SearchHistoryTelephoneModel> resp =
          await repository.getTelephoneHistory(convertedUser.sid!);
      state = SearchHistoryTelephoneMainModel(telephoneHistory: resp);
      return SearchHistoryTelephoneMainModel(telephoneHistory: resp);
    } catch (e) {
      print(e.toString());
      state = SearchHistoryTelephoneModelError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }

  Future<ResponseModel> saveTelephoneHistory(
      {required SearchHistoryTelephoneModel body}) async {
    try {
      final user = ref.read(userMeProvider.notifier).state;
      final convertedUser = user as UserModel;

      final resp = await repository.saveTelephoneHistory(body: body,sid:convertedUser.sid!);
      await getTelephoneHistory();

      return resp;
    } catch (e) {
      return ResponseModel(message: '에러가 발생하였습니다.', isSuccess: false);
    }
  }

  Future<ResponseModel> delTelephoneHistory(
      {required SearchHistoryTelephoneModel body}) async {
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
