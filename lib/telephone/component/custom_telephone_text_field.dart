import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/telephone/component/telephone_search_screen.dart';

import '../../common/component/custom_text_form_field.dart';
import '../../common/const/colors.dart';
import '../provider/telephone_search_value_provider.dart';

class CustomTelephoneTextField extends ConsumerStatefulWidget {
  const CustomTelephoneTextField({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomTelephoneTextField> createState() =>
      _CustomTextFieldForTelephoneState();
}

class _CustomTextFieldForTelephoneState
    extends ConsumerState<CustomTelephoneTextField> {
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    final searchValue = ref.watch(telephoneSearchValueProvider);


    return InkWell(
      onTap: () {
        context.pushNamed(TelephoneSearchScreen.routeName);
      },
      child: IgnorePointer(
        child: CustomTextFormField(
          initValue: searchValue,
          prefixIcon: Icon(
            Icons.search,
            color: PRIMARY_COLOR,
          ),
          contentPadding: EdgeInsets.fromLTRB(10, 1, 1, 0),
          hintText: 'Enter some text to search.',
          onChanged: debounceTextField,
        ),
      ),
    );

    ;
  }

  debounceTextField(value) {
    if (_timer?.isActive ?? false) _timer!.cancel();
    _timer = Timer(
      const Duration(milliseconds: 500),
      () {
        ref
            .read(telephoneSearchValueProvider.notifier)
            .update((state) => value);
      },
    );
  }
}
