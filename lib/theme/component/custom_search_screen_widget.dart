import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/colors.dart';
import 'package:unuseful/src/common/layout/default_layout.dart';

import 'custom_text_form_field.dart';

class CustomSearchScreenWidget extends ConsumerWidget {
  const CustomSearchScreenWidget({
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    required this.title,
    required this.onFieldSubmitted,
    required this.searchValueController,
    required this.onPressed,
    required this.body,
    Key? key,
  }) : super(key: key);
  final String title;
  final ValueChanged<String>? onFieldSubmitted;
  final TextEditingController searchValueController;
  final VoidCallback? onPressed;
  final Widget body;
  final String? hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      isDrawerVisible: false,
      title: Text(title),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextFormField(
                    inputFormatters: inputFormatters,
                    keyboardType: keyboardType,
                    isSuffixDeleteButtonEnabled: true,
                    onFieldSubmitted: onFieldSubmitted,
                    autofocus: true,
                    controller: searchValueController,
                    contentPadding: EdgeInsets.fromLTRB(10, 1, 1, 0),
                    hintText: hintText ?? '검색어를 입력하세요.',
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: onPressed,
                    icon: const Icon(
                      Icons.search,
                      size: 35,
                      color: PRIMARY_COLOR,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints()),
              ],
            ),
            Expanded(
              child: SizedBox(height: 100, child: body),
            )
          ],
        ),
      ),
    );
  }
}
