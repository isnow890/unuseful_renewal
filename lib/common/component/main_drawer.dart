import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/common/const/colors.dart';
import 'package:unuseful/hit_schedule/provider/hit_schedule_selected_day_provider.dart';
import 'package:unuseful/user/model/user_model.dart';
import 'package:unuseful/user/provider/login_variable_provider.dart';

import '../../telephone/provider/telephone_search_value_provider.dart';
import '../../user/provider/user_me_provider.dart';

typedef OnSelectedTap = void Function(String menu);

class MainDrawer extends ConsumerWidget {
  MainDrawer(
      {Key? key, required this.onSelectedTap, required this.selectedMenu})
      : super(key: key);
  final OnSelectedTap onSelectedTap;
  final String selectedMenu;

  final ts = TextStyle(
    color: Colors.white,
    fontSize: 15.0,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userMeProvider.notifier).state;
     final hspTpCd = ref.watch(loginVariableStateProvider).hspTpCd;


    final convertedUser = user as UserModel;

    List<String> tmpList = [
      'home',
      'telephone',
      'speciemen',
      'meal',
      'patient',
      'hitSchedule'
    ];

    return Container(
      width: 150,
      child: Drawer(
        backgroundColor: PRIMARY_COLOR,
        child: ListView(
          children: [
            SizedBox(
              height: 120,
              child: DrawerHeader(
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          hspTpCd == "01"? 'se':'md',
                          style: ts,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          convertedUser.stfNm!,
                          style: ts,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          convertedUser.deptNm!,
                          style: ts,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ...tmpList.map((e) => renderListTile(e, context,ref)).toList(),

    ],
        ),
      ),
    );
  }

  Widget renderListTile(String value, BuildContext context, WidgetRef ref) {
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
        ref.refresh(hitScheduleSelectedDayProvider);
        onSelectedTap(value);
        // context.goNamed(value);

        if(value =='home')
          context.goNamed(value);
        else
          context.pushNamed(value);
        print(value);
      },
      title: Text(value),
    );
  }
}
