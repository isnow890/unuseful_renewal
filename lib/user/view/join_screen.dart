import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/component/general_toast_message.dart';
import 'package:unuseful/common/layout/default_layout.dart';

import '../../common/component/custom_text_form_field.dart';
import '../../common/const/colors.dart';

class JoinScreen extends ConsumerStatefulWidget {
  const JoinScreen({Key? key}) : super(key: key);

  static String get routeName => 'join';

  @override
  ConsumerState<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends ConsumerState<JoinScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordAgainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();

    return DefaultLayout(
      isDrawerVisible: false,
      title: Text('Join'),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            welcomeHeaderHelper(),
            SizedBox(
              height: 15,
            ),
            _SubTitle(),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Form(
                    key: _key,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 15),
                            emailInputHelpler(),
                            const SizedBox(height: 15),
                            passwordInputHelper(),
                            const SizedBox(height: 15),
                            passwordAgainInputHelper(),
                            const SizedBox(height: 15),
                            joinButtonHelper(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  emailInputHelpler() {
    return CustomTextFormField(
        controller: emailController,
        autofocus: true,
        validator: (val) {
          if(val.isEmpty){
            focusNode.requestFocus();
            return '이메일을 입력하세요.';
          }else {
            Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regExp = new RegExp(pattern);
            if(!regExp.hasMatch(value)){
              focusNode.requestFocus();	//포커스를 해당 textformfield에 맞춘다.
              return '잘못된 이메일 형식입니다.';
            }else{
              return null;
            }
          }
        },
        labelText: '이메일',
        hintText: '그룹웨어 이메일 주소를 입력해주세요.');
  }

  passwordInputHelper() {
    return CustomTextFormField(
        controller: passwordController,
        validator: (val) {
          if (val!.isEmpty) {
            return 'The input is empty.';
          } else {
            return null;
          }
        },
        labelText: '비밀번호',
        hintText: '비밀번호를 입력해주세요.');
  }

  passwordAgainInputHelper() {
    return CustomTextFormField(
        controller: passwordAgainController,
        validator: (val) {
          if (val!.isEmpty) {
            return 'The input is empty.';
          } else {
            return null;
          }
        },
        labelText: '비밀번호 재입력',
        hintText: '비밀번호를 재입력해주세요.');
  }

  joinButtonHelper() {
    return ElevatedButton(
      onPressed: () {},
      child: Text('로그인'),
      style: ElevatedButton.styleFrom(
        backgroundColor: PRIMARY_COLOR,
      ),
    );
  }

  welcomeHeaderHelper() {
    return Text(
      'Join us',
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
      '이메일 주소와 비밀번호를 입력해서 Join 해주세요.',
      style: TextStyle(
        fontSize: 15,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
