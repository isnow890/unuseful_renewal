import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

class SegmentButton extends ConsumerWidget {
  const SegmentButton({Key? key,
    required this.selectionIndex,
    required this.onSegmentTapped,
    required this.children})
      : super(key: key);

  final int selectionIndex;
  final Map<int, Widget> children;

  final void Function(int) onSegmentTapped;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Row(
      children: [
        Expanded(
          child: MaterialSegmentedControl(
              children: children,
              selectedColor: theme.color.primary,
              horizontalPadding: const EdgeInsets.all(0),
              selectionIndex: selectionIndex,
              // borderColor: Colors.grey,
              unselectedColor: theme.color.onPrimary,
              selectedTextStyle:
              theme.typo.subtitle1.copyWith(color: Colors.white),
              // unselectedTextStyle: theme.typo.subtitle1.copyWith(color: ),
              // unselectedTextStyle: TextStyle(color: PRIMARY_COLOR),
              borderWidth: 0.0,
              borderRadius: 6.0,
              borderColor: Colors.transparent,
              verticalOffset: 12.0,
              onSegmentTapped: onSegmentTapped),
        ),
      ],
    );
  }
}