import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/home/component/logout_dialog.dart';
import 'package:unuseful/src/home/component/section_title.dart';
import 'package:unuseful/src/home/provider/specimen_history_provider.dart';
import 'package:unuseful/src/home/component/hit_schedule_section.dart';
import 'package:unuseful/src/home/component/meal_section.dart';
import 'package:unuseful/src/meal/provider/meal_provider.dart';
import 'package:unuseful/theme/component/bottom_sheet/setting_bottom_sheet.dart';
import 'package:unuseful/theme/component/button/button.dart';
import 'package:unuseful/theme/component/text_title.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';
import '../../../theme/layout/default_layout.dart';
import '../../../theme/model/menu_model.dart';
import '../../../router/provider/auth_provider.dart';
import '../component/meal_section_collection.dart';
import '../component/specimen_section.dart';
import '../component/telephone_section.dart';
import '../provider/home_provider.dart';
import '../provider/telehphone_history_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static String get routeName => 'home';

  HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<String> tabBarList = ['일정', '식단', '전화번호', '진검검사'];

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeServiceProvider);
    final home = ref.watch(homeNotifierProvider);
    return DefaultTabController(
      initialIndex: 0,
      length: tabBarList.length,
      child: DefaultLayout(
          appBarBottomList: tabBarList,
          actions: [
            Button(
              icon: 'option',
              type: ButtonType.flat,
              color: theme.color.onPrimary,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const SettingBottomSheet();
                  },
                );
              },
            ),
          ],
          title: menus[0].menuName,
          child: const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 8,
            ),
            child: TabBarView(
              children: [
                HitScheduleSection(),
                MealSectionCollection(),
                TelephoneSection(),
                SpecimenSection(),
              ],
            ),
          )),
    );
  }
}
