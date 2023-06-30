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
  final bool? titleVisibility;

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
    this.titleVisibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final select = ref.watch(drawerSelectProvider);
    return SafeArea(
      child: Scaffold(
        drawer: isDrawerVisible ?? true
            ? MainDrawer(
                onSelectedTap: (String menu) {
                  ref.read(drawerSelectProvider.notifier).update((state) => menu);
                  Navigator.of(context).pop();
                },
              )
            : null,
        backgroundColor: backgroundColor ?? Colors.white,
        appBar: _renderAppbar(titleVisibility??true),
        body: child,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,

      ),
    );
  }

  PreferredSize? _renderAppbar(bool titleVisibility ) {
    if (title == null) {
      return null;
    } else {
      return PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(

          centerTitle: centerTitle ?? true,
          backgroundColor: titleVisibility ? Colors.white : Colors.black,
          //앱바가 튀어나오도록 보이게끔
          elevation: 0,
          title: title,
          foregroundColor: Colors.black,
          actions: actions,
        ),
      );
    }
  }
}
