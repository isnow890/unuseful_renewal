import 'package:json_annotation/json_annotation.dart';

part 'hit_duty_statistics_model.g.dart';

abstract class HitDutyStatisticsModelBase {}

class HitDutyStatisticsModelLoading extends HitDutyStatisticsModelBase {}

class HitDutyStatisticsModelError extends HitDutyStatisticsModelBase {
  final String message;

  HitDutyStatisticsModelError({required this.message});
}

@JsonSerializable()
class HitDutyStatisticsModel extends HitDutyStatisticsModelBase {
  final List<HitDutyStatisticsListModel> data;

  HitDutyStatisticsModel({required this.data});

  factory HitDutyStatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$HitDutyStatisticsModelFromJson(json);
}

@JsonSerializable()
class HitDutyStatisticsListModel {
  final String stfNm;
  final String stfNo;
  final String stfNum;
  final int afternoonCount;
  final int afternoonHour;
  final int morningHolidayCount;
  final int morningHolidayHour;
  final int afternoonHolidayCount;
  final int afternoonHolidayHour;
  final int totalCount;
  final int totalHour;
  final int rank;

  HitDutyStatisticsListModel( {
    required this.stfNm,
    required this.stfNo,
    required this.stfNum,
    required this.afternoonCount,
    required this.afternoonHour,
    required this.morningHolidayCount,
    required this.morningHolidayHour,
    required this.afternoonHolidayCount,
    required this.afternoonHolidayHour,
    required this.totalCount,
    required this.totalHour,
    required this.rank,
  });

  factory HitDutyStatisticsListModel.fromJson(Map<String, dynamic> json) =>
      _$HitDutyStatisticsListModelFromJson(json);
}
