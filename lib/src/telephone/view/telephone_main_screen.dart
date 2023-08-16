import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/colors.dart';


import '../../common/layout/default_layout.dart';
import '../../common/provider/drawer_selector_provider.dart';
import '../provider/telephone_order_radio_tile_provider.dart';
import '../provider/telephone_search_value_provider.dart';
import 'telephone_advance_screen.dart';
import 'telephone_basic_screen.dart';

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
    final orderRadioTile = ref.watch(telephoneOrderRadioTileProvider);
    final searchValue = ref.watch(telephoneSearchValueProvider);
    return DefaultLayout(
      title: Text('telephone'),
      // TextTitle(title:  'telephone',
      // ),
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
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: <Widget>[
          TelephoneBasicScreen(),
          TelephoneAdvanceScreen(),
        ],
      ),
    );
  }
}
