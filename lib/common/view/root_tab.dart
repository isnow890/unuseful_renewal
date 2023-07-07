import 'dart:math';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/component/custom_circular_progress_indicator.dart';
import 'package:unuseful/common/model/hit_schedule_at_home_model.dart';
import 'package:unuseful/hit_schedule/model/hit_duty_statistics_model.dart';
import 'package:unuseful/meal/model/meal_model.dart';
import 'package:unuseful/user/provider/login_variable_provider.dart';
import 'package:unuseful/user/provider/user_me_provider.dart';

import '../../meal/provider/meal_provider.dart';
import '../../user/model/user_model.dart';
import '../../user/provider/auth_provider.dart';
import '../component/custom_error_widget.dart';
import '../component/text_title.dart';
import '../layout/default_layout.dart';
import '../provider/home_provider.dart';

class RootTab extends ConsumerStatefulWidget {
  static String get routeName => 'home';

  RootTab({Key? key}) : super(key: key);

  @override
  ConsumerState<RootTab> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<RootTab> {
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
                _renderSection(section: 'schedule'),
                _HitScheduleSection(),
                SizedBox(
                  height: 8,
                ),
                _renderSection(section: 'meal'),
                MealSection(),
//glkwjgklwejglkwejgjklwe
                SizedBox(
                  height: 20,
                ),
                _renderSection(section: 'telephone'),
                renderCard(
                  context: context,
                  contentWidget: Column(
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
                renderCard(
                  context: context,
                  contentWidget: Column(
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
}

class MealSection extends ConsumerStatefulWidget {
  const MealSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MealSectionState();
}

class _MealSectionState extends ConsumerState<MealSection> {
  @override
  Widget build(BuildContext context) {
    final seState = ref.watch(mealFamilyProvider('01'));
    final mdState = ref.watch(mealFamilyProvider('02'));
    var se = MealModel();
    var md = MealModel();

    if (seState is MealModelError || mdState is MealModelError) {
      return renderCard(
          context: context,
          contentWidget: CustomErrorWidget(
              message: '에러가 발생하였습니다',
              onPressed: () async => ref
                  .read(homeNotifierProvider.notifier)
                  .getHitScheduleAtHome()));
    }

    if (seState is MealModel && mdState is MealModel) {
      se = seState;
      md = mdState;
    }

    return renderCard(
      context: context,
      contentWidget:
          (seState is MealModelLoading || mdState is MealModelLoading)
              ? const Center(child: CustomCircularProgressIndicator())
              : Column(
                  children: [
                    renderCardInside('01', se),
                    renderCardInside('02', md),
                  ],
                ),
    );
  }

  renderCardInside(String hspTpCd, MealModel mealModel) {
    if (mealModel.data!.isEmpty) {
      return Text('No data found ${hspTpCd}');
    }

    return Column(
      children: [
        Text(mealModel.data![0].title),
        Row(
          children: mealModel.data![0].imgUrls
              .map(
                (e) => Container(
                  width: 100,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(e!, fit: BoxFit.fill),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}

class _HitScheduleSection extends ConsumerStatefulWidget {
  const _HitScheduleSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __HitScheduleStateSection();
}

class __HitScheduleStateSection extends ConsumerState<_HitScheduleSection> {
  @override
  Widget build(BuildContext context) {
    final schedule = ref.watch(homeNotifierProvider);

    final user = ref.read(userMeProvider.notifier).state;
    final convertedUser = user as UserModel;

    if (schedule is HitScheduleAtHomeModelError) {
      return CustomErrorWidget(
          message: schedule.message,
          onPressed: () async =>
              ref.read(homeNotifierProvider.notifier).getHitScheduleAtHome());
    }

    var cp = HitScheduleAtHomeModel();

    if (schedule is HitScheduleAtHomeModel) {
      cp = schedule;
    }

    return CarouselSlider(
      items: [
        renderCard(
          context: context,
          contentWidget: schedule is HitScheduleAtHomeModelLoading
              ? Center(child: CustomCircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '오늘의 전산정보팀 일정',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Divider(
                          height: 15,
                        ),
                        (cp.scheduleList!.length == 0
                            ? Text('일정이 없습니다.')
                            : Column(
                                children: cp.scheduleList!
                                    .map((e) => Text(e.scheduleName!))
                                    .toList(),
                              )),
                      ]),
                ),
        ),
        renderCard(
          context: context,
          contentWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.stfNm}님의 당직 일정',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Divider(
                height: 15,
              ),
              schedule is HitScheduleAtHomeModelLoading
                  ? CustomCircularProgressIndicator()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: cp.scheduleOfMineList!
                          .map((e) => Text(
                              '${e.workDate!} ${e.dutyName} ${e.prediction! ? '예상' : ''}'))
                          .toList(),
                    ),
            ],
          ),
        ),
        renderCard(
          context: context,
          contentWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '3일간의 당직 일정',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Divider(
                height: 15,
              ),
              schedule is HitScheduleAtHomeModelLoading
                  ? CustomCircularProgressIndicator()
                  : Column(
                      children: cp.threeDaysList!
                          .map((e) => Text('${e.afternoonNm!}'))
                          .toList(),
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
    );
  }
}

renderCard({required BuildContext context, required Widget contentWidget}) {
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
        child: contentWidget,
      ),
    ),
  );
}

//
//
//   Widget _sliderIndicator() {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: imageList.asMap().entries.map((entry) {
//           return GestureDetector(
//             onTap: () => _controller.animateToPage(entry.key),
//             child: Container(
//               width: 12,
//               height: 12,
//               margin:
//               const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color:
//                 Colors.white.withOpacity(_current == entry.key ? 0.9 : 0.4),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
