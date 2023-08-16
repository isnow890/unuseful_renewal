import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

typedef Validation = String? Function(String?)?;

class CustomTextFormField extends ConsumerStatefulWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;

  final void Function(String text)? onChanged;
  final void Function(String text)? onFieldSubmitted;

  final bool? readOnly;

  final TextEditingController? controller;
  final String? initValue;

  final Icon? prefixIcon;
  final EdgeInsets? contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool? isSuffixDeleteButtonEnabled;
  final Validation? validator;
  final String? labelText;

  const CustomTextFormField({
    Key? key,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autofocus = false,
    this.onChanged,
    this.initValue,
    this.controller,
    this.contentPadding,
    this.prefixIcon,
    this.inputFormatters,
    this.keyboardType,
    this.isSuffixDeleteButtonEnabled,
    this.readOnly,
    this.onFieldSubmitted,
    this.validator,
    this.labelText,
  }) : super(key: key);

  @override
  ConsumerState<CustomTextFormField> createState() =>
      _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends ConsumerState<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeServiceProvider);

    //텍스트 필드 Border를 모든 면에 적용함.

    return TextFormField(
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      readOnly: widget.readOnly ?? false,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      initialValue: widget.initValue,
      onChanged: widget.onChanged,
      //화면에 들어가자마자 포커스를 자동을 넣어줄지 여부
      autofocus: widget.autofocus,
      //비밀번호 작성시 사용.
      obscureText: widget.obscureText,
      //커서 컬러
      // cursorColor: PRIMARY_COLOR,
      //커서 시작 부분 밀기.
      decoration: InputDecoration(
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(
                vertical: 11.5,
                horizontal: 16,
              ),
          prefixIcon: widget.prefixIcon,
          hintText: widget.hintText,
          errorText: widget.errorText,
          labelText: widget.labelText,
          labelStyle: theme.typo.headline5,
          //힌트 스타일
          hintStyle: theme.typo.headline5.copyWith(
            fontWeight: theme.typo.light,
            color: theme.color.onHintContainer,
          ),
          fillColor: theme.color.hintContainer,
          //false - 배경색 없음
          //true - 배경색 있음
          filled: true,
          //모든 Input 상태의 기본 스타일 세팅



          border: OutlineInputBorder(
            /// 테두리 삭제
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),

            /// 테두리 둥글게
            borderRadius: BorderRadius.circular(12),
          ),

          suffixIcon: widget.isSuffixDeleteButtonEnabled ?? false
              ? IconButton(
                  splashColor: Colors.transparent,
                  icon: Icon(
                    Icons.refresh,
                  ),
                  onPressed: () {
                    if (widget.controller != null) widget.controller!.clear();
                  },
                )
              : null),
    );
  }
}
