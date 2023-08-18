import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/meal/view/meal_main_screen.dart';
import 'package:unuseful/src/user/provider/gloabl_variable_provider.dart';
import 'package:unuseful/theme/model/menu_model.dart';

import '../../../theme/layout/default_layout.dart';

class MealScreen extends ConsumerStatefulWidget {
  const MealScreen({Key? key}) : super(key: key);

  static String get routeName => 'meal';

  @override
  ConsumerState<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends ConsumerState<MealScreen> {
  List<String> tabBarList = ['서울병원', '목동병원'];

  @override
  Widget build(BuildContext context) {
    final global = ref.watch(globalVariableStateProvider);

    return DefaultTabController(
      length: tabBarList.length,
      initialIndex: 0,
      child: DefaultLayout(
        title: MenuModel.getMenuInfo(MealScreen.routeName).menuName,
        appBarBottomList: tabBarList,
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 8,
          ),
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              MealScreenMain(
                hspTpCd: '01',
              ),
              MealScreenMain(
                hspTpCd: '02',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// final state = ref.watch(mealFamilyProvider(hspTpCd));
