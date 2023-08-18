import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:unuseful/theme/component/circular_indicator.dart';
import 'package:unuseful/theme/component/custom_error_widget.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';
import '../../../colors.dart';
import '../model/hit_schedule_log_model.dart';
import '../provider/hit_duty_log_provider.dart';

class HitDutyLogScreen extends ConsumerStatefulWidget {
  const HitDutyLogScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HitDutyLogScreen> createState() => _HitDutyLogScreenState();
}

class _HitDutyLogScreenState extends ConsumerState<HitDutyLogScreen> {
  final ScrollController controller = ScrollController();

  // Map<String,dynamic> fi2 = {'hspTpCd' : '01', 'searchValue': '10884537','strDt': '20220522',
  //   'endDt': '20230619' ,'orderBy': 'desc'};

  @override
  Widget build(BuildContext context) {
    // final state3 = ref.watch(specimenNotifierProvider);

    //
    //
    //
    // final state2 = ref.watch(specimenFamilyProvider(fi2));

    final theme = ref.watch(themeServiceProvider);
    final state = ref.watch(hitDutyLogNotifierProvider);

    if (state is HitDutyLogModelLoading) {
      return const CircularIndicator();
    }

    if (state is HitDutyLogModelError) {
      return CustomErrorWidget(
          message: state.message,
          onPressed: () async =>
              ref.read(hitDutyLogNotifierProvider.notifier).getDutyLog());
    }

    final cp = state as HitDutyLogModel;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: RefreshIndicator(
        color: theme.color.primary,
        onRefresh: () async {
          ref.read(hitDutyLogNotifierProvider.notifier).getDutyLog();
        },
        child: Scrollbar(
          thumbVisibility: true,
          controller: controller,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: controller,
            separatorBuilder: (context, index) {
              return const Divider(
                height: 20.0,
              );
            },
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.data[index].changeInfo.contains('<->')
                          ? '일정\n변경'
                          : '신규\n일정',
                      style: TextStyle(
                          fontSize: 18,
                          color: state.data[index].changeInfo.contains('<->')
                              ? PRIMARY_COLOR
                              : Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                contentPadding: EdgeInsets.only(left: 0.0),
                title: Text(
                  DateFormat('yyyy-MM-dd HH:mm')
                      .format(state.data[index].changeDate),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(state.data[index].changeInfo ?? ''),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      state.data[index].stfInfo ?? '',
                    ),
                  ],
                ),
                isThreeLine: true,
              );
            },
          ),
        ),
      ),
    );
  }
}
