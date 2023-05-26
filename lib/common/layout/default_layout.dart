import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final String? title;

  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? drawer;

  const DefaultLayout({Key? key,
    required this.child,
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar,
    this.floatingActionButton, this.drawer,})
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
        centerTitle: true,
        backgroundColor: Colors.white,
        //앱바가 튀어나오도록 보이게끔
        elevation: 0,
        title: Text(
          title!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colors.black,
      );
    }
  }
}
