

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);


  static String get routeName=>'login';


  @override
  ConsumerState<LoginScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
