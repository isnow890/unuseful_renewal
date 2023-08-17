import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/colors.dart';
import 'package:unuseful/src/meal/model/meal_model.dart';
import 'package:unuseful/src/meal/provider/meal_current_index_provider.dart';
import 'package:unuseful/src/meal/provider/meal_provider.dart';
import 'package:unuseful/src/meal/view/meal_main_screen.dart';
import 'package:unuseful/src/user/provider/gloabl_variable_provider.dart';
import 'package:unuseful/theme/component/custom_circular_progress_indicator.dart';
import 'package:unuseful/theme/component/photo_view/full_photo.dart';

import '../../../theme/layout/default_layout.dart';

class MealScreen extends ConsumerStatefulWidget {
  const MealScreen({Key? key}) : super(key: key);

  static String get routeName => 'meal';

  @override
  ConsumerState<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends ConsumerState<MealScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    controller = TabController(length: 2, vsync: this);
    controller.addListener(tabListener);
    ref.read(mealCurrentIndexProvider.notifier).initializeIndex();
  }

  void init() async {
    var global = ref.read(globalVariableStateProvider);
    index = global.hspTpCd == '01' ? 0 : 1;
  }

  void tabListener() {
    setState(() => index = controller.index);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final global = ref.watch(globalVariableStateProvider);

    return DefaultLayout(
      title: 'meal',
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (int value) {
          index = value;
          controller.animateTo(value);
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal_outlined), label: 'se'),
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'md'),
        ],
      ),
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: <Widget>[
          MealScreenMain(hspTpCd: '01',),
          MealScreenMain(hspTpCd: '02',),
        ],
      ),
    );
  }
}


// final state = ref.watch(mealFamilyProvider(hspTpCd));
