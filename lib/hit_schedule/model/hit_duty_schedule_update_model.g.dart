// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hit_duty_schedule_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HitDutyScheduleUpdateModel _$HitDutyScheduleUpdateModelFromJson(
        Map<String, dynamic> json) =>
    HitDutyScheduleUpdateModel(
      dutyTypeCode: json['dutyTypeCode'] as String,
      workMonthOriginal: json['workMonthOriginal'] as String,
      workDateOriginal: json['workDateOriginal'] as String,
      workMonthUpdate: json['workMonthUpdate'] as String,
      workDateUpdate: json['workDateUpdate'] as String,
      originalName: json['originalName'] as String,
      updateName: json['updateName'] as String,
      wkSeqOriginal: json['wkSeqOriginal'] as String,
      wkSeqUpdate: json['wkSeqUpdate'] as String,
      hdyYn: json['hdyYn'] as String,
      workType: json['workType'] as String,
    );

Map<String, dynamic> _$HitDutyScheduleUpdateModelToJson(
        HitDutyScheduleUpdateModel instance) =>
    <String, dynamic>{
      'dutyTypeCode': instance.dutyTypeCode,
      'workMonthOriginal': instance.workMonthOriginal,
      'workDateOriginal': instance.workDateOriginal,
      'workMonthUpdate': instance.workMonthUpdate,
      'workDateUpdate': instance.workDateUpdate,
      'originalName': instance.originalName,
      'updateName': instance.updateName,
      'wkSeqOriginal': instance.wkSeqOriginal,
      'wkSeqUpdate': instance.wkSeqUpdate,
      'hdyYn': instance.hdyYn,
      'workType': instance.workType,
    };
