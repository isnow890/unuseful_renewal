// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hit_schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HitScheduleModel _$HitScheduleModelFromJson(Map<String, dynamic> json) =>
    HitScheduleModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => HitScheduleListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HitScheduleModelToJson(HitScheduleModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

HitScheduleListModel _$HitScheduleListModelFromJson(
        Map<String, dynamic> json) =>
    HitScheduleListModel(
      stfNmOriginal: json['stfNmOriginal'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      stfNm: json['stfNm'] as String?,
      scheduleName: json['scheduleName'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      scheduleId: json['scheduleId'] as String?,
      scheduleType: json['scheduleType'] as String?,
      dutyTypeCode: json['dutyTypeCode'] as String?,
      hdyYn: json['hdyYn'] as String?,
      wkSeq: json['wkSeq'] as String?,
    );

Map<String, dynamic> _$HitScheduleListModelToJson(
        HitScheduleListModel instance) =>
    <String, dynamic>{
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'stfNm': instance.stfNm,
      'scheduleName': instance.scheduleName,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'scheduleId': instance.scheduleId,
      'scheduleType': instance.scheduleType,
      'dutyTypeCode': instance.dutyTypeCode,
      'hdyYn': instance.hdyYn,
      'wkSeq': instance.wkSeq,
      'stfNmOriginal': instance.stfNmOriginal,
    };
