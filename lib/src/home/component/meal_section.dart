import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/home/component/home_screen_card.dart';
import 'package:unuseful/src/home/provider/home_provider.dart';
import 'package:unuseful/src/home/view/home_screen.dart';
import 'package:unuseful/src/meal/model/meal_model.dart';
import 'package:unuseful/src/meal/provider/meal_provider.dart';
import 'package:unuseful/theme/component/custom_circular_progress_indicator.dart';
import 'package:unuseful/theme/component/custom_error_widget.dart';

class MealSection extends ConsumerStatefulWidget {
  const MealSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MealSectionState();
}

class _MealSectionState extends ConsumerState<MealSection> {
  @override
  Widget build(BuildContext context) {
    final seState = ref.watch(mealFamilyProvider('01'));
    final mdState = ref.watch(mealFamilyProvider('02'));
    var se = MealModel();
    var md = MealModel();

    if (seState is ModelBaseError || mdState is ModelBaseError) {
      return HomeScreenCard(
          contentWidget: CustomErrorWidget(
              message: '에러가 발생하였습니다',
              onPressed: () async => ref
                  .read(homeNotifierProvider.notifier)
                  .getHitScheduleAtHome()));
    }

    if (seState is MealModel && mdState is MealModel) {
      se = seState;
      md = mdState;
    }

    return HomeScreenCard(
      contentWidget:
          (seState is ModelBaseLoading || mdState is ModelBaseLoading)
              ? const Center(child: CustomCircularProgressIndicator())
              : Column(
                  children: [
                    renderCardInside('01', se),
                    renderCardInside('02', md),
                  ],
                ),
    );
  }

  renderCardInside(String hspTpCd, MealModel mealModel) {
    if (mealModel.data!.isEmpty) {
      return Text('No data found ${hspTpCd}');
    }

    return Column(
      children: [
        Text(mealModel.data![0].title),
        Row(
          children: mealModel.data![0].imgUrls
              .map(
                (e) => Container(
                  width: 100,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(e!, fit: BoxFit.fill),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
