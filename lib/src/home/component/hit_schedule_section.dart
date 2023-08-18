import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/common/model/hit_schedule_at_home_model.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/theme/component/section_card.dart';
import 'package:unuseful/src/home/provider/home_provider.dart';
import 'package:unuseful/src/user/model/user_model.dart';
import 'package:unuseful/src/user/provider/gloabl_variable_provider.dart';
import 'package:unuseful/src/user/provider/user_me_provider.dart';
import 'package:unuseful/theme/component/circular_indicator.dart';
import 'package:unuseful/theme/component/custom_error_widget.dart';
import 'package:unuseful/theme/layout/default_layout.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

class HitScheduleSection extends ConsumerStatefulWidget {
  const HitScheduleSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __HitScheduleStateSection();
}

class __HitScheduleStateSection extends ConsumerState<HitScheduleSection> {
  @override
  Widget build(BuildContext context) {
    final schedule = ref.watch(homeNotifierProvider);
    final theme = ref.watch(themeServiceProvider);
    final global = ref.watch(globalVariableStateProvider);

    if (schedule is ModelBaseLoading) return const CircularIndicator();

    var cp = schedule as HitScheduleAtHomeModel;

    return DefaultLayout(
        canRefresh: true,
        onRefreshAndError: () async {
          ref.read(homeNotifierProvider.notifier).getHitScheduleAtHome();
        },
        state: [schedule],
        child: ListView(children: [
          Column(
            children: [
              SectionCard(
                contentWidget: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '오늘의 전산정보팀 일정',
                          style: theme.typo.subtitle1.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          height: 30,
                        ),
                        (cp.scheduleList!.isEmpty
                            ? Text(
                                '일정이 없습니다.',
                                style: theme.typo.body1,
                              )
                            : Column(
                                children: cp.scheduleList!
                                    .map((e) => Text(
                                          e.scheduleName!,
                                          style: theme.typo.body1,
                                        ))
                                    .toList(),
                              )),
                      ]),
                ),
              ),
              SectionCard(
                contentWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${global.stfNm}님의 당직 일정',
                      style: theme.typo.subtitle1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: cp.scheduleOfMineList!
                          .map((e) => Text(
                              style: theme.typo.body1,
                              '${e.workDate!} ${e.dutyName} ${e.prediction! ? '예상' : ''}'))
                          .toList(),
                    ),
                  ],
                ),
              ),
              SectionCard(
                contentWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '3일간의 당직 일정',
                      style: theme.typo.subtitle1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      height: 15,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: cp.threeDaysList!
                            .map((e) => Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          style: theme.typo.body1,
                                          text:
                                              '${e.workDate} ${e.hdyYn == 'Y' ? '휴일' : '평일'}'),
                                      TextSpan(
                                          style: theme.typo.body1,
                                          text:
                                              '${e.hdyYn == 'Y' ? ' 오전 ' : ''}${e.hdyYn == 'Y' ? e.morningNm : ''}'),
                                      TextSpan(
                                          text: ' 오후 ${e.afternoonNm!}',
                                          style: theme.typo.body1),
                                    ],
                                  ),
                                ))
                            .toList()),
                  ],
                ),
              ),
            ],
          ),
        ]));
  }
}
