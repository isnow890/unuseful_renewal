import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:unuseful/theme/provider/theme_provider.dart';
import 'package:unuseful/theme/res/layout.dart';

class ConstrainedScreen extends ConsumerWidget {
  const ConstrainedScreen({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Container(
      color: theme.color.surface,
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: Breakpoints.desktop,
        ),
        child: child,
      ),
    );
  }
}
