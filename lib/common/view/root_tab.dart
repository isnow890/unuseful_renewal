import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/common/component/main_drawer.dart';

import '../../user/provider/auth_provider.dart';
import '../component/text_title.dart';
import '../layout/default_layout.dart';
import '../provider/drawer_selector_provider.dart';

class RootTab extends ConsumerWidget {
  static String get routeName => 'home';

  RootTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                        child: AlertDialog(
                          // title: new Text(title),
                          content: new Text('are you sure to logout?'),
                          actions: <Widget>[
                            TextButton(
                              child: new Text("Continue"),
                              onPressed: () {
                                ref.read(authProvider.notifier).logout();
                              },
                            ),
                            TextButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
                  },
                );
              },
              icon: Icon(Icons.logout)),
        ],
        title: TextTitle(title: 'home'),
        child: Center(
          child: Text('루트탭입니다.'),
        ));
  }
}
