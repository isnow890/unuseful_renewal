import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:unuseful/user/model/user_model.dart';

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

  Future<void> getMe() async {
    state = null;
    return;
    final accessKey = await storage.read(key: CONST_ACCESS_KEY);



    if (accessKey == null) state = null;
    else

    state = null;
  }

  //로그인 로직
  Future<UserModelBase> login(
      {required String HSP_TP_CD,
      required String STF_NO,
      required String PASSWORD}) async {
    try {
      state = UserModelLoading();



      print('login 시작');
      print('HSP_TP_CD is $HSP_TP_CD');
      print('STF_NO is $STF_NO');
      print('PASSWORD is $PASSWORD');


      //테스트 용도
      final resp = UserModel(
          HSP_TP_CD: HSP_TP_CD,
          STF_NO: STF_NO,
          MESSAGE: '',
          STF_NM: 'ycw',
          DEPT_CD: 'LMT',
          DEPT_NM: '',
          DR_YN: false,
          HITDUTY_YN: true,
          ADVANCE_TYPE: AdvanceType.master,
          ACCESS_KEY: 'abc');

      //실제
      // final resp = await authRepository.login(
      //     HSP_TP_CD: HSP_TP_CD, STF_NO: STF_NO, PASSWORD: PASSWORD);

      if (resp.MESSAGE == '') {

        print('save');

        await storage.write(key: CONST_ACCESS_KEY, value: resp.ACCESS_KEY);
        await storage.write(key: CONST_STF_NO, value: resp.STF_NO);
        await storage.write(key: CONST_HSP_TP_CD, value: resp.HSP_TP_CD);
        state = resp;
      } else {
        state = UserModelError(message: resp.MESSAGE);
      }
      return resp;
    } catch (e) {
      state = UserModelError(message: '로그인에 실패했습니다.');
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
