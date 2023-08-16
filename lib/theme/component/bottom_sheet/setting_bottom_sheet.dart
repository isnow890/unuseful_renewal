import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/theme/component/bottom_sheet/base_bottom_sheet.dart';
import 'package:unuseful/theme/component/tile.dart';

import 'package:unuseful/theme/provider/theme_provider.dart';

class SettingBottomSheet extends ConsumerWidget {
  const SettingBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    final isLightTheme = theme.brightness == Brightness.light;
    return BaseBottomSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Theme Tile
          Tile(
            icon: isLightTheme ? 'sunny' : 'moon',
            title: "설정",
            subtitle: isLightTheme ? '라이트':'다크',
            onPressed: ref.read(themeServiceProvider.notifier).toggleTheme,
          ),
        ],
      ),
    );
  }
}
