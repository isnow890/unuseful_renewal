import 'package:json_annotation/json_annotation.dart';
import 'package:unuseful/src/common/model/model_base.dart';

import '../../hit_schedule/model/hit_schedule_model.dart';
part 'hit_schedule_at_home_model.g.dart';


@JsonSerializable()
class HitScheduleAtHomeModel extends ModelBase {
  final List<HitScheduleAtHomeMineModel>? scheduleOfMineList;
  final List<HitScheduleAtHomeThreeDaysModel>? threeDaysList;

  final List<HitScheduleListModel>? scheduleList;

  HitScheduleAtHomeModel({
    this.scheduleOfMineList,
    this.threeDaysList,
    this.scheduleList,
  });
  
  
  factory HitScheduleAtHomeModel.fromJson(Map<String,dynamic> json)
  =>_$HitScheduleAtHomeModelFromJson(json);
  
}

@JsonSerializable()
class HitScheduleAtHomeThreeDaysModel {
  final String? morningNm;
  final String? afternoonNm;
  final String? nightNm;
  final String? workDate;
  final String? hdyYn;

  HitScheduleAtHomeThreeDaysModel(
      {required this.morningNm,
      required this.afternoonNm,
      required this.nightNm,
      required this.workDate,
      required this.hdyYn});
  
  factory HitScheduleAtHomeThreeDaysModel.fromJson(Map<String,dynamic> json)
  =>_$HitScheduleAtHomeThreeDaysModelFromJson(json);
}

@JsonSerializable()
class HitScheduleAtHomeMineModel {
  final String? workDate;
  final String? dutyTypeCode;
  final String? hdyYn;
  final String? dutyName;
  final bool? prediction;

  HitScheduleAtHomeMineModel({
    required this.workDate,
    required this.dutyTypeCode,
    required this.hdyYn,
    required this.dutyName,
    required this.prediction,
  });
  
  factory HitScheduleAtHomeMineModel.fromJson(Map<String,dynamic> json)
  =>_$HitScheduleAtHomeMineModelFromJson(json);
}
