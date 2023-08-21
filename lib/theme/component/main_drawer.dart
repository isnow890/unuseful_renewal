import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/colors.dart';
import 'package:unuseful/data.dart';
import 'package:unuseful/router/provider/auth_provider.dart';
import 'package:unuseful/src/hit_schedule/provider/hit_schedule_selected_day_provider.dart';
import 'package:unuseful/src/hit_schedule/view/hit_schedule_main_screen.dart';
import 'package:unuseful/src/home/component/logout_dialog.dart';
import 'package:unuseful/src/home/view/home_screen.dart';

import 'package:unuseful/src/meal/view/meal_screen.dart';
import 'package:unuseful/src/patient/view/patient_screen.dart';
import 'package:unuseful/src/specimen/view/specimen_main_screen.dart';
import 'package:unuseful/src/telephone/provider/telephone_search_value_provider.dart';
import 'package:unuseful/src/telephone/view/telephone_main_screen.dart';

import 'package:unuseful/src/user/provider/gloabl_variable_provider.dart';
import 'package:unuseful/theme/component/button/button.dart';
import 'package:unuseful/theme/model/menu_model.dart';

import 'package:unuseful/theme/provider/theme_provider.dart';

typedef OnSelectedTap = void Function(String menu);

class MainDrawer extends ConsumerWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final global = ref.watch(globalVariableStateProvider);

    final theme = ref.watch(themeServiceProvider);

    _renderMenuHeader() {
      return Container(
        height: 130,
        color: theme.color.primary,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${global.stfNm}',
                          style: theme.typo.headline2
                              .copyWith(color: theme.color.onPrimary),
                        ),
                        TextSpan(
                          text: '  (${global.stfNo})',
                          style: theme.typo.subtitle2
                              .copyWith(color: theme.color.onPrimary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    (global.hspTpCd == '01' ? '서울' : '목동') + ' 병원',
                    style: theme.typo.subtitle2
                        .copyWith(color: theme.color.onPrimary),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    global.deptNm!,
                    style: theme.typo.subtitle2
                        .copyWith(color: theme.color.onPrimary),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            Positioned(
                top: 10,
                right: 20,
                child: Button(
                    iconData: Icons.logout,
                    type: ButtonType.flat,
                    color: theme.color.onPrimary,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => LogoutDialog(
                          onLogoutPressed:
                              ref.read(authProvider.notifier).logout,
                        ),
                      );
                    }))
          ],
        ),
      );
    }

    _renderMenuItem({required String routeName}) {
      final selectedMenu =
          menus.firstWhere((element) => element.routeName == routeName);

      return ListTile(
          leading: Icon(selectedMenu.icon, color: theme.color.primary),
          title: Text(
            selectedMenu.menuName,
            style: theme.typo.body1,
          ),
          onTap: () {
            ref.refresh(telephoneSearchValueProvider);
            // ref.refresh(hitScheduleSelectedDayProvider);
            // context.goNamed(value);

            while (context.canPop()) {
              context.pop();
            }
            context.pushReplacementNamed(selectedMenu.routeName);

            // context.pushNamed(menuMap.values.toList()[index]);

            // if (menuMap.values.toList()[index] == 'home')
            //   context.goNamed(menuMap.values.toList()[index]);
            // else
            //   context.pushNamed(menuMap.values.toList()[index]);
          });
    }

    return Drawer(
      width: 250,
      backgroundColor: theme.color.surface,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _renderMenuHeader(),
          SizedBox(
            height: 10,
          ),
          _renderMenuItem(routeName: HomeScreen.routeName),
          _renderMenuItem(routeName: TelePhoneMainScreen.routeName),
          _renderMenuItem(routeName: MealScreen.routeName),
          _renderMenuItem(routeName: SpecimenMainScreen.routeName),
          _renderMenuItem(routeName: PatientScreen.routeName),
          _renderMenuItem(routeName: HitScheduleMainScreen.routeName),
        ],
      ),
    );
  }

  Widget renderListTile(
      String selectedMenu, String value, BuildContext context, WidgetRef ref) {
    return ListTile(
      //누르는 공간 전체
      tileColor: Colors.transparent,
      //선택이 된 상태에서 배경색
      selectedTileColor: lightColor,
      //선택이 된 상태에서 글자색
      selectedColor: Colors.black,
      //selected로 선택된 상태를 조절할 수 있음
      selected: value == selectedMenu,
      onTap: () {
        ref.refresh(telephoneSearchValueProvider);
        // ref.refresh(hitScheduleSelectedDayProvider);
        // context.goNamed(value);
        context.goNamed(value);

        // if (value == 'home')
        //   context.goNamed(value);
        // else
        //   context.pushNamed(value);
      },
      title: Text(value),
    );
  }
}
