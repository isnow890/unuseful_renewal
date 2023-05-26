import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/layout/default_layout.dart';

class TelephoneBasicScreen extends ConsumerWidget {
  const TelephoneBasicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(child: Text('basic'),);
  }
}
