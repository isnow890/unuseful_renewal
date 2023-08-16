import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'auth_provider.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

final goRouterProvider = Provider<GoRouter>((ref) {
  //watch - 값이 변경될때마다 다시 빌드
  //read - 한번만 읽고 값이 변경돼도 다시 빌드하지 않음
  final provider = ref.read(authProvider);

  return GoRouter(
    routes: provider.routes,
    initialLocation: '/splash',
    refreshListenable: provider,
    navigatorKey: navigatorKey,
    redirect: provider.redirectLogic,
  );
});
