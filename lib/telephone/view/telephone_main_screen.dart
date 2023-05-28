import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/component/text_title.dart';
import 'package:unuseful/common/const/colors.dart';
import 'package:unuseful/telephone/view/telephone_advance_screen.dart';
import 'package:unuseful/telephone/view/telephone_basic_screen.dart';

import '../../common/component/custom_radio_tile.dart';
import '../../common/component/custom_text_form_field.dart';
import '../../common/component/main_drawer.dart';
import '../../common/layout/default_layout.dart';
import '../../common/provider/drawer_selector_provider.dart';
import '../provider/telephone_order_radio_tile_provider.dart';
import '../provider/telephone_search_value_provider.dart';

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

  late final String searchText;

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
    final orderRadioTile = ref.watch(telephoneOrderRadioTileProvider);


    return DefaultLayout(
      centerTitle: false,
      actions: [
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Data Order'),
                    content: Container(
                      width: 300,
                      height: 100,
                      child: Column(
                        children: [
                          Expanded(
                            child: CustomRadioTile(
                              groupValue: orderRadioTile,
                              activeColor: PRIMARY_COLOR,
                              onChanged: () {
                                ref
                                    .read(telephoneOrderRadioTileProvider
                                    .notifier)
                                    .update((state) => 'asc');
                              },
                              value: 'asc',
                              title: 'Ascending',
                            ),

                          ),
                          Expanded(
                            child: CustomRadioTile(
                              groupValue: orderRadioTile,
                              activeColor: PRIMARY_COLOR,
                              onChanged: () {
                                ref
                                    .read(telephoneOrderRadioTileProvider
                                        .notifier)
                                    .update((state) => 'desc');
                              },
                              value: 'desc',
                              title: 'Descending',
                            ),

                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.more_vert)),
      ],
      drawer: MainDrawer(
        onSelectedTap: (String menu) {
          ref.read(drawerSelectProvider.notifier).update((state) => menu);
          Navigator.of(context).pop();
        },
        selectedMenu: select,
      ),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 40,
          child: CustomTextFormField(
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.fromLTRB(10, 1, 1, 0),
            hintText: 'Enter some text to search.',
            onChanged: (value) {
              ref
                  .read(telephoneSearchValueProvider
                  .notifier)
                  .update((state) => value);

              print('value 업데이트 함');

            },
          ),
        ),
      ),
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
