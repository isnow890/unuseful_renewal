import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/home/model/search_history_main_model.dart';
import 'package:unuseful/src/home/model/search_history_telephone_model.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

class HistoryChip extends ConsumerWidget {
  const HistoryChip({
    required this.onDeleted,
    required this.onTap,
    super.key,
    required this.title,
  });

  final void Function() onTap;
  final void Function() onDeleted;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9.0),
      child: Chip(
          label: GestureDetector(child: Text(title,style: theme.typo.body1), onTap: onTap),
          backgroundColor: theme.color.surface,
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(15),
            side: BorderSide(color: theme.color.onHintContainer),
            
          ),
          deleteIcon: Icon(
            Icons.close,
            color: theme.color.primary,
            size: 15,
            
          ),
          onDeleted: onDeleted),
    );
  }
}

