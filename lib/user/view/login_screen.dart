import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/const/data.dart';
import 'package:unuseful/user/model/login_model.dart';
import 'package:unuseful/user/provider/user_me_provider.dart';

import '../../common/component/custom_text_form_field.dart';
import '../../common/component/general_toast_message.dart';
import '../../common/const/colors.dart';
import '../../common/layout/default_layout.dart';
import '../../common/secure_storage/secure_storage.dart';
import '../repository/login_variable_provider.dart';

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

  final stfNoController = TextEditingController();

  @override
  void initState() {
    // stfNo = widget.stfNo;

    super.initState();
    // TODO: implement initState
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
  }

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(userMeProvider);

    // if (widget.stfNo != null)
    //   print('widget.stfNo : ' + widget.stfNo!);

    // print('widget.stfNo : ' + widget.stfNo!);

    final loginValue = ref.watch(loginVariableStateProvider);

    final storage = ref.watch(secureStorageProvider);

    // print('loginValue.STF_NO : ' + loginValue.STF_NO.toString());
    // print('loginValue.HSP_TP_CD : ' + loginValue.HSP_TP_CD.toString());

    setState(() {});
    return FutureBuilder<String?>(
        future: storage.read(key: CONST_STF_NO),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            stfNo = snapshot.data;
            stfNoController.value = (TextEditingValue(text: stfNo ?? ''));

          }

          print('stfNo is ' + (stfNo ?? 'hoho'));

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
                        // initValue: stfNo,
                        controller: stfNoController,
                        hintText: '사번을 입력해주세요.',
                        onChanged: (value) {
                          // print('변경함');

                          stfNo = value!;

                          // ref
                          //     .read(loginVariableStateProvider.notifier)
                          //     .update(stfNo: value!);
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

                          // ref
                          //     .read(loginVariableStateProvider.notifier)
                          //     .update(password: value!);
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      //dio post 요청 보내기
                      ElevatedButton(
                        onPressed: () {
                          // print('stfNo'+stfNo);
                          // print('password'+password);
                          //

                          if (validateBeforeLogin(LoginModel(
                              HSP_TP_CD: loginValue.HSP_TP_CD,
                              STF_NO: stfNo,
                              PASSWORD: password))) {
                            ref.read(userMeProvider.notifier).login(
                                HSP_TP_CD: loginValue.HSP_TP_CD!,
                                STF_NO: stfNo!,
                                PASSWORD: password!);
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
                          primary: PRIMARY_COLOR,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  bool validateBeforeLogin(LoginModel model) {
    print(model.HSP_TP_CD);
    print(model.STF_NO);
    print(model.PASSWORD);

    if (model.HSP_TP_CD == null) {
      print('hspTpCd is null');
      showToast(msg: 'HspTpCd is required to login');
      return false;
    } else if (model.STF_NO == null) {
      showToast(msg: 'StfNo is required to login');
      return false;
    } else if (model.PASSWORD == null) {
      showToast(msg: 'Password is required to login');
      return false;
    }
    return true;
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
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:unuseful/common/const/data.dart';
// import 'package:unuseful/user/model/login_model.dart';
// import 'package:unuseful/user/provider/user_me_provider.dart';
//
// import '../../common/component/custom_text_form_field.dart';
// import '../../common/component/general_toast_message.dart';
// import '../../common/const/colors.dart';
// import '../../common/layout/default_layout.dart';
// import '../../common/model/initial_data_from_secure_storage.dart';
// import '../../common/secure_storage/secure_storage.dart';
// import '../repository/login_variable_provider.dart';
//
// class LoginScreen extends ConsumerStatefulWidget {
//   const LoginScreen(this.stfNo, {Key? key}) : super(key: key);
//
//   final String? stfNo;
//
//   static String get routeName => 'login';
//
//   @override
//   ConsumerState<LoginScreen> createState() => _LogInScreenState();
// }
//
// class _LogInScreenState extends ConsumerState<LoginScreen> {
//   @override
//   void initState() {
//     super.initState();
//
//     // TODO: implement initState
//   }
//
//   @override
//   void setState(VoidCallback fn) {
//     // TODO: implement setState
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // final state = ref.watch(userMeProvider);
//
//     // if (widget.stfNo != null)
//     //   print('widget.stfNo : ' + widget.stfNo!);
//
//     // print('widget.stfNo : ' + widget.stfNo!);
//
//     final loginValue = ref.watch(loginVariableStateProvider);
//
//     // print('loginValue.STF_NO : ' + loginValue.STF_NO.toString());
//     // print('loginValue.HSP_TP_CD : ' + loginValue.HSP_TP_CD.toString());
//
//     final surveyDateController = textcontroller(text: widget.stfNo);
//
//     setState(() {
//       // surveyDateController.text = '33333';
//     });
//     return DefaultLayout(
//       //SingleChildScrollView를 선언하여 키보드가 튀어나와도 화면 에러 안나도록
//       child: SingleChildScrollView(
//         //드래그 하면 키보드 집어넣기.
//         keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//         child: SafeArea(
//           top: true,
//           bottom: false,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 16.0,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 _Title(),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 _SubTitle(),
//                 //사이즈 2/3
//                 Image.asset(
//                   'asset/img/logo/main_logo.png',
//                   width: MediaQuery.of(context).size.width / 3,
//                   height: MediaQuery.of(context).size.height / 3 * 1.3,
//                 ),
//
//                 Row(
//                   children: [
//                     Expanded(
//                       child: RadioListTile(
//                           title: Text('se'),
//                           value: '01',
//                           activeColor: PRIMARY_COLOR,
//                           groupValue: loginValue.HSP_TP_CD,
//                           onChanged: (value) {
//                             FocusManager.instance.primaryFocus?.unfocus();
//
//                             ref
//                                 .read(loginVariableStateProvider.notifier)
//                                 .update(hspTpCd: value!);
//                             // print('업데이트 후2'+value);
//                           }),
//                     ),
//                     Expanded(
//                       child: RadioListTile(
//                           title: Text('md'),
//                           value: '02',
//                           groupValue: loginValue.HSP_TP_CD,
//                           activeColor: PRIMARY_COLOR,
//                           onChanged: (value) {
//                             FocusManager.instance.primaryFocus?.unfocus();
//
//                             ref
//                                 .read(loginVariableStateProvider.notifier)
//                                 .update(hspTpCd: value!);
//                           }),
//                     ),
//                   ],
//                 ),
//                 CustomTextFormField(
//                   // controller: surveyDateController,
//                   initValue: widget.stfNo,
//                   hintText: '사번을 입력해주세요.',
//                   onChanged: (value) {
//                     print('변경함');
//
//                     ref
//                         .read(loginVariableStateProvider.notifier)
//                         .update(stfNo: value!);
//                   },
//                 ),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 CustomTextFormField(
//                   initValue: loginValue.PASSWORD,
//                   hintText: '비밀번호를 입력해주세요.',
//                   obscureText: true,
//                   onChanged: (value) {
//                     ref
//                         .read(loginVariableStateProvider.notifier)
//                         .update(password: value!);
//                   },
//                 ),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 //dio post 요청 보내기
//                 ElevatedButton(
//                   onPressed: () {
//                     if (validateBeforeLogin(loginValue)) {
//                       ref.read(userMeProvider.notifier).login(
//                           HSP_TP_CD: loginValue.HSP_TP_CD!,
//                           STF_NO: loginValue.STF_NO!,
//                           PASSWORD: loginValue.PASSWORD!);
//                     }
//                   },
//                   // onPressed: state is UserModelLoading
//                   //     ? null
//                   //     : () async {
//                   //         validateRequiredItem(
//                   //             radioTile, stfNo, password);
//                   //
//                   //         // ref.read(userMeProvider.notifier).login(username: username, password: password);
//                   //       },
//                   child: Text('로그인'),
//                   style: ElevatedButton.styleFrom(
//                     primary: PRIMARY_COLOR,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   bool validateBeforeLogin(LoginModel model) {
//     print('어허');
//     print(model.HSP_TP_CD);
//     print(model.STF_NO);
//     print(model.PASSWORD);
//
//     if (model.HSP_TP_CD == null) {
//       print('hspTpCd is null');
//       showToast(msg: 'HspTpCd is required to login');
//       return false;
//     } else if (model.STF_NO == null) {
//       showToast(msg: 'StfNo is required to login');
//       return false;
//     } else if (model.PASSWORD == null) {
//       showToast(msg: 'Password is required to login');
//       return false;
//     }
//     return true;
//   }
// }
//
// class _Title extends StatelessWidget {
//   const _Title({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       'Hiya, Hello',
//       style: TextStyle(
//         fontSize: 34,
//         fontWeight: FontWeight.w600,
//       ),
//     );
//   }
// }
//
// class _SubTitle extends StatelessWidget {
//   const _SubTitle({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       '사번과 비밀번호를 입력해서 로그인해주세요.',
//       style: TextStyle(
//         fontSize: 16,
//         color: BODY_TEXT_COLOR,
//       ),
//     );
//   }
// }
