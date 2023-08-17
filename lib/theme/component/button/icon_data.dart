import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

class IconDataGet extends ConsumerWidget {
  const IconDataGet(
    this.iconData, {
    super.key,
    this.color,
    this.size,
  });

  final IconData iconData;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Icon(
      iconData,
      size: size,
      color: color ?? ref.watch(themeServiceProvider).color.text,
    );
  }
}
