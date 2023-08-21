import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/src/specimen/view/specimen_search_screen.dart';

import 'custom_text_form_field.dart';


class CustomReadOnlySearchTextField extends ConsumerStatefulWidget {
  const CustomReadOnlySearchTextField(
      {this.searchType,
      this.hintText,
      required this.push,
      required this.provider,
      Key? key})
      : super(key: key);

  final StateProvider provider;
  final String push;
  final String? hintText;
  final String? searchType;

  @override
  ConsumerState<CustomReadOnlySearchTextField> createState() =>
      _CustomTextFieldForTelephoneState();
}

class _CustomTextFieldForTelephoneState
    extends ConsumerState<CustomReadOnlySearchTextField> {

  final controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final searchValue = ref.watch(widget.provider);


    controller.value = TextEditingValue(text:searchValue);

    return InkWell(
      onTap: () {
        if (widget.push == SpecimenSearchScreen.routeName) {
          context.pushNamed(widget.push,
              queryParameters: {'searchType': widget.searchType});
        } else {
          context.pushNamed(
            widget.push,
          );
        }
      },
      child: IgnorePointer(
        child: CustomTextFormField(

          controller: controller,
          contentPadding: EdgeInsets.fromLTRB(10, 1, 1, 0),
          hintText: widget.hintText ?? '검색어를 입력하세요.',
        ),
      ),
    );
  }
}
