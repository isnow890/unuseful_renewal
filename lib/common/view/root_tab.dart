import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/common/component/main_drawer.dart';
import 'package:unuseful/meal/provider/hsp_tp_cd_provider.dart';
import 'package:unuseful/user/provider/login_variable_provider.dart';

import '../../user/provider/auth_provider.dart';
import '../../user/provider/user_me_provider.dart';
import '../component/text_title.dart';
import '../layout/default_layout.dart';
import '../model/fcm_registration_params.dart';
import '../provider/drawer_selector_provider.dart';
import '../utils/firebase_module.dart';

class RootTab extends ConsumerWidget {
  static String get routeName => 'home';

  RootTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final loginValue = ref.read(loginVariableStateProvider);



    firebaseMessagingGetMyDeviceTokenAndSave(ref: ref);


    // final login = ref.watch(loginVariableStateProvider);
    //
    // ref.watch(hspTpCdProvider.notifier).update((state) => login.hspTpCd!);

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
                      ),
                    );
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
