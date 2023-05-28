import 'package:flutter/material.dart';
import 'package:unuseful/common/const/colors.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Widget? title;

  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final bool? centerTitle;

  final List<Widget>? actions;


  const DefaultLayout({Key? key,
    required this.child,
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar,
    this.floatingActionButton, this.drawer, this.centerTitle, this.actions,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:drawer,
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
        centerTitle: centerTitle??true,
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
