
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/theme/component/base_dialog.dart';
import 'package:unuseful/theme/component/button/button.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

class LogoutDialog extends ConsumerWidget {
  const LogoutDialog({
    super.key,
    required this.onLogoutPressed,
  });

  final void Function() onLogoutPressed;

  @override
  Widget build(BuildContext context,WidgetRef ref) {


    final theme = ref.watch(themeServiceProvider);

    return BaseDialog(
      title: '로그아웃',
      content: Text(
        '로그아웃 하시겠습니까?',
        style: theme.typo.headline6,
      ),
      actions: [
        /// Delete
        Button(
          text: '확인',
          width: double.infinity,
          color: theme.color.onPrimary,
          backgroundColor: theme.color.primary,
          onPressed: () {
            Navigator.pop(context);
            onLogoutPressed();
          },
        ),
        const SizedBox(height: 12),

        /// Cancel
        Button(
          text: '취소',
          width: double.infinity,
          color: theme.color.text,
          borderColor: theme.color.hint,
          type: ButtonType.outline,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}