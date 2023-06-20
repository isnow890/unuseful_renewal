import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:unuseful/common/const/colors.dart';
import 'package:unuseful/user/model/user_model.dart';

import '../../common/component/custom_circular_progress_indicator.dart';
import '../../common/component/general_toast_message.dart';
import '../../user/provider/login_variable_provider.dart';
import '../../user/provider/user_me_provider.dart';
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

  HitMyDutyListModel selectedDuty = HitMyDutyListModel(
    wkMonth: '',
    wkDate: '',
    day: '',
    stfNo: '',
    stfNm: '',
    wkSeq: '',
    hdyYn: '',
    dutyTypeNm: '',
    dutyTypeCode: '',
  );

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(hitMyDutyFamilyProvider(widget.stfNum));
    final userMe = ref.watch(userMeProvider.notifier).state;
    final user = userMe as UserModel;

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
                '${DateFormat('yyyy년 MM월 dd일').format(widget.dutyDate)} ${DateFormat.EEEE('ko_KR').format(widget.dutyDate)}',
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
                    '일정이 선택되었습니다.',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                '변경하려는 나의 일정을 선택해주세요.',
                style: TextStyle(
                  fontSize: 15.0,
                  color: BODY_TEXT_COLOR,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 35,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ChoiceChip(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          shadowColor: Colors.teal,
                          pressElevation: 5,
                          // avatar: Text(cp.data[index] == selectedDuty ?'v':''),
                          label: Container(
                            child: index == 0
                                ? Text('신규 일정 추가',
                                    style: selectedDuty.isNew
                                        ? defaultTextStyle.copyWith(
                                            color: Colors.white)
                                        : defaultTextStyle)
                                : Row(
                                    children: [
                                      // Text('✔',style: TextStyle(color: cp.data[index] == selectedDuty ? Colors.black:Colors.transparent),),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        cp.data[index - 1].wkDate,
                                        style:
                                            cp.data[index - 1] == selectedDuty
                                                ? defaultTextStyle.copyWith(
                                                    color: Colors.white)
                                                : defaultTextStyle,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '(${cp.data[index - 1].day})',
                                        style:
                                            cp.data[index - 1] == selectedDuty
                                                ? defaultTextStyle.copyWith(
                                                    color: Colors.white)
                                                : defaultTextStyle,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(cp.data[index - 1].dutyTypeNm,
                                          style:
                                              cp.data[index - 1] == selectedDuty
                                                  ? defaultTextStyle.copyWith(
                                                      color: Colors.white)
                                                  : defaultTextStyle),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                          ),
                          selected: index == 0
                              ? selectedDuty.isNew
                              : (cp.data[index - 1] == selectedDuty),
                          selectedColor: PRIMARY_COLOR,
                          backgroundColor: Colors.grey[200],
                          onSelected: (bool selected) {
                            setState(() {
                              if (index == 0) {
                                selectedDuty = HitMyDutyListModel(
                                  wkMonth: '',
                                  wkDate: '',
                                  day: '',
                                  stfNo: '',
                                  stfNm: '',
                                  wkSeq: '',
                                  hdyYn: '',
                                  dutyTypeNm: '',
                                  dutyTypeCode: '',
                                );
                                selectedDuty.isNew = true;
                              } else {
                                cp.data[index - 1].isNew = false;
                                selectedDuty = cp.data[index - 1];
                                selectedDuty.isNew = false;
                              }
                            });
                          },
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 10);
                  },
                  itemCount: cp.data.length + 1,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print(selectedDuty.day);

                      if (selectedDuty.day.isEmpty) {
                        if (!selectedDuty.isNew) {
                          showToast(
                              msg: '스케쥴을 선택해주세요.',
                              toastLength: Toast.LENGTH_SHORT);
                          return;
                        }
                      }

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            // title: new Text(title),
                            content: new Text(
                              _returnConfirmMessage(
                                widget.dutyTypeCode,
                                widget.stfNm,
                                widget.dutyDate,
                                selectedDuty.dutyTypeCode,
                                user.stfNm.toString(),
                                DateFormat('yyyy-MM-dd').parse(
                                  selectedDuty.wkDate == ''
                                      ? '2023-06-20'
                                      : selectedDuty.wkDate,
                                ),
                              ),
                              style: TextStyle(fontSize: 14.0),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  primary: PRIMARY_COLOR,
                                ),
                                child: Text('확인'),
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(
                                    width: 1.0,
                                    color: PRIMARY_COLOR,
                                  ),
                                ),
                                child: Text('취소',
                                    style: TextStyle(
                                      color: PRIMARY_COLOR,
                                    )),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('일정 변경'),
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

  _returnConfirmMessage(
      String dutyTypeCodeOriginal,
      String stfNmOriginal,
      DateTime dutyDateOriginal,
      String dutyTypeCodeUpdate,
      String stfNmUpdate,
      DateTime? dutyDateUpdate) {
    var returnString =
        '${DateFormat('yyyy-MM-dd').format(dutyDateOriginal)} (${DateFormat.E('ko_KR').format(dutyDateOriginal)}) ${_returnDutyTypeName(dutyTypeCodeOriginal)} $stfNmOriginal님의 일정을\n';

    if (selectedDuty.isNew) {
      return returnString + ' ${stfNmUpdate}님의 신규 일정으로 변경하시겠습니까?';
    } else {
      return returnString +
          ' ${DateFormat('yyyy-MM-dd').format(dutyDateUpdate!)} (${DateFormat.E('ko_KR').format(dutyDateUpdate!)}) ${_returnDutyTypeName(dutyTypeCodeUpdate)} ${stfNmUpdate}님으로 일정 변경 하시겠습니까?';
    }
  }

  _returnDutyTypeName(String dutyTypeCode) {
    //평일 오후 2, 휴일 오전3, 휴일 오후 4
    switch (dutyTypeCode) {
      case '2':
        return '평일 오후';
      case '3':
        return '휴일 오전';
      case '4':
        return '휴일 오후';
    }
  }
}

// onPressed: () async {
// final resp = await ref
//     .read(orderProvider.notifier)
//     .postOrder();
// if (resp) {
// context.goNamed(OrderDoneScreen.routeName);
// } else {
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(content: Text('결제 실패!')));
// }
// },
