import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:unuseful/common/const/colors.dart';

import '../../common/component/custom_circular_progress_indicator.dart';
import '../../common/component/general_toast_message.dart';
import '../model/hit_my_duty_model.dart';
import '../provider/hit_my_duty_provider.dart';
import '../provider/hit_my_duty_selected_schedule_provider.dart';

class ScheduleBottomSheet extends ConsumerStatefulWidget {
  final String dutyTypeCode;
  final DateTime dutyDate;
  final String dutyName;
  final String stfNm;
  final String stfNum;

  // required this.dutyTypeCode,
  // required this.workMonthOriginal,
  // required this.workDateOriginal,
  // required this.workMonthUpdate,
  // required this.workDateUpdate,
  // required this.originalName,
  // required this.updateName,
  // required this.wkSeqOriginal,
  // required this.wkSeqUpdate,
  // required this.hdyYn,
  // required this.workType,

  const ScheduleBottomSheet({
    Key? key,
    required this.dutyTypeCode,
    required this.dutyDate,
    required this.dutyName,
    required this.stfNm,
    required this.stfNum,
  }) : super(key: key);

  @override
  ConsumerState<ScheduleBottomSheet> createState() =>
      _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends ConsumerState<ScheduleBottomSheet> {
  final defaultTextStyle = TextStyle(
    fontSize: 15.0,
    // color: Colors.grey[600],
    fontWeight: FontWeight.w500,
  );

  final defaultBoxDeco = BoxDecoration(
    color: Colors.grey[200],
    //테두리 깍기
    borderRadius: BorderRadius.circular(6.0),
  );

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(hitMyDutyFamilyProvider(widget.stfNum));
    final selectedDuty = ref.watch(hitMyDutySelectedScheduleProvider);

    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    if (state is HitMyDutyModelLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(child: CustomCircularProgressIndicator()),
        ],
      );
    }
    var cp = state as HitMyDutyModel;

    // Text('test' + widget.stfNum)
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5 + bottomInset,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(
                DateFormat('yyyy년 MM월 dd일 EEEE').format(widget.dutyDate),
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    widget.stfNm,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.dutyName,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'schedule has been chosen.',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'choose your duty schedule',
                style: TextStyle(
                  fontSize: 15.0,
                  color: BODY_TEXT_COLOR,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 40,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ChoiceChip(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shadowColor: Colors.teal,
                      pressElevation: 5,
                      // avatar: Text(cp.data[index] == selectedDuty ?'v':''),
                      label: Container(
                        height: 40,
                        child: Row(
                          children: [
                            // Text('✔',style: TextStyle(color: cp.data[index] == selectedDuty ? Colors.black:Colors.transparent),),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              cp.data[index].wkDate,
                              style: defaultTextStyle,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '(${cp.data[index].day})',
                              style: defaultTextStyle,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(cp.data[index].dutyTypeNm,
                                style: defaultTextStyle),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                      selected: cp.data[index] == selectedDuty,
                      selectedColor: PRIMARY_COLOR,
                      backgroundColor: Colors.grey[200],

                      onSelected: (bool selected) {
                        ref
                            .read(hitMyDutySelectedScheduleProvider.notifier)
                            .update((state) => cp.data[index]);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 10);
                  },
                  itemCount: cp.data.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {


                      if (selectedDuty.day.isEmpty)
                        showToast(
                            msg: 'please select one of your schedule',
                            toastLength: Toast.LENGTH_SHORT);
                    },
                    child: Text('change schedule'),
                    style: ElevatedButton.styleFrom(
                      primary: PRIMARY_COLOR,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
