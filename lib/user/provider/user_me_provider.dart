import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unuseful/user/model/user_model.dart';

import '../../common/component/general_toast_message.dart';
import '../../common/const/data.dart';
import '../../common/secure_storage/secure_storage.dart';
import '../repository/auth_repository.dart';
import '../repository/user_me_repository.dart';

final userMeProvider =
    StateNotifierProvider<UserMeStateNotifier, UserModelBase?>((ref) {
  final repository = ref.watch(userMeRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);
  final authRepository = ref.watch(authRepositoryProvider);

  return UserMeStateNotifier(
      repository: repository, storage: storage, authRepository: authRepository);
});

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final UserMeRepository repository;
  final AuthRepository authRepository;
  final FlutterSecureStorage storage;

  UserMeStateNotifier(
      {required this.storage,
      required this.repository,
      required this.authRepository})
      : super(UserModelLoading()) {
    getMe();
  }

  Future<UserModelBase> getMe() async {
    try {
      final resp = await repository.getMe();
      print('getMe 실행됨');

      if (resp.message == null) {
        state = resp;
      } else {
        showToast(msg: resp.message!, toastLength: Toast.LENGTH_LONG);
      }
      return resp;
    } catch (e) {
      print(e.toString());
      state = UserModelError(message: '로그인에 실패했습니다.');
      // showToast(msg: '로그인에 실패했습니다.');

      return Future.value(state);
    }
  }

  //로그인 로직
  Future<UserModelBase> login(
      {required String hspTpCd,
      required String stfNo,
      required String password}) async {
    try {
      state = UserModelLoading();
      //
      print('login 시작');
      print('hspTpCd is $hspTpCd');
      print('stfNo is $stfNo');
      print('password is $password');

      //실제
      final resp = await authRepository.login(
          hspTpCd: hspTpCd, stfNo: stfNo, password: password);

      if (resp.message == null) {
        await storage.write(key: CONST_ACCESS_KEY, value: resp.accessKey);
        await storage.write(key: CONST_STF_NO, value: resp.stfNo);
        await storage.write(key: CONST_HSP_TP_CD, value: hspTpCd);
        state = resp;
      } else {
        showToast(msg: resp.message!);
        await logout();
        // state = UserModelError(message: resp.message);
      }
      return resp;
    } catch (e) {
      print(e.toString());
      state = UserModelError(message: '로그인에 실패했습니다.');
      showToast(msg: '로그인에 실패했습니다.');
      await logout();

      return Future.value(state);
    }
  }

  //로그아웃 로직
  Future<void> logout() async {
    state = null;
    Future.wait([
      storage.delete(key: CONST_ACCESS_KEY),
    ]);
  }
}
