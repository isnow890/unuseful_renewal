import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

class BaseBottomSheet extends ConsumerWidget {
  const BaseBottomSheet({
    super.key,
    required this.child,
    this.padding,
    this.isRoundAll,
  });

  final Widget child;
  final EdgeInsets? padding;
  final bool? isRoundAll;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    return Container(
      decoration: BoxDecoration(
        color: theme.color.surface,
        borderRadius: isRoundAll ?? false
            ? BorderRadius.circular(24)
            : const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
        boxShadow: theme.deco.shadow,
      ),
      padding: padding ??
          const EdgeInsets.only(
            top: 32,
            bottom: 16,
          ),
      child: SafeArea(
        child: child,
      ),
    );
  }
}
