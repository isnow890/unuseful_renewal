import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/home/component/meal_section.dart';
import 'package:unuseful/src/meal/provider/meal_provider.dart';
import 'package:unuseful/theme/layout/default_layout.dart';

class MealSectionCollection extends ConsumerWidget {
  const MealSectionCollection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state01 = ref.watch(mealFamilyProvider('01'));
    final state02 = ref.watch(mealFamilyProvider('02'));

    return DefaultLayout(
        state: [state01, state02],
        canRefresh: true,
        onRefreshAndError: () async {
          ref.read(mealFamilyProvider('01').notifier).getMeal();
          ref.read(mealFamilyProvider('02').notifier).getMeal();
        },
        child: ListView(
          shrinkWrap: true,
          children: const [
            MealSection(hspTpCd: '01'),
            MealSection(hspTpCd: '02'),
          ],
        ));
  }
}