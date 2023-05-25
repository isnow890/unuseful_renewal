import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../layout/default_layout.dart';

class RootTab extends ConsumerWidget {
  static String get routeName => 'home';


  const RootTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return DefaultLayout(child: Center(child: Text('루트탭입니다.')));
  }
}
