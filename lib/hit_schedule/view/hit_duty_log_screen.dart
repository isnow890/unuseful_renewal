import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:unuseful/common/component/custom_error_widget.dart';

import '../../common/component/custom_circular_progress_indicator.dart';
import '../../common/component/custom_loading_indicator_widget.dart';
import '../../common/const/colors.dart';
import '../model/hit_schedule_log_model.dart';
import '../provider/hit_duty_log_provider.dart';

class HitDutyLogScreen extends ConsumerStatefulWidget {
  const HitDutyLogScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HitDutyLogScreen> createState() => _HitDutyLogScreenState();
}

class _HitDutyLogScreenState extends ConsumerState<HitDutyLogScreen> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(hitDutyLogNotifierProvider);

    if (state is HitDutyLogModelLoading) {
      return const CustomLoadingIndicatorWidget();
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
        color: PRIMARY_COLOR,
        onRefresh: () async {
          ref.read(hitDutyLogNotifierProvider.notifier).getDutyLog();
        },
        child: Scrollbar(
          thumbVisibility: true,
          controller: controller,
          child: ListView.separated(
            controller: controller,
            separatorBuilder: (context, index) {
              return Divider(
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
                          color: state.data[index].changeInfo.contains('<->') ? PRIMARY_COLOR: Colors.black,
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
