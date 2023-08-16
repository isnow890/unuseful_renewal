import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/theme/component/main_drawer.dart';

import '../provider/drawer_selector_provider.dart';

class DefaultLayout extends ConsumerWidget {
  final Widget child;

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
        drawer: isDrawerVisible ?? true ? const MainDrawer() : null,
        appBar: _renderAppbar(titleVisibility ?? true),
        body: child,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
      ),
    );
  }

  _renderAppbar(bool titleVisibility) {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        centerTitle: centerTitle ?? true,
        //앱바가 튀어나오도록 보이게끔
        elevation: 0,
        title: title,
        actions: actions,
        titleSpacing: 0,
      );
    }
  }
}
