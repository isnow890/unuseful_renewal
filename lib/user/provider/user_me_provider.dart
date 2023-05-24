import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:unuseful/user/model/user_model.dart';

import '../../common/const/data.dart';
import '../repository/auth_repository.dart';
import '../repository/user_me_repository.dart';

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final UserMeRepository repository;
  final AuthRepository authRepository;
  final FlutterSecureStorage storage;

  UserMeStateNotifier(
      {required this.storage,
      required this.repository,
      required this.authRepository})
      : super(UserModelLoading()) {}


  //로그인 로직
  Future<UserModelBase> login(
      {required String HSP_TP_CD, required String STF_NO, required String PASSWORD}) async {
    try {
      state = UserModelLoading();
      final resp =
      await authRepository.login(HSP_TP_CD: HSP_TP_CD, STF_NO:  STF_NO, PASSWORD: PASSWORD);

      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.ACCESS_TOKEN);

      final userResp = await repository.getMe();
      state = userResp;
      return userResp;
    } catch (e) {
      state = UserModelError(message: '로그인에 실패했습니다.');
      return Future.value(state);
    }
  }

  //로그아웃 로직
  Future<void> logout() async {
    state = null;
    Future.wait([
      storage.delete(key: ACCESS_TOKEN_KEY),
    ]);
  }

}
