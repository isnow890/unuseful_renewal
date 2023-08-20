import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/theme/component/base_dialog.dart';
import 'package:unuseful/theme/component/button/button.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

class UpdateScheduleDialog extends ConsumerWidget {
  const UpdateScheduleDialog(
      {required this.content,
      required this.onUpdateSchedulePressed,
      super.key});

  final String content;

  final void Function() onUpdateSchedulePressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    return BaseDialog(
      title: '스케줄 변경',
      content: Text(
        content,
        style: theme.typo.headline6,
      ),

      actions: [
        /// Delete
        Button(
          text: '변경',
          width: double.infinity,
          color: theme.color.onPrimary,
          backgroundColor: theme.color.primary,
          onPressed: () {
            Navigator.pop(context);
            onUpdateSchedulePressed();
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
