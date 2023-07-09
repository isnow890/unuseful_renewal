import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:unuseful/user/model/login_model.dart';
import 'package:unuseful/user/provider/user_me_provider.dart';
import 'package:unuseful/user/view/join_screen.dart';

import '../../common/component/custom_text_form_field.dart';
import '../../common/component/general_toast_message.dart';
import '../../common/const/colors.dart';
import '../../common/layout/default_layout.dart';
import '../model/user_model.dart';
import '../provider/joing_now_provider.dart';
import '../provider/login_variable_provider.dart';

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

  getStfNo() async {
    final loginValue = ref.read(stfNoProvider);
    stfNo = await loginValue;
    stfNoController.value = (TextEditingValue(text: stfNo ?? ''));
  }

  @override
  void initState() {
    // stfNo = widget.stfNo;

    super.initState();
    getStfNo();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userMeProvider);
    final loginValue = ref.watch(loginVariableStateProvider);
    // print(loginValue.STF_NO);
    // stfNoController.value = (TextEditingValue(text: loginValue.STF_NO ?? ''));

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
                _renderHospitalSegmentHelper(loginValue),
                const SizedBox(
                  height: 12,
                ),
                CustomTextFormField(
                  controller: stfNoController,
                  hintText: '이메일 주소를 입력해주세요.',
                  onChanged: (value) {
                    // print(value);
                    stfNo = value!;
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
                ElevatedButton(
                  onPressed: state is UserModelLoading
                      ? null
                      : () {
                          if (validateBeforeLogin(LoginModel(
                              hspTpCd: loginValue.hspTpCd,
                              stfNo: stfNo,
                              password: password))) {
                            ref.read(userMeProvider.notifier).login(
                                hspTpCd: loginValue.hspTpCd!,
                                stfNo: stfNo!,
                                password: password!);
                          }
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
                    backgroundColor: PRIMARY_COLOR,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {

                        ref.read(joinNowProvider.notifier).update((state) => true);
                        context.pushNamed(JoinScreen.routeName);
                      },
                      child: Text(
                        '회원 가입',
                        style: TextStyle(
                          color: BODY_TEXT_COLOR,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('|',
                        style: TextStyle(
                          color: BODY_TEXT_COLOR,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        '비밀번호 재설정',
                        style: TextStyle(
                          color: BODY_TEXT_COLOR,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateBeforeLogin(LoginModel model) {
    // print('validation 시작');
    // print(model.HSP_TP_CD);
    // print(model.STF_NO);
    // print(model.PASSWORD);

    if (model.hspTpCd == null) {
      showToast(msg: 'HspTpCd is required to login');
      return false;
    } else if (model.stfNo == null || model.stfNo == '') {
      showToast(msg: 'StfNo is required to login');
      return false;
    } else if (model.password == null) {
      showToast(msg: 'Password is required to login');
      return false;
    }
    return true;
  }

  _renderHospitalSegmentHelper(LoginModel loginValue) {
    return Row(
      children: [
        Expanded(
          child: MaterialSegmentedControl(
            children: {
              0: Text(
                '서울',
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              ),
              1: Text(
                '목동',
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              )
            },
            horizontalPadding: const EdgeInsets.all(0),
            selectionIndex: hspType,
            borderColor: Colors.grey,
            selectedColor: PRIMARY_COLOR,
            unselectedColor: Colors.white,
            selectedTextStyle: TextStyle(color: Colors.white),
            unselectedTextStyle: TextStyle(color: PRIMARY_COLOR),
            borderWidth: 0.7,
            borderRadius: 6.0,
            verticalOffset: 12.0,
            onSegmentTapped: (index) {
              print(index);
              ref
                  .read(loginVariableStateProvider.notifier)
                  .updateModel(hspTpCd: index == 0 ? "01" : "02");
              setState(() {
                hspType = index;
              });
            },
          ),
        ),
      ],
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
      '이메일 주소와 비밀번호를 입력해서 로그인해주세요.',
      style: TextStyle(
        fontSize: 15,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
