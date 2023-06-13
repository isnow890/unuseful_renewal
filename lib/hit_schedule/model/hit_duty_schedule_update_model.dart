import 'package:json_annotation/json_annotation.dart';

part 'hit_duty_schedule_update_model.g.dart';

abstract class HitDutyScheduleUpdateModelBase {}

class HitDutyScheduleUpdateModelLoading
    extends HitDutyScheduleUpdateModelBase {}

class HitDutyScheduleUpdateModelError extends HitDutyScheduleUpdateModelBase {
  final String message;

  HitDutyScheduleUpdateModelError({required this.message});
}

@JsonSerializable()
class HitDutyScheduleUpdateModel extends HitDutyScheduleUpdateModelBase {
  final String dutyTypeCode; //평일 오후 2, 휴일 오전3, 휴일 오후 4
  final String workMonthOriginal;
  final String workDateOriginal;
  final String workMonthUpdate;
  final String workDateUpdate;
  final String originalName;
  final String updateName;
  final String wkSeqOriginal;
  final String wkSeqUpdate;
  final String hdyYn;
  final String workType;

  HitDutyScheduleUpdateModel({
    required this.dutyTypeCode,
    required this.workMonthOriginal,
    required this.workDateOriginal,
    required this.workMonthUpdate,
    required this.workDateUpdate,
    required this.originalName,
    required this.updateName,
    required this.wkSeqOriginal,
    required this.wkSeqUpdate,
    required this.hdyYn,
    required this.workType,
  });

  factory HitDutyScheduleUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$HitDutyScheduleUpdateModelFromJson(json);
}
