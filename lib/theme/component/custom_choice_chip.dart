import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

class CustomChoiceChip extends ConsumerStatefulWidget {
  const CustomChoiceChip({
    required this.selected,
    required this.onSelected,
    required this.label,
    super.key,
  });

  final Widget label;
  final bool selected;

  final void Function(bool selected)? onSelected;

  @override
  ConsumerState<CustomChoiceChip> createState() => _CustomChoiceChipState();
}

class _CustomChoiceChipState extends ConsumerState<CustomChoiceChip> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeServiceProvider);

    return ChoiceChip(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      // pressElevation: 5,
      label: widget.label,
      selected: widget.selected,
      selectedColor: theme.color.tertiary,
      backgroundColor: theme.color.hint,
      onSelected: widget.onSelected,
    );
  }
}
