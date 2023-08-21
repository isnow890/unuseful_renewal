import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:unuseful/colors.dart';
import 'package:unuseful/data.dart';
import 'package:unuseful/dio.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/hit_schedule/component/update_schedule_dialog.dart';
import 'package:unuseful/src/home/provider/response_model_state_provider.dart';
import 'package:unuseful/src/hit_schedule/model/hit_duty_schedule_update_model.dart';
import 'package:unuseful/src/hit_schedule/repository/hit_schedule_repository.dart';
import 'package:unuseful/src/user/model/user_model.dart';
import 'package:unuseful/src/user/provider/gloabl_variable_provider.dart';
import 'package:unuseful/theme/component/bottom_sheet/base_bottom_sheet.dart';
import 'package:unuseful/theme/component/button/button.dart';
import 'package:unuseful/theme/component/indicator/circular_indicator.dart';
import 'package:unuseful/theme/component/general_toast_message.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';
import '../../../theme/component/chip/custom_choice_chip.dart';
import '../../../theme/component/toast/toast.dart';
import '../../../theme/foundation/app_theme.dart';
import '../../common/model/response_model.dart';
import '../../user/provider/user_me_provider.dart';
import '../model/hit_my_duty_model.dart';
import '../provider/hit_duty_schedule_update_provider.dart';
import '../provider/hit_my_duty_provider.dart';
import '../provider/hit_schedule_for_event_provider.dart';
import '../provider/hit_schedule_provider.dart';
import '../provider/hit_schedule_selected_day_provider.dart';

class ScheduleBottomSheet extends ConsumerStatefulWidget {
  final String dutyTypeCode;
  final DateTime dutyDate;
  final String dutyName;
  final String stfNm;
  final String stfNum;
  final String wkSeq;

  const ScheduleBottomSheet({
    Key? key,
    required this.dutyTypeCode,
    required this.dutyDate,
    required this.dutyName,
    required this.stfNm,
    required this.stfNum,
    required this.wkSeq,
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

  HitMyDutyListModel selectedDuty = HitMyDutyListModel();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(hitMyDutyFamilyProvider(widget.stfNum));
    final global = ref.watch(globalVariableStateProvider);
    final updateResult = ref.watch(responseModelStateProvider);

    final theme = ref.watch(themeServiceProvider);

    if (state is ModelBaseError) {
      Navigator.of(context).pop();
    }

    if (state is HitMyDutyModelLoading) {
      return const CircularIndicator();
    }
    var cp = state as HitMyDutyModel;

    // Text('test' + widget.stfNum)
    return BaseBottomSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Theme Tile
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${DateFormat('yyyy년 MM월 dd일').format(widget.dutyDate)} ${DateFormat.EEEE('ko_KR').format(widget.dutyDate)}',
                  style: theme.typo.headline3,
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    Text(
                      widget.stfNm,
                      style: theme.typo.subtitle1,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.dutyName,
                      style: theme.typo.subtitle1,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '일정이 선택되었습니다.',
                      style: theme.typo.subtitle1,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  '변경하려는 나의 일정을 선택해주세요.',
                  style:
                      theme.typo.subtitle1.copyWith(color: theme.color.subtext),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  child: _myScheduleList(theme, cp),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _changeDutyButton(updateResult, global),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _myScheduleList(AppTheme theme, cp) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomChoiceChip(
              selected: index == 0
                  ? selectedDuty.isNew
                  : (cp.data[index - 1] == selectedDuty),
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
              label: Container(
                padding: const EdgeInsets.all(8),
                child: index == 0
                    ? Text(
                        '신규 일정 추가',
                        style: theme.typo.subtitle1.copyWith(
                          color: theme.color.text,
                        ),
                      )
                    : Row(
                        children: [
                          // Text('✔',style: TextStyle(color: cp.data[index] == selectedDuty ? Colors.black:Colors.transparent),),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(cp.data[index - 1].wkDate!,
                              style: theme.typo.subtitle1.copyWith(
                                color: theme.color.text,
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                          Text('(${cp.data[index - 1].day})',
                              style: theme.typo.subtitle1.copyWith(
                                color: theme.color.text,
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            cp.data[index - 1].dutyTypeNm!,
                            style: theme.typo.subtitle1.copyWith(
                              color: theme.color.text,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(width: 10);
      },
      itemCount: cp.data.length + 1,
      scrollDirection: Axis.horizontal,
    );
  }

  _changeDutyButton(ModelBase updateResult, global) {
    return Button(
        type: ButtonType.fill,
        onPressed: updateResult is ModelBaseLoading
            ? null
            : () {
                if (selectedDuty.day == null) {
                  if (!selectedDuty.isNew) {
                    Toast.show('스케쥴을 선택해주세요.');
                    return;
                  }
                }

                showDialog(
                    context: context,
                    builder: (context) {
                      return UpdateScheduleDialog(
                          content: _returnConfirmMessage(
                            widget.dutyTypeCode,
                            widget.stfNm,
                            widget.dutyDate,
                            selectedDuty.dutyTypeCode!,
                            global.stfNm.toString(),
                            DateFormat('yyyy-MM-dd').parse(
                              selectedDuty.wkDate! == ''
                                  ? '2023-06-20'
                                  : selectedDuty.wkDate!,
                            ),
                          ),
                          onUpdateSchedulePressed: () async {
                            //flutter - Waiting asynchronously for Navigator.push() - linter warning appears: use_build_context_synchronously - Stack Overflow
                            final navigator =
                                Navigator.of(context); // store the Navigator

                            final param = HitDutyScheduleUpdateModel(
                              dutyTypeCodeOriginal: widget.dutyTypeCode,
                              workMonthOriginal:
                                  DateFormat('yyyyMM').format(widget.dutyDate),
                              workDateOriginal: DateFormat('yyyy-MM-dd')
                                  .format(widget.dutyDate),
                              workMonthUpdate: selectedDuty.wkMonth,
                              workDateUpdate: selectedDuty.wkDate,
                              originalName: widget.stfNm,
                              updateName: global.stfNm,
                              wkSeqOriginal: widget.wkSeq,
                              wkSeqUpdate: selectedDuty.wkSeq,
                              workType: selectedDuty.isNew ? 'new' : '',
                              dutyTypeCodeUpdate: selectedDuty.dutyTypeCode,
                              stfNo: global.stfNo,
                            );

                            final result = await _updateHitDuty(param: param);

                            if (result == null) {
                              Toast.show('에러가 발생하였습니다.');
                            } else if (result.isSuccess) {
                              Toast.show('일정이 변경되었습니다.');
                            } else if (result.message != null) {
                              Toast.show(result.message!);
                            }
                            ref.refresh(hitScheduleNotifierProvider);
                            ref.refresh(hitSheduleForEventNotifierProvider);

                            navigator
                                .pop(); // use the Navigator, not the BuildContext
                          });
                    });
              },
        text: '일정 변경');
  }

  Future<ResponseModel?> _updateHitDuty(
      {required HitDutyScheduleUpdateModel param}) async {
    ref
        .read(responseModelStateProvider.notifier)
        .update((state) => ModelBaseInit());

    try {
      final repository =
          HitScheduleRepository(ref.read(dioProvider), baseUrl: ip);
      final result = await repository.updateDuty(body: param);
      ref.read(responseModelStateProvider.notifier).update((state) => result);

      return result;
    } catch (e) {
      ref
          .read(responseModelStateProvider.notifier)
          .update((state) => ModelBaseError(message: '에러가 발생하였습니다.'));
    }
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
      return returnString + '${stfNmUpdate}님의 신규 일정으로 추가하시겠습니까?';
    } else {
      return returnString +
          '${DateFormat('yyyy-MM-dd').format(dutyDateUpdate!)} (${DateFormat.E('ko_KR').format(dutyDateUpdate!)}) ${_returnDutyTypeName(dutyTypeCodeUpdate)} ${stfNmUpdate}님으로 변경 하시겠습니까?';
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
