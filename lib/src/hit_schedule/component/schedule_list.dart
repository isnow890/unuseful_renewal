import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/hit_schedule/component/schedule_bottom_sheet.dart';
import 'package:unuseful/src/hit_schedule/component/schedule_card.dart';
import 'package:unuseful/src/hit_schedule/provider/hit_duty_schedule_update_provider.dart';
import 'package:unuseful/src/hit_schedule/provider/hit_my_duty_provider.dart';
import 'package:unuseful/src/user/provider/gloabl_variable_provider.dart';
import 'package:unuseful/theme/component/circular_indicator.dart';
import 'package:unuseful/theme/layout/default_layout.dart';

import '../../user/model/user_model.dart';
import '../../user/provider/user_me_provider.dart';
import '../model/hit_schedule_model.dart';
import '../provider/hit_schedule_provider.dart';
import '../provider/hit_schedule_selected_day_provider.dart';

class ScheduleList extends ConsumerWidget {
  const ScheduleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final selectedDay = ref.watch(hitScheduleSelectedDayProvider);
    final state = ref.watch(hitScheduleNotifierProvider);
    final global = ref.watch(globalVariableStateProvider);
    var stfNum = global.hitDutyYn;

    if (state is HitScheduleModelLoading) {
      return const CircularIndicator();
    }

    final cp = state as HitScheduleModel;
    return DefaultLayout(
        onRefreshAndError: () async {
          ref.read(hitScheduleNotifierProvider.notifier).getHitSchedule(false);
        },
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index == cp.data.length)
                return const SizedBox(
                  height: 5,
                );

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () async {
                    if (state.data[index].scheduleType == 'duty') {
                      await ref
                          .read(hitMyDutyFamilyProvider(stfNum!).notifier)
                          .getDutyOfMine();

                      ref.refresh(hitDutyScheduleUpdateNotifierProvider);

                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) {
                            return ScheduleBottomSheet(
                              dutyTypeCode: state.data[index].dutyTypeCode!,
                              dutyDate: state.data[index].startDate,
                              dutyName: state.data[index].scheduleName!,
                              stfNm: state.data[index].stfNm!,
                              stfNum: stfNum!,
                              wkSeq: state.data[index].wkSeq!,
                            );
                          });
                    }
                  },
                  child: ScheduleCard(
                    startDate: state.data[index].startDate,
                    endDate: state.data[index].endDate,
                    startTime: state.data[index].startTime ?? '',
                    endTime: state.data[index].endTime ?? '',
                    content: state.data[index].scheduleName ?? '',
                    stfNm: state.data[index].stfNm ?? '',
                    scheduleType: state.data[index].scheduleType ?? '',
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 8,
              );
            },
            itemCount: cp.data.length + 1));
  }
}
