import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/model/response_model.dart';
import 'package:unuseful/common/model/search_history_specimen_model.dart';
import 'package:unuseful/common/repository/firestore_repository.dart';

import '../../user/model/user_model.dart';
import '../../user/provider/user_me_provider.dart';

final specimenHistoryNotfierProvider = StateNotifierProvider<
    SpecimenHistoryNotifier, SearchHistorySpecimenModelBase?>((ref) {
  final repository = ref.watch(firestorageRepositoryProvider);
  final notifier = SpecimenHistoryNotifier(ref: ref, repository: repository);
  return notifier;
});

class SpecimenHistoryNotifier
    extends StateNotifier<SearchHistorySpecimenModelBase?> {
  final Ref ref;

  final FirestoreRepository repository;

  SpecimenHistoryNotifier({required this.ref, required this.repository})
      : super(SearchHistorySpecimenModelLoading()) {
    getSpecimenHistory();
  }

  Future<SearchHistorySpecimenModelBase> getSpecimenHistory() async {
    try {
      state = SearchHistorySpecimenModelLoading();

      final user = ref.read(userMeProvider.notifier).state;
      final convertedUser = user as UserModel;

      List<SearchHistorySpecimenModel> resp =
          await repository.getSpecimenHistory(convertedUser.sid!);
      state = SearchHistorySpecimenMainModel(specimenHistory: resp);
      return SearchHistorySpecimenMainModel(specimenHistory: resp);
    } catch (e) {
      print(e.toString());
      state = SearchHistorySpecimenModelError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }

  Future<ResponseModel> saveSpecimenHistory(
      {required SearchHistorySpecimenModel body}) async {
    try {

      final user = ref.read(userMeProvider.notifier).state;
      final convertedUser = user as UserModel;



      final resp = await repository.saveSpecimenHistory(body: body,sid:convertedUser.sid
      !);
      await getSpecimenHistory();

      return resp;
    } catch (e) {
      return ResponseModel(message: '에러가 발생하였습니다.', isSuccess: false);
    }
  }

  Future<ResponseModel> delSpecimenHistory(
      {required SearchHistorySpecimenModel body}) async {
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
