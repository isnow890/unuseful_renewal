import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/const/colors.dart';
import 'package:unuseful/telephone/view/telephone_advance_screen.dart';
import 'package:unuseful/telephone/view/telephone_basic_screen.dart';

import '../../common/component/main_drawer.dart';
import '../../common/layout/default_layout.dart';
import '../../common/provider/drawer_selector_provider.dart';

class TelePhoneMainScreen extends ConsumerStatefulWidget {
  const TelePhoneMainScreen({Key? key}) : super(key: key);

  static String get routeName => 'telephone';

  @override
  ConsumerState<TelePhoneMainScreen> createState() => _TelePhoneScreenState();
}

class _TelePhoneScreenState extends ConsumerState<TelePhoneMainScreen>
    with SingleTickerProviderStateMixin {
  //나중에 입력이 됨. 그러므로 late 사용
  late TabController controller;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 2, vsync: this);
    controller.addListener(tabListener);
  }

  void tabListener() {
    print('동작');
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
    final select = ref.watch(drawerSelectProvider);
    return DefaultLayout(
      drawer: MainDrawer(
        onSelectedTap: (String menu) {
          ref.read(drawerSelectProvider.notifier).update((state) => menu);
          Navigator.of(context).pop();
        },
        selectedMenu: select,
      ),
      title: 'telephone',
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
              icon: Icon(Icons.contact_phone), label: 'basic'),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_phone_outlined), label: 'advance'),
        ],

      ),
      child:TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children:<Widget> [
          TelephoneBasicScreen(),
          TelephoneAdvanceScreen(),
        ],
      ),);
  }
}
