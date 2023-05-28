import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/common/component/main_drawer.dart';

import '../component/text_title.dart';
import '../layout/default_layout.dart';
import '../provider/drawer_selector_provider.dart';

class RootTab extends ConsumerWidget {
  static String get routeName => 'home';

  RootTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final select = ref.watch(drawerSelectProvider);
    return DefaultLayout(
        drawer: MainDrawer(
          onSelectedTap: (String menu) {
            ref.read(drawerSelectProvider.notifier).update((state) => menu);
            Navigator.of(context).pop();
            // print('selected menu is ');
            // print(select);
          },
          selectedMenu: select,
        ),
        title: TextTitle(title: 'home'),
        child: Center(
          child: Text('루트탭입니다.'),
        ));
  }
}
