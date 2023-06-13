import 'package:json_annotation/json_annotation.dart';

part 'hit_schedule_log_model.g.dart';

abstract class HitDutyLogModelBase {}

class HitDutyLogModelLoading extends HitDutyLogModelBase {}

class HitDutyLogModelError extends HitDutyLogModelBase {
  final String message;

  HitDutyLogModelError({required this.message});
}

@JsonSerializable()
class HitDutyLogModel extends HitDutyLogModelBase {
  final List<HitDutyLogListModel> data;

  HitDutyLogModel({required this.data});

  factory HitDutyLogModel.fromJson(Map<String, dynamic> json) =>
      _$HitDutyLogModelFromJson(json);
}

@JsonSerializable()
class HitDutyLogListModel {
  final DateTime changeDate;
  final String stfInfo;
  final String changeInfo;

  HitDutyLogListModel({
    required this.changeDate,
    required this.stfInfo,
    required this.changeInfo,
  });

  factory HitDutyLogListModel.fromJson(Map<String, dynamic> json) =>
      _$HitDutyLogListModelFromJson(json);
}
