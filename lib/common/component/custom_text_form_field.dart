import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  final TextEditingController? controller;
  final String? initValue;

  final Icon? prefixIcon;
  final EdgeInsets? contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool? isSuffixDeleteButtonEnabled;

  const CustomTextFormField(
      {Key? key,
      this.hintText,
      this.errorText,
      this.obscureText = false,
      this.autofocus = false,
      required this.onChanged,
      this.initValue,
      this.controller,
      this.contentPadding,
      this.prefixIcon,
      this.inputFormatters,
      this.keyboardType,
      this.isSuffixDeleteButtonEnabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //텍스트 필드 Border를 모든 면에 적용함.
    final baseBorder = OutlineInputBorder(
        borderSide: BorderSide(
      color: INPUT_BORDER_COLOR,
      width: 1.0,
    ));

    return TextFormField(
      keyboardType: keyboardType,

      inputFormatters: inputFormatters,
      controller: controller,
      initialValue: initValue,
      onChanged: onChanged,
      //화면에 들어가자마자 포커스를 자동을 넣어줄지 여부
      autofocus: autofocus,
      //비밀번호 작성시 사용.
      obscureText: obscureText,
      //커서 컬러
      cursorColor: PRIMARY_COLOR,
      //커서 시작 부분 밀기.
      decoration: InputDecoration(
          contentPadding: contentPadding ?? EdgeInsets.all(20),
          prefixIcon: prefixIcon,
          hintText: hintText,
          errorText: errorText,
          //힌트 스타일
          hintStyle: TextStyle(
            color: BODY_TEXT_COLOR,
            fontSize: 14.0,
          ),
          fillColor: INPUT_BG_COLOR,
          //false - 배경색 없음
          //true - 배경색 있음
          filled: true,
          //모든 Input 상태의 기본 스타일 세팅
          border: baseBorder,
          enabledBorder: baseBorder,
          focusedBorder: baseBorder.copyWith(
            borderSide: baseBorder.borderSide.copyWith(color: PRIMARY_COLOR),
          ),
          suffixIcon: isSuffixDeleteButtonEnabled ?? false
              ? IconButton(
                  splashColor: Colors.transparent,
                  icon: Icon(
                    Icons.clear,
                    color: PRIMARY_COLOR,
                  ),
                  onPressed: () {
                    if (controller != null) controller!.clear();
                  },
                )
              : null),
    );
  }
}
