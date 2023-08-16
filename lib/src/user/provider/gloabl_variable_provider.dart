import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:unuseful/data.dart';
import 'package:unuseful/secure_storage/secure_storage.dart';
import 'package:unuseful/src/user/model/login_model.dart';
import 'package:unuseful/src/user/model/user_model.dart';

final globalVariableStateProvider =
    StateNotifierProvider<GlobalVariableStateNofifier, UserModel>((ref) {
  final secure = ref.watch(secureStorageProvider);
  final notifier = GlobalVariableStateNofifier(secureStorage: secure);

  return GlobalVariableStateNofifier(secureStorage: secure);
});

class GlobalVariableStateNofifier extends StateNotifier<UserModel> {
  final FlutterSecureStorage secureStorage;

  GlobalVariableStateNofifier({
    required this.secureStorage,
  }) : super(UserModel()) {
    getVariable();
  }

  Future<UserModel> getVariable() async {
    var stfNo = await secureStorage.read(
      key: CONST_STF_NO,
    );
    var hspTpCd = await secureStorage.read(key: CONST_HSP_TP_CD);
    var accessKey = await secureStorage.read(key: CONST_ACCESS_KEY);

    state = UserModel(stfNo: stfNo, hspTpCd: hspTpCd, accessKey: accessKey);
    return UserModel(stfNo: stfNo, hspTpCd: hspTpCd, accessKey: accessKey);
  }

  void update({required UserModel user}) async {
    print('업데이트 시작');
    await secureStorage.write(key: CONST_ACCESS_KEY, value: user.accessKey);
    await secureStorage.write(key: CONST_STF_NO, value: user.stfNo);
    await secureStorage.write(key: CONST_HSP_TP_CD, value: user.hspTpCd);
    state = user;
    print(state);
  }

  void delete() async {
    //
    await secureStorage.delete(
      key: CONST_ACCESS_KEY,
    );
  }
}
