import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/theme/component/asset_icon.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

class Tile extends ConsumerWidget {
  const Tile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  final String icon;
  final String title;
  final String subtitle;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            /// Start Icon
            AssetIcon(icon),
            const SizedBox(width: 8),

            /// Title
            Expanded(
              child: Text(
                title,
                style: theme.typo.headline5,
              ),
            ),
            const SizedBox(width: 8),

            /// Subtitle
            Text(
              subtitle,
              style: theme.typo.subtitle1.copyWith(
                color: theme.color.primary,
              ),
            ),
            const SizedBox(width: 8),

            /// End Icon
            const AssetIcon('chevron-right'),
          ],
        ),
      ),
    );
  }
}