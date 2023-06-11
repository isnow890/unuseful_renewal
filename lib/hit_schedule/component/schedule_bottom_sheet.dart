import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime? selectedDate;
  final int? scheduleId;

  const ScheduleBottomSheet({
    Key? key,
    required this.selectedDate,
    required this.scheduleId,
  }) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
