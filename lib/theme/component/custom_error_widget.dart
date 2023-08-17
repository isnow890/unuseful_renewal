import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/theme/component/button/button.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

class CustomErrorWidget extends ConsumerWidget {
  final String? message;
  final Future<void>? Function() onPressed;

  const CustomErrorWidget({Key? key, this.message, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          message ?? '에러가 발생하였습니다.',
          textAlign: TextAlign.center,
        ),
        onPressed == null
            ? const SizedBox()
            : Button(
                width: double.infinity,
                size: ButtonSize.large,
                text: '다시 시도',
                onPressed: onPressed,
              ),
      ],
    );
  }
}
