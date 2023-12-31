import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/theme/component/indicator/circular_indicator.dart';
import 'package:unuseful/theme/layout/default_layout.dart';

import '../../colors.dart';

class SplashScreen extends ConsumerWidget {
  static String get routeName => 'splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      child: SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image.asset(
            'asset/img/logo/logo.png',
            width: MediaQuery
                .of(context)
                .size
                .width / 2,
          ),
          SizedBox(
            height: 16,
          ),
          const CircularIndicator(),
      ],
    ),)
    ,
    );
  }
}
