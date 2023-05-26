import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/common/const/colors.dart';

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

  final iconSize = 15.0;
  final iconColor = Colors.white;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> tmpList = ['home','telephone', 'speicemen', 'meal', 'patient'];

    return Container(
      width: 150,
      child: Drawer(
        backgroundColor: PRIMARY_COLOR,
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: iconSize,
                    color: iconColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'telephone',
                    style: ts,
                  ),
                ],
              ),
            ),
            ...tmpList.map((e) => renderListTile(e,context)).toList(),
          ],
        ),
      ),
    );
  }

  Widget renderListTile(String value,BuildContext context) {
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
        onSelectedTap(value);
        context.goNamed(value);
        print(value);
      },
      title: Text(value),
    );
  }
}
