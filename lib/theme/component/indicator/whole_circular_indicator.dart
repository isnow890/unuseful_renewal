import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

class WholeCircularIndicator extends ConsumerWidget {
  const WholeCircularIndicator({
    super.key,
    required this.child,
    required this.isBusy,
  });

  final Widget child;
  final bool isBusy;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Stack(
      children: [
        child,

        /// CircularIndicator
        IgnorePointer(
          ignoring: !isBusy,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 222),
            opacity: isBusy ? 1 : 0,
            child: Container(
              color: theme.color.background,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: theme.color.primary,
                value: isBusy ? null : 0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}