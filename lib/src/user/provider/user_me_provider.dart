import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unuseful/data.dart';
import 'package:unuseful/secure_storage/secure_storage.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/user/model/user_model.dart';
import 'package:unuseful/src/user/provider/gloabl_variable_provider.dart';
import 'package:unuseful/src/user/repository/auth_repository.dart';
import 'package:unuseful/src/user/repository/user_me_repository.dart';
import 'package:unuseful/theme/component/general_toast_message.dart';

final userMeProvider =
    StateNotifierProvider<UserMeStateNotifier, ModelBase?>((ref) {
  final repository = ref.watch(userMeRepositoryProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  final secureStorage = ref.watch(secureStorageProvider);

  return UserMeStateNotifier(
      repository: repository,
      authRepository: authRepository,
      ref: ref,
      secureStorage: secureStorage);
});

class UserMeStateNotifier extends StateNotifier<ModelBase?> {
  final UserMeRepository repository;
  final AuthRepository authRepository;
  final Ref ref;
  final FlutterSecureStorage secureStorage;

  UserMeStateNotifier({
    required this.secureStorage,
    required this.ref,
    required this.repository,
    required this.authRepository,
  }) : super(ModelBaseLoading()) {
    getMe();
  }

  Future<ModelBase> getMe() async {
    try {
      final resp = await repository.getMe();
      if (resp.message == null) {
        state = resp;

        final hspTpCd = await secureStorage.read(key: CONST_HSP_TP_CD);

        ref
            .read(globalVariableStateProvider.notifier)
            .update(user: resp.copyWIth(hspTpCd: hspTpCd));
      } else {
        showToast(msg: resp.message!, toastLength: Toast.LENGTH_LONG);
      }
      return resp;
    } catch (e) {
      state = ModelBaseError(message: '로그인에 실패했습니다.');
      // showToast(msg: '로그인에 실패했습니다.');
      return Future.value(state);
    }
  }

  //로그인 로직
  Future<ModelBase> login(
      {required String hspTpCd,
      required String stfNo,
      required String password}) async {
    try {
      state = ModelBaseLoading();
      //실제
      final resp = await authRepository.login(
          hspTpCd: hspTpCd, stfNo: stfNo, password: password);

      //로그인 성공
      if (resp.message == null) {
        state = resp;

        //global 변수 업데이트
        ref
            .read(globalVariableStateProvider.notifier)
            .update(user: resp.copyWIth(hspTpCd: hspTpCd));
      }
      //실패
      else {
        // showToast(msg: resp.message!);
        await logout();
        // state = UserModelError(message: resp.message);
      }
      return resp;
    } catch (e) {
      state = ModelBaseError(message: '로그인에 실패했습니다.');
      await logout();

      return Future.value(state);
    }
  }

  //로그아웃 로직
  Future<void> logout() async {
    state = null;

    ref.read(globalVariableStateProvider.notifier).delete();
  }
}
