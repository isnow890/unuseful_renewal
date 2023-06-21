import 'package:json_annotation/json_annotation.dart';

part 'hit_duty_schedule_update_model.g.dart';

@JsonSerializable()
class HitDutyScheduleUpdateModel {
  final String? dutyTypeCodeOriginal; //평일 오후 2, 휴일 오전3, 휴일 오후 4
  final String? workMonthOriginal;
  final String? workDateOriginal;
  final String? dutyTypeCodeUpdate; //평일 오후 2, 휴일 오전3, 휴일 오후 4
  final String? workMonthUpdate;
  final String? workDateUpdate;
  final String? originalName;
  final String? updateName;
  final String? wkSeqOriginal;
  final String? wkSeqUpdate;
  final String? workType;

  HitDutyScheduleUpdateModel({
    required this.dutyTypeCodeOriginal,
    required this.workMonthOriginal,
    required this.workDateOriginal,
    required this.workMonthUpdate,
    required this.workDateUpdate,
    required this.originalName,
    required this.updateName,
    required this.wkSeqOriginal,
    required this.wkSeqUpdate,
    required this.workType,
    required this.dutyTypeCodeUpdate,
  });

  factory HitDutyScheduleUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$HitDutyScheduleUpdateModelFromJson(json);

  Map<String, dynamic> toJson() => _$HitDutyScheduleUpdateModelToJson(this);
}
