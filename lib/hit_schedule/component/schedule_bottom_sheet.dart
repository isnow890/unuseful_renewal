import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduleBottomSheet extends ConsumerStatefulWidget {
  final String dutyTypeCode;
  final DateTime dutyDate;
  final String dutyName;
  final String stfNm;

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
  }) : super(key: key);

  @override
  ConsumerState<ScheduleBottomSheet> createState() =>
      _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends ConsumerState<ScheduleBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
        child: Container(
      height: MediaQuery.of(context).size.height / 4 + bottomInset,
      child: Text('test'),
    ));
  }
}
