import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/const/colors.dart';

import '../component/main_drawer.dart';
import '../provider/drawer_selector_provider.dart';

class DefaultLayout extends ConsumerWidget {
  final Widget child;
  final Color? backgroundColor;
  final Widget? title;

  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool? centerTitle;
  final bool? isDrawerVisible;
  final List<Widget>? actions;

  const DefaultLayout({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.centerTitle,
    this.actions,
    this.isDrawerVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final select = ref.watch(drawerSelectProvider);

    return Scaffold(
      drawer: isDrawerVisible ?? true
          ? MainDrawer(
              onSelectedTap: (String menu) {
                ref.read(drawerSelectProvider.notifier).update((state) => menu);
                Navigator.of(context).pop();
              },
              selectedMenu: select,
            )
          : null,
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppbar(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar? renderAppbar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        centerTitle: centerTitle ?? true,
        backgroundColor: PRIMARY_COLOR,
        //앱바가 튀어나오도록 보이게끔
        elevation: 0,
        title: title,
        foregroundColor: Colors.black,
        actions: actions,
      );
    }
  }
}
