import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:unuseful/common/secure_storage/secure_storage.dart';
import 'package:unuseful/user/model/login_model.dart';

import '../../common/const/data.dart';





final loginVariableStateProvider = StateNotifierProvider<LoginVariableStateNofifier,LoginModel>((ref) {
  final secure = ref.watch(secureStorageProvider);
  final notifier = LoginVariableStateNofifier(secure: secure);
  return notifier;
});

class LoginVariableStateNofifier extends StateNotifier<LoginModel> {
  final FlutterSecureStorage secure;

  LoginVariableStateNofifier({
    required this.secure,
  }) : super(LoginModel()) {
    getVariableFromSecureStorage();
  }

  Future<void> getVariableFromSecureStorage() async {
    final STF_NO = await secure.read(key: CONST_STF_NO);
    final PASSWORD = await secure.read(key: CONST_PASSWORD);
    final HSP_TP_CD = await secure.read(key: CONST_HSP_TP_CD);
    state =
        LoginModel(HSP_TP_CD: HSP_TP_CD, STF_NO: STF_NO, PASSWORD: PASSWORD);
  }

  void update({ String? hspTpCd=null,String? stfNo=null, String? password=null}){
    print('hspTpCd??'+state.HSP_TP_CD!);

    final tmpStfNo = state.STF_NO;
    final  tmpPassword= state.PASSWORD;
    final tmpHspTpCd = state.HSP_TP_CD;

    state = LoginModel(HSP_TP_CD:hspTpCd ??tmpHspTpCd, STF_NO: stfNo??tmpStfNo,
    PASSWORD: password?? tmpPassword);
  }

}
