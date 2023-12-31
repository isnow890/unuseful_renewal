import 'package:json_annotation/json_annotation.dart';
part 'hit_my_duty_model.g.dart';


abstract class HitMyDutyModelBase {}

class HitMyDutyModelLoading extends HitMyDutyModelBase {}

class HitMyDutyModelError extends HitMyDutyModelBase {
  final String message;

  HitMyDutyModelError({required this.message});
}

@JsonSerializable()
class HitMyDutyModel extends HitMyDutyModelBase {
  final List<HitMyDutyListModel> data;

  HitMyDutyModel({required this.data});

factory HitMyDutyModel.fromJson(Map<String,dynamic> json)
  =>_$HitMyDutyModelFromJson(json);
}
@JsonSerializable()
class HitMyDutyListModel {
  final String? wkMonth;
  final String? wkDate;
  final String? day;
  final String? stfNo;
  final String? stfNm;
  final String? wkSeq;
  final String? hdyYn;
  final String? dutyTypeNm;
  final String? dutyTypeCode;
  @JsonKey(includeFromJson: false, includeToJson: false)
   bool isNew = false;

  HitMyDutyListModel({
     this.wkMonth,
     this.wkDate,
     this.day,
     this.stfNo,
     this.stfNm,
     this.wkSeq,
     this.hdyYn,
     this.dutyTypeNm,
     this.dutyTypeCode,
  });

  factory HitMyDutyListModel.fromJson(Map<String,dynamic> json)
  =>_$HitMyDutyListModelFromJson(json);
}
