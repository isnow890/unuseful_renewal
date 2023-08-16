import 'package:flutter/material.dart';
import 'package:unuseful/colors.dart';

typedef OnChanged = void Function();

class CustomRadioTile extends StatelessWidget {
  final String groupValue;
  final Color activeColor;
  final OnChanged onChanged;
  final String value;
  final String title;

  const CustomRadioTile(
      {Key? key,
      required this.groupValue,
      required this.activeColor,
      required this.onChanged,
      required this.value, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text(title),
      value: value,
      groupValue: groupValue,
      activeColor: PRIMARY_COLOR,
      onChanged: (value) {
        FocusManager.instance.primaryFocus?.unfocus();
        onChanged;

        Navigator.of(context).pop();
      },
    );
  }
}
