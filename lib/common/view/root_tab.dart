import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/user/provider/login_variable_provider.dart';

import '../../user/provider/auth_provider.dart';
import '../component/text_title.dart';
import '../layout/default_layout.dart';




class RootTab extends ConsumerStatefulWidget {
  static String get routeName => 'home';

  RootTab({Key? key}) : super(key: key);


  @override
  ConsumerState<RootTab> createState() => _RootTabState();

}
class _RootTabState extends ConsumerState<RootTab>{
  


  @override
  Widget build(BuildContext context) {
    // final loginValue = ref.read(loginVariableStateProvider);
  
  int _current = 0;

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
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _renderSection(section: '일정'),
                CarouselSlider(
                  items: [
                    _renderCard(
                      context: context,
                      contentWidget: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '오늘의 전산정보팀 일정',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Divider(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text('(서울)외래진료위원회\n이효정-목동)구두처방 회의'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _renderCard(
                      context: context,
                      contentWidget: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '양찬우님의 당직 일정',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Divider(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                  '- 2023-06-13(화) 평일 오후\n- 2023-07-22(토) 휴일 오후\n- 2023-07-26(수) 평일 오후\n- 2023-09-11(월) 평일 오후 (예상)\n- 2023-09-17(일) 휴일 오전 (예상)'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _renderCard(
                      context: context,
                      contentWidget: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '3일간의 당직 일정',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Divider(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                  '- 2023-06-29(목) 평일\n오후 : 이영균, 야간 : 이종태\n- 2023-06-30(금) 평일\n오후 : 윤배홍, 야간 : 김귀광\n- 2023-07-01(토) 휴일\n오전 : 김진환, 오후 : 홍승민, 야간 : 이종태\n- 2023-06-29(목) 평일\n오후 : 이영균, 야간 : 이종태\n- 2023-06-30(금) 평일\n오후 : 윤배홍, 야간 : 김귀광\n- 2023-07-01(토) 휴일\n오전 : 김진환, 오후 : 홍승민, 야간 : 이종태'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    onPageChanged: (index2, reason) {},
                    // aspectRatio: 3.0,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    height: 180,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                _renderSection(section: '식단'),
                _renderCard(
                  context: context,
                  contentWidget: const Column(
                    children: [
                      Row(
                        children: [
                          Text('새로운 식단이 등록되었습니다'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _renderSection(section: 'telephone'),
                _renderCard(
                  context: context,
                  contentWidget: const Column(
                    children: [
                      Row(
                        children: [
                          Text('새로운 식단이 등록되었습니다'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _renderSection(section: 'specimen'),
                _renderCard(
                  context: context,
                  contentWidget: const Column(
                    children: [
                      Row(
                        children: [
                          Text('새로운 식단이 등록되었습니다'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _renderSection({required String section}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  _renderCard({required BuildContext context, required Widget contentWidget}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(
          //모서리를 둥글게 하기 위해 사용
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: Colors.grey[200],
        elevation: 6.0, //그림자 깊이`
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: SingleChildScrollView(child: contentWidget),
        ),
      ),
    );
  }


  Widget _sliderIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imageList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 12,
              height: 12,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    Colors.white.withOpacity(_current == entry.key ? 0.9 : 0.4),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

}



}



