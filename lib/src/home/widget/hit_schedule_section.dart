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

    return CarouselSlider(
      items: [
        HomeScreenCard(
          contentWidget: schedule is ModelBaseLoading
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
        HomeScreenCard(
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
              schedule is ModelBaseLoading
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
        HomeScreenCard(
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
              schedule is ModelBaseLoading
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
