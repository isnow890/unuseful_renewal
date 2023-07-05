// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hit_schedule_at_home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HitScheduleAtHomeModel _$HitScheduleAtHomeModelFromJson(
        Map<String, dynamic> json) =>
    HitScheduleAtHomeModel(
      scheduleOfMineList: (json['scheduleOfMineList'] as List<dynamic>)
          .map((e) =>
              HitScheduleAtHomeMineModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      threeDaysList: (json['threeDaysList'] as List<dynamic>)
          .map((e) => HitScheduleAtHomeThreeDaysModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      scheduleList: (json['scheduleList'] as List<dynamic>)
          .map((e) => HitScheduleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HitScheduleAtHomeModelToJson(
        HitScheduleAtHomeModel instance) =>
    <String, dynamic>{
      'scheduleOfMineList': instance.scheduleOfMineList,
      'threeDaysList': instance.threeDaysList,
      'scheduleList': instance.scheduleList,
    };

HitScheduleAtHomeThreeDaysModel _$HitScheduleAtHomeThreeDaysModelFromJson(
        Map<String, dynamic> json) =>
    HitScheduleAtHomeThreeDaysModel(
      morningNm: json['morningNm'] as String,
      afternoonNm: json['afternoonNm'] as String,
      nightNm: json['nightNm'] as String,
      workDate: json['workDate'] as String,
      hdyYn: json['hdyYn'] as String,
    );

Map<String, dynamic> _$HitScheduleAtHomeThreeDaysModelToJson(
        HitScheduleAtHomeThreeDaysModel instance) =>
    <String, dynamic>{
      'morningNm': instance.morningNm,
      'afternoonNm': instance.afternoonNm,
      'nightNm': instance.nightNm,
      'workDate': instance.workDate,
      'hdyYn': instance.hdyYn,
    };

HitScheduleAtHomeMineModel _$HitScheduleAtHomeMineModelFromJson(
        Map<String, dynamic> json) =>
    HitScheduleAtHomeMineModel(
      workDate: json['workDate'] as String,
      dutyTypeCode: json['dutyTypeCode'] as String,
      hdyYn: json['hdyYn'] as String,
      dutyName: json['dutyName'] as String,
      prediction: json['prediction'] as bool,
    );

Map<String, dynamic> _$HitScheduleAtHomeMineModelToJson(
        HitScheduleAtHomeMineModel instance) =>
    <String, dynamic>{
      'workDate': instance.workDate,
      'dutyTypeCode': instance.dutyTypeCode,
      'hdyYn': instance.hdyYn,
      'dutyName': instance.dutyName,
      'prediction': instance.prediction,
    };
