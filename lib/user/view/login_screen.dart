import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/const/data.dart';
import 'package:unuseful/user/model/login_model.dart';
import 'package:unuseful/user/provider/user_me_provider.dart';

import '../../common/component/custom_text_form_field.dart';
import '../../common/component/general_toast_message.dart';
import '../../common/const/colors.dart';
import '../../common/layout/default_layout.dart';
import '../../common/model/initial_data_from_secure_storage.dart';
import '../../common/secure_storage/secure_storage.dart';
import '../repository/login_variable_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String get routeName => 'login';

  @override
  ConsumerState<LoginScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userMeProvider);
    final loginValue = ref.watch(loginVariableStateProvider);

    return DefaultLayout(
      //SingleChildScrollView를 선언하여 키보드가 튀어나와도 화면 에러 안나도록
      child: SingleChildScrollView(
        //드래그 하면 키보드 집어넣기.
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                const SizedBox(
                  height: 16,
                ),
                _SubTitle(),
                //사이즈 2/3
                Image.asset(
                  'asset/img/logo/main_logo.png',
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 3 * 1.3,
                ),

                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                          title: Text('se'),
                          value: '01',
                          activeColor: PRIMARY_COLOR,
                          groupValue: loginValue.HSP_TP_CD,
                          onChanged: (value) {
                            FocusManager.instance.primaryFocus?.unfocus();

                            ref
                                .read(loginVariableStateProvider.notifier)
                                .update(hspTpCd: value!);
                            // print('업데이트 후2'+value);
                          }),
                    ),
                    Expanded(
                      child: RadioListTile(
                          title: Text('md'),
                          value: '02',
                          groupValue: loginValue.HSP_TP_CD,
                          activeColor: PRIMARY_COLOR,
                          onChanged: (value) {
                            FocusManager.instance.primaryFocus?.unfocus();

                            ref
                                .read(loginVariableStateProvider.notifier)
                                .update(hspTpCd: value!);
                          }),
                    ),
                  ],
                ),
                CustomTextFormField(
                  initValue: loginValue.STF_NO,
                  hintText: '사번을 입력해주세요.',
                  onChanged: (value) {
                    ref
                        .read(loginVariableStateProvider.notifier)
                        .update(stfNo: value!);
                    print('변경함');
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  initValue: loginValue.PASSWORD,
                  hintText: '비밀번호를 입력해주세요.',
                  obscureText: true,
                  onChanged: (value) {
                    ref
                        .read(loginVariableStateProvider.notifier)
                        .update(password: value!);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                //dio post 요청 보내기
                ElevatedButton(
                  onPressed: () {
                    validateRequiredItem(loginValue);
                  },
                  // onPressed: state is UserModelLoading
                  //     ? null
                  //     : () async {
                  //         validateRequiredItem(
                  //             radioTile, stfNo, password);
                  //
                  //         // ref.read(userMeProvider.notifier).login(username: username, password: password);
                  //       },
                  child: Text('로그인'),
                  style: ElevatedButton.styleFrom(
                    primary: PRIMARY_COLOR,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateRequiredItem(LoginModel model) {
    print(model.HSP_TP_CD);
    print(model.STF_NO);
    print(model.PASSWORD);

    if (model.HSP_TP_CD == '') {
      print('hspTpCd is null');
      showToast(msg: 'HspTpCd is required to login');
      return false;
    } else if (model.STF_NO == '') {
      showToast(msg: 'StfNo is required to login');
      return false;
    } else if (model.PASSWORD == '') {
      showToast(msg: 'Password is required to login');
      return false;
    }
    return true;
  }
}

Future<InitialDataFromSecureStorageModel> getDataFromSecureStorage(
    WidgetRef ref) async {
  final storage = ref.watch(secureStorageProvider);

  final STF_NO = await storage.read(key: CONST_STF_NO);
  final PASSWORD = await storage.read(key: CONST_PASSWORD);
  final HSP_TP_CD = await storage.read(key: CONST_HSP_TP_CD);

  return InitialDataFromSecureStorageModel(
      STF_NO: STF_NO, PASSWORD: PASSWORD, HSP_TP_CD: HSP_TP_CD);
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Hiya, Hello',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '사번과 비밀번호를 입력해서 로그인해주세요.',
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
