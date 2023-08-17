import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/common/model/hit_schedule_at_home_model.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/home/component/home_screen_card.dart';
import 'package:unuseful/src/home/provider/home_provider.dart';
import 'package:unuseful/src/user/model/user_model.dart';
import 'package:unuseful/src/user/provider/user_me_provider.dart';
import 'package:unuseful/theme/component/custom_circular_progress_indicator.dart';
import 'package:unuseful/theme/component/custom_error_widget.dart';
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

    final user = ref.read(userMeProvider.notifier).state;
    final convertedUser = user as UserModel;

    if (schedule is ModelBaseError) {
      return CustomErrorWidget(
          message: schedule.message,
          onPressed: () async =>
              ref.read(homeNotifierProvider.notifier).getHitScheduleAtHome());
    }

    var cp = HitScheduleAtHomeModel();

    if (schedule is HitScheduleAtHomeModel) {
      cp = schedule;
    }

    return Column(
      children: [
        HomeScreenCard(
          contentWidget: schedule is ModelBaseLoading
              ? const Center(child: CustomCircularProgressIndicator())
              : SingleChildScrollView(
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
        HomeScreenCard(
          contentWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.stfNm}님의 당직 일정',
                style: theme.typo.subtitle1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                height: 15,
              ),
              schedule is ModelBaseLoading
                  ? CustomCircularProgressIndicator()
                  : Column(
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
        HomeScreenCard(
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
              schedule is ModelBaseLoading
                  ? const CustomCircularProgressIndicator()
                  : Column(
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
    );
  }
}
