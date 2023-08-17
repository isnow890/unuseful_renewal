import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/colors.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

class CustomCircularProgressIndicator extends ConsumerWidget {
  const CustomCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final theme = ref.watch(themeServiceProvider);

    return CircularProgressIndicator(
      color: theme.color.primary,
    );
  }
}
