import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

class CustomExpansionTile extends ConsumerWidget {
  const CustomExpansionTile({
    required this.children,
    required this.title,
    required this.onExpansionChanged,
    super.key,
  });

  final Widget title;
  final void Function(bool) onExpansionChanged;

  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    return ClipRRect(
        borderRadius: BorderRadius.circular(13.0),
        child: ExpansionTile(
          collapsedIconColor: theme.color.onHintContainer,
          iconColor: theme.color.onHintContainer,
          tilePadding: const EdgeInsets.only(left: 0),
          onExpansionChanged: onExpansionChanged,
          title: title,
          children: <Widget>[
            Column(
              children: [...children],
            )
          ],
        ));
  }
}
