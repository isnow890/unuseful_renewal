import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/user/provider/login_variable_provider.dart';

import '../../user/provider/auth_provider.dart';
import '../component/text_title.dart';
import '../layout/default_layout.dart';

class RootTab extends ConsumerWidget {
  static String get routeName => 'home';

  RootTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginValue = ref.read(loginVariableStateProvider);

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
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 8,
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  //모서리를 둥글게 하기 위해 사용
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 6.0, //그림자 깊이
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('hitSchedule'),
                      Divider(
                        height: 20,
                      ),
                      Text(
                        '📣오늘의 전산정보팀 일정',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Text('(서울)외래진료위원회\n이효정-목동)구두처방 회의'),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '💡 3일간의 당직 일정',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                              '- 2023-06-29(목) 평일\n오후 : 이영균, 야간 : 이종태\n- 2023-06-30(금) 평일\n오후 : 윤배홍, 야간 : 김귀광\n- 2023-07-01(토) 휴일\n오전 : 김진환, 오후 : 홍승민, 야간 : 이종태'),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '👷양찬우님의 당직 일정',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                          '- 2023-06-13(화) 평일 오후\n- 2023-07-22(토) 휴일 오후\n- 2023-07-26(수) 평일 오후\n- 2023-09-11(월) 평일 오후 (예상)\n- 2023-09-17(일) 휴일 오전 (예상)'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
