import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/meal/component/meal_page_view.dart';
import 'package:unuseful/src/meal/model/meal_model.dart';
import 'package:unuseful/src/meal/provider/meal_provider.dart';
import 'package:unuseful/src/user/provider/gloabl_variable_provider.dart';
import 'package:unuseful/theme/component/circular_indicator.dart';
import 'package:unuseful/theme/component/photo_view/full_photo.dart';
import 'package:unuseful/theme/component/photo_view/number_indicator.dart';
import 'package:unuseful/theme/component/section_card.dart';
import 'package:unuseful/theme/layout/default_layout.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

class MealScreenMain extends ConsumerStatefulWidget {
  final String hspTpCd;

  const MealScreenMain({required this.hspTpCd, Key? key}) : super(key: key);

  @override
  ConsumerState<MealScreenMain> createState() => _MealScreenMainState();
}

class _MealScreenMainState extends ConsumerState<MealScreenMain> {
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ref.read(mealNotifierProvider.notifier).getMeal();
  }

  @override
  Widget build(BuildContext context) {
    final gloabl = ref.watch(globalVariableStateProvider);
    final state = ref.watch(mealFamilyProvider(widget.hspTpCd));
    final theme = ref.watch(themeServiceProvider);

    // final currentIndex = ref.watch(mealCurrentIndexProvider);
    if (state is ModelBaseLoading) {
      return const CircularIndicator();
    }

    if (state is ModelBaseError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            state.message,
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
              onPressed: () {
                ref.read(mealFamilyProvider(widget.hspTpCd).notifier).getMeal();
              },
              child: Text('다시 시도')),
        ],
      );
    }

    final cp = state as MealModel;

    // ref.read(mealFamilyProvider(widget.hspTpCd).notifier).getMeal();

    return DefaultLayout(
      canRefresh: true,
      onRefreshAndError: ()async{
        ref.read(mealFamilyProvider(widget.hspTpCd).notifier).getMeal();

      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 1),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return SectionCard(
                contentWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cp.data![index].title,
                      style: theme.typo.subtitle1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      height: 30,
                    ),
                    SizedBox(
                        height: 300,
                        child: MealPageView(meal: cp.data![index])),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 20.0,
              );
            },
            itemCount: state.data!.length),
      ),
    );
  }
}
