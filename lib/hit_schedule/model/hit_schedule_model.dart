import 'package:json_annotation/json_annotation.dart';
part 'hit_schedule_model.g.dart';

abstract class HitScheduleModelBase {}


class HitScheduleModelLoading extends HitScheduleModelBase{}

class HitScheduleModelError extends HitScheduleModelBase {
  final String message;

  HitScheduleModelError({required this.message});
}

@JsonSerializable()
class HitScheduleModel extends HitScheduleModelBase {
  final List<HitScheduleListModel> data;

  HitScheduleModel({required this.data});

  factory HitScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$HitScheduleModelFromJson(json);
}

@JsonSerializable()
class HitScheduleListModel {
  final DateTime startDate;
  final DateTime endDate;
  final String stfNm;
  final String scheduleName;
  final String startTime;
  final String endTime;
  final String scheduleId;
  final List<HitScheduleListListModel> scheduleList;

  HitScheduleListModel({
    required this.startDate,
    required this.endDate,
    required this.stfNm,
    required this.scheduleName,
    required this.startTime,
    required this.endTime,
    required this.scheduleId,
    required this.scheduleList,
  });

  factory HitScheduleListModel.fromJson(Map<String, dynamic> json) =>
      _$HitScheduleListModelFromJson(json);
}
@JsonSerializable()

class HitScheduleListListModel {
  final String scheduleId;
  final DateTime scheduleDate;
  final DateTime startDate;
  final DateTime endDate;
  final String stfNm;
  final String scheduleName;
  final String startTime;
  final String endTime;

  HitScheduleListListModel({
    required this.scheduleId,
    required this.scheduleDate,
    required this.startDate,
    required this.endDate,
    required this.stfNm,
    required this.scheduleName,
    required this.startTime,
    required this.endTime,
  });
  
  factory HitScheduleListListModel.fromJson(Map<String,dynamic> json)
  =>_$HitScheduleListListModelFromJson(json);
}