import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/colors.dart';
import 'package:unuseful/src/meal/provider/meal_current_index_provider.dart';

class MealCurrentIndexIndicator extends ConsumerStatefulWidget {
  final int mealSeq;
  final int totalCount;
  final int currentIndex;

  const MealCurrentIndexIndicator(
      {required this.totalCount,
      required this.mealSeq,
      required this.currentIndex,
      Key? key})
      : super(key: key);

  @override
  ConsumerState<MealCurrentIndexIndicator> createState() =>
      _MealCurrentIndexIndicatorState();
}

class _MealCurrentIndexIndicatorState
    extends ConsumerState<MealCurrentIndexIndicator> {
  @override
  Widget build(BuildContext context) {
    ref.watch(mealCurrentIndexAlaramProvider);
    final h = ref.watch(mealCurrentIndexProvider.notifier);
    final index = ref
        .watch(mealCurrentIndexProvider.notifier)
        .getCurrentIndex(widget.mealSeq);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        '${index + 1}/${widget.totalCount}',
        style: (TextStyle(
          fontSize: 12,
          color: BODY_TEXT_COLOR,
          fontWeight: FontWeight.w500,
        )),
      ),
    );
  }
}
