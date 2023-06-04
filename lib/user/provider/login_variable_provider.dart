import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:unuseful/common/secure_storage/secure_storage.dart';
import 'package:unuseful/user/model/login_model.dart';

import '../../common/const/data.dart';


final stfNoProvider = StateProvider((ref) async => await ref.watch(secureStorageProvider).read(key: CONST_STF_NO));

final loginVariableStateProvider = StateNotifierProvider<LoginVariableStateNofifier,LoginModel>((ref) {
  final secure = ref.watch(secureStorageProvider);
  final notifier =LoginVariableStateNofifier(secure: secure);


  return LoginVariableStateNofifier(secure: secure);
});

class LoginVariableStateNofifier extends StateNotifier<LoginModel> {
  final FlutterSecureStorage secure;

  LoginVariableStateNofifier({
    required this.secure,
  }) : super(LoginModel()) {
    getVariableFromSecureStorage();
  }
   Future <LoginModel> getVariableFromSecureStorage() async {
    final stfNo = await secure.read(key: CONST_STF_NO);
    final password = await secure.read(key: CONST_PASSWORD);
    final hspTpCd = await secure.read(key: CONST_HSP_TP_CD);
    state = LoginModel(hspTpCd: hspTpCd, stfNo: stfNo, password: password);
    return LoginModel(hspTpCd: hspTpCd, stfNo: stfNo, password: password);
  }

  void updateModel({ String? hspTpCd,String? stfNo, String? password}){
    //print('hspTpCd??'+state.HSP_TP_CD!);

    final tmpStfNo = state.stfNo;
    final  tmpPassword= state.password;
    final tmpHspTpCd = state.hspTpCd;

    print('updateModel')
    ;
    print(tmpHspTpCd);

    state = LoginModel(hspTpCd:hspTpCd ??tmpHspTpCd, stfNo: stfNo??tmpStfNo,
    password: password?? tmpPassword);
  }

}
