import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/layout/default_layout.dart';

class TelephoneAdvanceScreen extends ConsumerWidget {
  const TelephoneAdvanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(child: Center(child: Text('advance')),);
  }
}
