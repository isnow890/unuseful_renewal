import 'package:json_annotation/json_annotation.dart';
import 'package:unuseful/src/common/model/model_base.dart';

part 'hit_schedule_log_model.g.dart';


@JsonSerializable()
class HitDutyLogModel extends ModelBase {
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
