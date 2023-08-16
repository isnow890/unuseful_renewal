// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hit_duty_statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HitDutyStatisticsModel _$HitDutyStatisticsModelFromJson(
        Map<String, dynamic> json) =>
    HitDutyStatisticsModel(
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              HitDutyStatisticsListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HitDutyStatisticsModelToJson(
        HitDutyStatisticsModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

HitDutyStatisticsListModel _$HitDutyStatisticsListModelFromJson(
        Map<String, dynamic> json) =>
    HitDutyStatisticsListModel(
      stfNm: json['stfNm'] as String,
      stfNo: json['stfNo'] as String,
      stfNum: json['stfNum'] as String,
      afternoonCount: json['afternoonCount'] as int,
      afternoonHour: json['afternoonHour'] as int,
      morningHolidayCount: json['morningHolidayCount'] as int,
      morningHolidayHour: json['morningHolidayHour'] as int,
      afternoonHolidayCount: json['afternoonHolidayCount'] as int,
      afternoonHolidayHour: json['afternoonHolidayHour'] as int,
      totalCount: json['totalCount'] as int,
      totalHour: json['totalHour'] as int,
      rank: json['rank'] as int,
    );

Map<String, dynamic> _$HitDutyStatisticsListModelToJson(
        HitDutyStatisticsListModel instance) =>
    <String, dynamic>{
      'stfNm': instance.stfNm,
      'stfNo': instance.stfNo,
      'stfNum': instance.stfNum,
      'afternoonCount': instance.afternoonCount,
      'afternoonHour': instance.afternoonHour,
      'morningHolidayCount': instance.morningHolidayCount,
      'morningHolidayHour': instance.morningHolidayHour,
      'afternoonHolidayCount': instance.afternoonHolidayCount,
      'afternoonHolidayHour': instance.afternoonHolidayHour,
      'totalCount': instance.totalCount,
      'totalHour': instance.totalHour,
      'rank': instance.rank,
    };
