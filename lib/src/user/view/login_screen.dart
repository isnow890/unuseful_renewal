import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/user/model/login_model.dart';
import 'package:unuseful/src/user/provider/user_me_provider.dart';
import 'package:unuseful/src/user/view/join_screen.dart';
import 'package:unuseful/theme/component/button/button.dart';
import 'package:unuseful/theme/component/custom_text_form_field.dart';
import 'package:unuseful/theme/component/general_toast_message.dart';
import 'package:unuseful/theme/component/segment_button.dart';
import 'package:unuseful/theme/component/toast/toast.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';
import '../../../colors.dart';
import '../model/user_model.dart';
import '../provider/joing_now_provider.dart';
import '../provider/gloabl_variable_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen(this.stfNo, {Key? key}) : super(key: key);
  final String? stfNo;

  static String get routeName => 'login';

  @override
  ConsumerState<LoginScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LoginScreen> {
  String? hspTpCd;
  String? stfNo;
  String? password;
  int hspType = 0;

  final stfNoController = TextEditingController();

  initValue() async {
    final global =
        await ref.read(globalVariableStateProvider.notifier).getVariable();
    stfNo = global.stfNo;
    hspType = global.hspTpCd == '02' ? 1 : 0;
    stfNoController.value = (TextEditingValue(text: stfNo ?? ''));
  }

  String hspTypeConvert(int hspTpType) {
    return hspType == 0 ? '01' : '02';
  }

  void onSegmentButtonValueChanged(int index) {
    setState(() {
      hspType = index;
    });
  }

  @override
  void initState() {
    // stfNo = widget.stfNo;
    super.initState();
    initValue();
    // TODO: implement initState
  }

  void login() async {
    if (_loginValidation(LoginModel(
        hspTpCd: hspTypeConvert(hspType), stfNo: stfNo, password: password))) {
      var loginResult = await ref.read(userMeProvider.notifier).login(
          hspTpCd: hspTypeConvert(hspType), stfNo: stfNo!, password: password!);
      //로그인 실패시
      if (loginResult is ModelBaseError) {
        Toast.show(loginResult.message);
      }
    }
  }

  bool _loginValidation(LoginModel model) {
    // print('validation 시작');
    // print(model.HSP_TP_CD);
    // print(model.STF_NO);
    // print(model.PASSWORD);

    if (model.hspTpCd == null) {
      Toast.show('병원을 선택해주세요.');
      return false;
    } else if (model.stfNo == null || model.stfNo == '') {
      Toast.show('사번을 입력해주세요.');
      return false;
    } else if (model.password == null) {
      Toast.show('비밀번호를 입력해주세요.');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userMeProvider);
    // final loginValue = ref.watch(globalVariableStateProvider);
    final theme = ref.watch(themeServiceProvider);

    // print(loginValue.STF_NO);
    // stfNoController.value = (TextEditingValue(text: loginValue.STF_NO ?? ''));

    return Scaffold(
      //SingleChildScrollView를 선언하여 키보드가 튀어나와도 화면 에러 안나도록
      body: SingleChildScrollView(
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
                const SizedBox(
                  height: 16,
                ),
                _Title(),
                const SizedBox(
                  height: 10,
                ),
                const _SubTitle(),
                const SizedBox(
                  height: 16,
                ),
                //사이즈 2/3
                Image.asset(
                  'asset/img/logo/main_logo.png',
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.height / 4 * 1.3,
                ),

                // Row(
                //   children: [
                //     Expanded(
                //       child: RadioListTile(
                //           title: Text('se'),
                //           value: '01',
                //           activeColor: PRIMARY_COLOR,
                //           groupValue: loginValue.hspTpCd,
                //           onChanged: (value) {
                //             FocusManager.instance.primaryFocus?.unfocus();
                //
                //             ref
                //                 .read(loginVariableStateProvider.notifier)
                //                 .updateModel(hspTpCd: value!);
                //
                //             // print('업데이트 후2'+value);
                //           }),
                //     ),
                //     Expanded(
                //       child: RadioListTile(
                //           title: Text('md'),
                //           value: '02',
                //           groupValue: loginValue.hspTpCd,
                //           activeColor: PRIMARY_COLOR,
                //           onChanged: (value) {
                //             FocusManager.instance.primaryFocus?.unfocus();
                //
                //             ref
                //                 .read(loginVariableStateProvider.notifier)
                //                 .updateModel(hspTpCd: value!);
                //           }),
                //     ),
                //   ],
                // ),

                const SizedBox(
                  height: 12,
                ),
                SegmentButton(
                  children: //
                      {
                    0: Text(
                      '서울',
                    ),
                    1: Text(
                      '목동',
                    ),
                  },
                  selectionIndex: hspType,
                  onSegmentTapped: onSegmentButtonValueChanged,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextFormField(
                  controller: stfNoController,
                  hintText: '사번을 입력해주세요.',
                  onChanged: (value) {
                    // print(value);
                    stfNo = value;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요.',
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                //dio post 요청 보내기
                Button(
                  text: '로그인',
                  onPressed: state is ModelBaseLoading ? null : login,
                ),
                const SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //
                //         ref.read(joinNowProvider.notifier).update((state) => true);
                //         context.pushNamed(JoinScreen.routeName);
                //       },
                //       child: Text(
                //         '회원 가입',
                //         style: TextStyle(
                //           color: BODY_TEXT_COLOR,
                //         ),
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     const Text('|',
                //         style: TextStyle(
                //           color: BODY_TEXT_COLOR,
                //         )),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     GestureDetector(
                //       onTap: () {},
                //       child: Text(
                //         '비밀번호 재설정',
                //         style: TextStyle(
                //           color: BODY_TEXT_COLOR,
                //         ),
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
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
        fontSize: 15,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
