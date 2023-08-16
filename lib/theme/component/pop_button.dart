import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/theme/component/button/button.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

class PopButton extends ConsumerWidget {
  const PopButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Button(
      icon: 'arrow-left',
      color: theme.color.text,
      type: ButtonType.flat,
      onPressed: () => Navigator.pop(context),
    );
  }
}
