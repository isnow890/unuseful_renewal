import 'package:json_annotation/json_annotation.dart';

import '../../hit_schedule/model/hit_schedule_model.dart';
part 'hit_schedule_at_home_model.g.dart';

abstract class HitScheduleAtHomeModelBase {}

class HitScheduleAtHomeModelLoading extends HitScheduleAtHomeModelBase {}

class HitScheduleAtHomeModelError extends HitScheduleAtHomeModelBase {
  final String message;

  HitScheduleAtHomeModelError({
    required this.message,
  });
}

@JsonSerializable()
class HitScheduleAtHomeModel extends HitScheduleAtHomeModelBase {
  final List<HitScheduleAtHomeMineModel> scheduleOfMineList;
  final List<HitScheduleAtHomeThreeDaysModel> threeDaysList;

  final List<HitScheduleModel> scheduleList;

  HitScheduleAtHomeModel({
    required this.scheduleOfMineList,
    required this.threeDaysList,
    required this.scheduleList,
  });
}

@JsonSerializable()
class HitScheduleAtHomeThreeDaysModel {
  final String morningNm;
  final String afternoonNm;
  final String nightNm;
  final String workDate;
  final String hdyYn;

  HitScheduleAtHomeThreeDaysModel(
      {required this.morningNm,
      required this.afternoonNm,
      required this.nightNm,
      required this.workDate,
      required this.hdyYn});
}

@JsonSerializable()
class HitScheduleAtHomeMineModel {
  final String workDate;
  final String dutyTypeCode;
  final String hdyYn;
  final String dutyName;
  final bool prediction;

  HitScheduleAtHomeMineModel({
    required this.workDate,
    required this.dutyTypeCode,
    required this.hdyYn,
    required this.dutyName,
    required this.prediction,
  });
}
