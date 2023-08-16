import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/home/model/search_history_specimen_model.dart';
import 'package:unuseful/src/home/model/search_history_telephone_model.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9.0),
      child: Chip(
          label:
              GestureDetector(child: Text(title), onTap: onTap),
          deleteIcon: Icon(
            Icons.close,
          ),
          onDeleted: onDeleted),
    );
  }
}
