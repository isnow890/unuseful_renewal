// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hit_duty_schedule_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HitDutyScheduleUpdateModel _$HitDutyScheduleUpdateModelFromJson(
        Map<String, dynamic> json) =>
    HitDutyScheduleUpdateModel(
      stfNo: json['stfNo'] as String?,
      dutyTypeCodeOriginal: json['dutyTypeCodeOriginal'] as String?,
      workMonthOriginal: json['workMonthOriginal'] as String?,
      workDateOriginal: json['workDateOriginal'] as String?,
      workMonthUpdate: json['workMonthUpdate'] as String?,
      workDateUpdate: json['workDateUpdate'] as String?,
      originalName: json['originalName'] as String?,
      updateName: json['updateName'] as String?,
      wkSeqOriginal: json['wkSeqOriginal'] as String?,
      wkSeqUpdate: json['wkSeqUpdate'] as String?,
      workType: json['workType'] as String?,
      dutyTypeCodeUpdate: json['dutyTypeCodeUpdate'] as String?,
    );

Map<String, dynamic> _$HitDutyScheduleUpdateModelToJson(
        HitDutyScheduleUpdateModel instance) =>
    <String, dynamic>{
      'dutyTypeCodeOriginal': instance.dutyTypeCodeOriginal,
      'workMonthOriginal': instance.workMonthOriginal,
      'workDateOriginal': instance.workDateOriginal,
      'dutyTypeCodeUpdate': instance.dutyTypeCodeUpdate,
      'workMonthUpdate': instance.workMonthUpdate,
      'workDateUpdate': instance.workDateUpdate,
      'originalName': instance.originalName,
      'updateName': instance.updateName,
      'wkSeqOriginal': instance.wkSeqOriginal,
      'wkSeqUpdate': instance.wkSeqUpdate,
      'workType': instance.workType,
      'stfNo': instance.stfNo,
    };
